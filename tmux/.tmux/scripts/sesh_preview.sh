#!/usr/bin/env bash

# Enhanced Sesh Preview Script
# Comprehensive session preview with live content, git status, process info, and more
# Version: 2.0

# Color definitions
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
GRAY='\033[0;90m'
BOLD='\033[1m'
NC='\033[0m'

# Box drawing characters
BOX_H="─"
BOX_V="│"
BOX_TL="╭"
BOX_TR="╮"
BOX_BL="╰"
BOX_BR="╯"
BOX_ML="├"
BOX_MR="┤"

SESSION_INPUT="$1"

# ======================
# HELPER FUNCTIONS
# ======================

draw_line() {
    local width=${1:-50}
    printf "${BOX_ML}${BOX_H}%.0s" $(seq 1 $width)
    printf "${BOX_MR}\n"
}

draw_header() {
    local text="$1"
    local width=50
    echo -e "${CYAN}${BOLD}${text}${NC}"
}

draw_section() {
    local title="$1"
    echo -e "\n${CYAN}${BOX_ML}${BOX_H} ${title} ${BOX_H}${BOX_MR}${NC}"
}

progress_bar() {
    local percent=$1
    local width=10
    local filled=$((percent * width / 100))
    local empty=$((width - filled))

    printf "["
    printf "█%.0s" $(seq 1 $filled)
    printf "░%.0s" $(seq 1 $empty)
    printf "] %3d%%" "$percent"
}

human_time() {
    local seconds=$1
    if [ $seconds -lt 60 ]; then
        echo "${seconds}s"
    elif [ $seconds -lt 3600 ]; then
        echo "$((seconds / 60))m"
    elif [ $seconds -lt 86400 ]; then
        echo "$((seconds / 3600))h $((seconds % 3600 / 60))m"
    else
        echo "$((seconds / 86400))d $((seconds % 86400 / 3600))h"
    fi
}

# Clean session input
SESSION_CLEAN=$(echo "$SESSION_INPUT" | sed 's/\x1b\[[0-9;]*m//g' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
SESSION_CLEAN=$(echo "$SESSION_CLEAN" | sed 's/^[◆▣📁📂🔷🔶⬢●◉○] *//')
SESSION_CLEAN="${SESSION_CLEAN/#\~/$HOME}"

# ======================
# DETECTION FUNCTIONS
# ======================

detect_session_type() {
    if [[ "$SESSION_CLEAN" =~ ^tmuxinator: ]]; then
        echo "tmuxinator"
    elif tmux has-session -t "$SESSION_CLEAN" 2>/dev/null; then
        echo "tmux"
    elif [ -f "$HOME/.config/tmuxinator/${SESSION_CLEAN}.yml" ]; then
        echo "tmuxinator"
    elif [ -d "$SESSION_CLEAN" ]; then
        echo "directory"
    else
        echo "unknown"
    fi
}

detect_project_type() {
    local dir="$1"
    local types=()

    [ -f "$dir/package.json" ] && types+=("Node.js")
    [ -f "$dir/Cargo.toml" ] && types+=("Rust")
    [ -f "$dir/go.mod" ] && types+=("Go")
    [ -f "$dir/requirements.txt" ] || [ -f "$dir/pyproject.toml" ] && types+=("Python")
    [ -f "$dir/Gemfile" ] && types+=("Ruby")
    [ -f "$dir/pom.xml" ] || [ -f "$dir/build.gradle" ] && types+=("Java")
    [ -f "$dir/Dockerfile" ] && types+=("Docker")
    [ -f "$dir/docker-compose.yml" ] && types+=("Docker Compose")

    if [ ${#types[@]} -eq 0 ]; then
        echo "Generic"
    else
        printf "%s" "${types[@]}" | tr ' ' '+'
    fi
}

get_running_ports() {
    local pids="$1"
    if [ -n "$pids" ]; then
        # Convert PIDs to grep pattern, handle single PID case
        local pid_pattern=$(echo "$pids" | tr ' ' '|' | sed 's/|$//' | sed 's/^|//')
        if [ -n "$pid_pattern" ]; then
            lsof -iTCP -sTCP:LISTEN -n -P 2>/dev/null | grep -E "${pid_pattern}" 2>/dev/null | awk '{print $9}' | cut -d: -f2 | sort -u | head -5
        fi
    fi
}

get_session_age() {
    local session_name="$1"
    local created=$(tmux display-message -p -t "$session_name" '#{session_created}' 2>/dev/null)
    if [ -n "$created" ]; then
        local now=$(date +%s)
        local age=$((now - created))
        human_time $age
    else
        echo "N/A"
    fi
}

get_activity_status() {
    local session_name="$1"
    local activity=$(tmux display-message -p -t "$session_name" '#{session_activity}' 2>/dev/null)
    if [ -n "$activity" ]; then
        local now=$(date +%s)
        local since=$((now - activity))
        if [ $since -lt 300 ]; then
            echo -e "${GREEN}🟢 Active${NC} ($(human_time $since) ago)"
        elif [ $since -lt 3600 ]; then
            echo -e "${YELLOW}🟡 Idle${NC} ($(human_time $since) ago)"
        else
            echo -e "${RED}🔴 Stale${NC} ($(human_time $since) ago)"
        fi
    else
        echo -e "${GRAY}⚪ Unknown${NC}"
    fi
}

# ======================
# GIT FUNCTIONS
# ======================

show_git_status() {
    local dir="$1"
    if [ ! -d "$dir/.git" ]; then
        return
    fi

    cd "$dir" 2>/dev/null || return

    draw_section "Git Status"

    # Branch info
    local branch=$(git branch --show-current 2>/dev/null)
    local remote_status=""
    if [ -n "$branch" ]; then
        local ahead=$(git rev-list --count @{u}..HEAD 2>/dev/null || echo "0")
        local behind=$(git rev-list --count HEAD..@{u} 2>/dev/null || echo "0")

        if [ "$ahead" -gt 0 ] && [ "$behind" -gt 0 ]; then
            remote_status=" ${YELLOW}↑${ahead} ↓${behind}${NC}"
        elif [ "$ahead" -gt 0 ]; then
            remote_status=" ${GREEN}↑${ahead}${NC}"
        elif [ "$behind" -gt 0 ]; then
            remote_status=" ${RED}↓${behind}${NC}"
        fi
    fi

    echo -e "${CYAN}Branch:${NC} ${branch:-"(detached)"}${remote_status}"

    # Changes
    local staged=$(git diff --cached --numstat 2>/dev/null | wc -l | tr -d ' ')
    local modified=$(git diff --numstat 2>/dev/null | wc -l | tr -d ' ')
    local untracked=$(git ls-files --others --exclude-standard 2>/dev/null | wc -l | tr -d ' ')

    if [ "$staged" -gt 0 ] || [ "$modified" -gt 0 ] || [ "$untracked" -gt 0 ]; then
        echo -ne "${CYAN}Changes:${NC} "
        [ "$staged" -gt 0 ] && echo -ne "${GREEN}+${staged} staged${NC} "
        [ "$modified" -gt 0 ] && echo -ne "${YELLOW}~${modified} modified${NC} "
        [ "$untracked" -gt 0 ] && echo -ne "${RED}?${untracked} untracked${NC}"
        echo ""
    else
        echo -e "${CYAN}Changes:${NC} ${GREEN}✓ Clean${NC}"
    fi

    # Last commit
    local last_commit=$(git log -1 --pretty=format:"%h %s" 2>/dev/null)
    local last_author=$(git log -1 --pretty=format:"%an" 2>/dev/null)
    local commit_time=$(git log -1 --pretty=format:"%ar" 2>/dev/null)

    if [ -n "$last_commit" ]; then
        echo -e "${CYAN}Last:${NC} ${last_commit}"
        echo -e "${CYAN}By:${NC} ${last_author} ${GRAY}(${commit_time})${NC}"
    fi

    # Git graph mini-view
    if command -v git &>/dev/null; then
        echo ""
        echo -e "${CYAN}Recent commits:${NC}"
        git log --oneline --graph --color=always --max-count=5 2>/dev/null | sed 's/^/  /'
    fi
}

# ======================
# TMUX SESSION FUNCTIONS
# ======================

show_tmux_session_preview() {
    local session_name="$1"

    # Header
    echo -e "${BLUE}${BOLD}● Tmux Session: ${session_name}${NC}"

    # Activity status
    local activity_status=$(get_activity_status "$session_name")
    local age=$(get_session_age "$session_name")
    echo -e "${CYAN}Status:${NC} ${activity_status}  ${CYAN}Age:${NC} ${age}"

    # Window and pane counts
    local window_count=$(tmux list-windows -t "$session_name" 2>/dev/null | wc -l | tr -d ' ')
    local pane_count=$(tmux list-panes -s -t "$session_name" 2>/dev/null | wc -l | tr -d ' ')
    echo -e "${CYAN}Windows:${NC} $window_count  ${CYAN}Panes:${NC} $pane_count"

    # Get PIDs for process/port detection
    local pids=$(tmux list-panes -s -t "$session_name" -F "#{pane_pid}" 2>/dev/null | tr '\n' ' ')

    # Show listening ports
    if [ -n "$pids" ]; then
        local ports=$(get_running_ports "$pids")
        if [ -n "$ports" ]; then
            draw_section "Active Ports"
            echo "$ports" | while read port; do
                echo -e "  ${GREEN}🌐${NC} localhost:$port"
            done
        fi
    fi

    # Show running processes
    if [ -n "$pids" ]; then
        draw_section "Running Processes"
        for pid in $pids; do
            ps -p $pid -o command= 2>/dev/null | head -1 | cut -c1-60 | sed 's/^/  /'
        done | sort -u | head -5
    fi

    # Smart window preview
    draw_section "Windows"
    local current_window=$(tmux display-message -p -t "$session_name" '#{window_index}' 2>/dev/null)
    tmux list-windows -t "$session_name" -F "#{window_index}:#{window_name}:#{window_panes}:#{pane_current_command}:#{pane_current_path}" 2>/dev/null | while IFS=: read idx name panes cmd path; do
        local marker="  "
        local color="$NC"
        if [ "$idx" = "$current_window" ]; then
            marker="► "
            color="$GREEN"
        fi

        # Context-aware icon
        local icon="📄"
        case "$cmd" in
            nvim|vim) icon="📝" ;;
            node|npm) icon="🟢" ;;
            python*) icon="🐍" ;;
            cargo|rust*) icon="🦀" ;;
            docker) icon="🐳" ;;
            git|lazygit) icon="🔀" ;;
            zsh|bash) icon="💻" ;;
        esac

        echo -e "  ${color}${marker}${idx}: ${icon} ${name}${NC} ${GRAY}(${panes} panes)${NC}"
        echo -e "    ${GRAY}${path}${NC}" | cut -c1-70
    done

    # Live pane content preview
    draw_section "Current Pane Preview"
    local active_pane=$(tmux display-message -p -t "$session_name" '#{pane_id}' 2>/dev/null)
    if [ -n "$active_pane" ]; then
        # Capture last 10 lines from active pane
        local content=$(tmux capture-pane -t "$session_name:$active_pane" -p -e -J -S -10 2>/dev/null)
        if [ -n "$content" ]; then
            # Try to syntax highlight with bat if available
            if command -v bat &>/dev/null; then
                echo "$content" | bat --style=plain --color=always --line-range :10 2>/dev/null || echo "$content"
            else
                echo "$content" | sed 's/^/  /'
            fi
        else
            echo "  ${GRAY}(empty pane)${NC}"
        fi
    fi

    # Show current path and directory contents
    local current_path=$(tmux display-message -p -t "$session_name" '#{pane_current_path}' 2>/dev/null)
    if [ -n "$current_path" ] && [ -d "$current_path" ]; then
        draw_section "Current Directory"
        echo -e "${CYAN}Path:${NC} $current_path"

        # Project type detection
        local project_type=$(detect_project_type "$current_path")
        if [ "$project_type" != "Generic" ]; then
            echo -e "${CYAN}Type:${NC} $project_type"
        fi

        # Show git status if repo
        show_git_status "$current_path"

        # Recent file activity
        if command -v fd &>/dev/null; then
            local recent_files=$(fd -t f -d 2 --changed-within 1h . "$current_path" 2>/dev/null | head -5)
            if [ -n "$recent_files" ]; then
                draw_section "Recently Modified (<1h)"
                echo "$recent_files" | while read file; do
                    echo -e "  ${YELLOW}📝${NC} $(basename "$file")"
                done
            fi
        fi

        # Directory contents
        echo ""
        echo -e "${CYAN}Contents:${NC}"
        if command -v eza &>/dev/null; then
            eza --all --git --icons --color=always --group-directories-first --level=1 "$current_path" 2>/dev/null | head -15
        else
            ls -lah --color=always "$current_path" 2>/dev/null | head -15
        fi
    fi
}

# ======================
# TMUXINATOR FUNCTIONS
# ======================

show_tmuxinator_preview() {
    local session_name="$1"
    local config_file="$HOME/.config/tmuxinator/${session_name}.yml"

    if [ ! -f "$config_file" ]; then
        echo -e "${MAGENTA}◆ Tmuxinator: ${session_name}${NC}"
        echo -e "${YELLOW}⚠ Config file not found${NC}"
        return
    fi

    # Header
    echo -e "${MAGENTA}${BOLD}◆ Tmuxinator Project: ${session_name}${NC}"

    # Check if session is running
    local is_running=false
    if tmux has-session -t "$session_name" 2>/dev/null; then
        is_running=true
        echo -e "${CYAN}Status:${NC} ${GREEN}✓ Currently running${NC}"
    else
        echo -e "${CYAN}Status:${NC} ${YELLOW}○ Not running${NC}"
    fi

    echo -e "${CYAN}Config:${NC} $config_file"

    # Parse YAML configuration
    draw_section "Configuration"
    grep -E "^(name|root|startup_window|on_project_start|on_project_stop):" "$config_file" 2>/dev/null | while IFS=: read key value; do
        echo -e "  ${CYAN}${key}:${NC}${value}"
    done

    # Show window structure
    draw_section "Windows Layout"
    local window_num=0
    grep -E "^  - [a-zA-Z]" "$config_file" 2>/dev/null | while read line; do
        window_num=$((window_num + 1))
        local window_name=$(echo "$line" | sed 's/^  - //')
        echo -e "  ${MAGENTA}${window_num}:${NC} $window_name"

        # Try to extract layout and panes
        local next_lines=$(sed -n "/  - ${window_name}/,/^  -/p" "$config_file" | head -10)
        echo "$next_lines" | grep -E "layout:|panes:" | sed 's/^/    /' | sed "s/^/  ${GRAY}/" | sed "s/$/${NC}/"
    done | head -20

    # Show root directory
    local root_dir=$(grep "^root:" "$config_file" 2>/dev/null | sed 's/root: *//' | sed "s|~|$HOME|" | tr -d '"' | tr -d "'")
    if [ -n "$root_dir" ] && [ -d "$root_dir" ]; then
        draw_section "Project Root"
        echo -e "${CYAN}Path:${NC} $root_dir"

        # Project type
        local project_type=$(detect_project_type "$root_dir")
        if [ "$project_type" != "Generic" ]; then
            echo -e "${CYAN}Type:${NC} $project_type"
        fi

        # Git status
        show_git_status "$root_dir"

        # Directory preview
        echo ""
        if command -v eza &>/dev/null; then
            eza --all --git --icons --tree --level=2 --color=always "$root_dir" 2>/dev/null | head -20
        else
            ls -lah "$root_dir" 2>/dev/null | head -15
        fi
    fi

    # If session is running, show live info
    if $is_running; then
        draw_section "Live Session Info"
        show_tmux_session_preview "$session_name"
    fi
}

# ======================
# DIRECTORY FUNCTIONS
# ======================

show_directory_preview() {
    local dir_path="$1"

    if [ ! -d "$dir_path" ]; then
        echo -e "${YELLOW}📁 Path: ${dir_path}${NC}"
        echo -e "${RED}⚠ Directory does not exist${NC}"
        return
    fi

    # Header
    echo -e "${YELLOW}${BOLD}📁 Directory: ${dir_path}${NC}"

    # Project type detection
    local project_type=$(detect_project_type "$dir_path")
    if [ "$project_type" != "Generic" ]; then
        echo -e "${CYAN}Type:${NC} $project_type"

        # Project-specific info
        case "$project_type" in
            *Node.js*)
                if [ -f "$dir_path/package.json" ]; then
                    local pkg_name=$(grep '"name"' "$dir_path/package.json" | head -1 | sed 's/.*"name": *"\(.*\)".*/\1/')
                    local pkg_version=$(grep '"version"' "$dir_path/package.json" | head -1 | sed 's/.*"version": *"\(.*\)".*/\1/')
                    [ -n "$pkg_name" ] && echo -e "${CYAN}Package:${NC} $pkg_name v$pkg_version"

                    # Show available scripts
                    local scripts=$(grep -A 20 '"scripts"' "$dir_path/package.json" | grep '":' | head -5 | sed 's/.*"\(.*\)": .*/\1/' | tr '\n' ', ')
                    [ -n "$scripts" ] && echo -e "${CYAN}Scripts:${NC} ${scripts%,}"
                fi
                ;;
            *Python*)
                # Check for venv
                if [ -d "$dir_path/venv" ] || [ -d "$dir_path/.venv" ]; then
                    echo -e "${CYAN}Venv:${NC} ${GREEN}✓ Present${NC}"
                fi
                ;;
            *Rust*)
                if [ -f "$dir_path/Cargo.toml" ]; then
                    local pkg_name=$(grep '^name' "$dir_path/Cargo.toml" | head -1 | sed 's/name = "\(.*\)"/\1/')
                    [ -n "$pkg_name" ] && echo -e "${CYAN}Crate:${NC} $pkg_name"
                fi
                ;;
        esac
    fi

    # Git status
    show_git_status "$dir_path"

    # Recent file activity
    if command -v fd &>/dev/null; then
        local recent_files=$(fd -t f -d 2 --changed-within 2h . "$dir_path" 2>/dev/null | head -5)
        if [ -n "$recent_files" ]; then
            draw_section "Recently Modified (<2h)"
            echo "$recent_files" | while read file; do
                local mtime=$(stat -f "%Sm" -t "%H:%M" "$file" 2>/dev/null)
                echo -e "  ${YELLOW}📝${NC} $(basename "$file") ${GRAY}(${mtime})${NC}"
            done
        fi
    fi

    # Check for running Docker containers in this directory
    if command -v docker &>/dev/null && [ -f "$dir_path/docker-compose.yml" ]; then
        local containers=$(docker ps --filter "label=com.docker.compose.project=$(basename "$dir_path")" --format "{{.Names}}" 2>/dev/null | head -3)
        if [ -n "$containers" ]; then
            draw_section "Docker Containers"
            echo "$containers" | while read container; do
                echo -e "  ${BLUE}🐳${NC} $container"
            done
        fi
    fi

    # Directory contents
    draw_section "Directory Contents"
    if command -v eza &>/dev/null; then
        eza --all --git --icons --tree --level=2 --color=always --group-directories-first "$dir_path" 2>/dev/null | head -25
    else
        ls -lah --color=always "$dir_path" 2>/dev/null | head -20
    fi
}

# ======================
# MAIN LOGIC
# ======================

SESSION_TYPE=$(detect_session_type)

# Extract session name
case "$SESSION_TYPE" in
    "tmuxinator")
        SESSION_NAME="${SESSION_CLEAN#tmuxinator:}"
        ;;
    "tmux")
        SESSION_NAME="$SESSION_CLEAN"
        ;;
    *)
        SESSION_NAME="$SESSION_CLEAN"
        ;;
esac

# Display appropriate preview
case "$SESSION_TYPE" in
    "tmux")
        show_tmux_session_preview "$SESSION_NAME"
        ;;
    "tmuxinator")
        show_tmuxinator_preview "$SESSION_NAME"
        ;;
    "directory")
        show_directory_preview "$SESSION_NAME"
        ;;
    *)
        echo -e "${YELLOW}Session: ${SESSION_NAME}${NC}"
        echo ""
        echo "No preview available for this session type"
        ;;
esac
