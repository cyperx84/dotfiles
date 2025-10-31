#!/usr/bin/env bash

# Minimal Sesh Preview Script - Fast Edition
# Only shows essential session info, no expensive operations
# Version: 3.0 (Performance optimized)

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

SESSION_INPUT="$1"

# ======================
# HELPER FUNCTIONS
# ======================

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

# Clean session input - remove ANSI color codes
SESSION_INPUT=$(echo "$SESSION_INPUT" | sed 's/\x1b\[[0-9;]*m//g; s/\[0m//g')

# Remove leading/trailing whitespace and extract session name
SESSION_CLEAN=$(echo "$SESSION_INPUT" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

# Remove icon prefixes (handle emoji and special characters)
SESSION_CLEAN=$(echo "$SESSION_CLEAN" | sed -e 's/^◆[[:space:]]*//' \
    -e 's/^●[[:space:]]*//' \
    -e 's/^◉[[:space:]]*//' \
    -e 's/^◉[[:space:]]*//' \
    -e 's/^📁[[:space:]]*//' \
    -e 's/^▣[[:space:]]*//' \
    | awk '{print $1}')
SESSION_CLEAN="${SESSION_CLEAN/#\~/$HOME}"

# ======================
# DETECTION
# ======================

get_sesh_toml_path() {
    local session_name="$1"
    local sesh_config="${HOME}/.config/sesh/sesh.toml"

    if [ ! -f "$sesh_config" ]; then
        return
    fi

    # Parse TOML to find matching session and extract path
    local in_session=0
    local session_path=""

    while IFS= read -r line; do
        # Check if we're starting a new session block
        if [[ "$line" == "[[session]]" ]]; then
            in_session=1
            session_path=""
            continue
        fi

        # Extract name from current session block
        if [[ "$in_session" == 1 ]]; then
            if [[ "$line" =~ ^name[[:space:]]*=[[:space:]]*\"(.*)\" ]]; then
                local name="${BASH_REMATCH[1]}"
                if [ "$name" = "$session_name" ]; then
                    # Found matching session, now look for path
                    while IFS= read -r path_line; do
                        if [[ "$path_line" =~ ^path[[:space:]]*=[[:space:]]*\"(.*)\" ]]; then
                            session_path="${BASH_REMATCH[1]}"
                            break
                        fi
                        if [[ "$path_line" == "[[session]]" ]]; then
                            break
                        fi
                    done
                    break
                fi
            fi
        fi
    done < "$sesh_config"

    if [ -n "$session_path" ]; then
        echo "${session_path/#\~/$HOME}"
    fi
}

detect_session_type() {
    if tmux has-session -t "$SESSION_CLEAN" 2>/dev/null; then
        echo "tmux"
    elif [ -f "$HOME/.config/tmuxinator/${SESSION_CLEAN}.yml" ]; then
        echo "tmuxinator"
    else
        # Check if it's a custom sesh.toml session BEFORE checking directory
        # (because .claude might both be a sesh.toml entry AND a valid directory)
        local sesh_path=$(get_sesh_toml_path "$SESSION_CLEAN")
        if [ -n "$sesh_path" ] && [ -d "$sesh_path" ]; then
            echo "sesh_custom"
        elif [ -d "$SESSION_CLEAN" ]; then
            echo "directory"
        else
            echo "unknown"
        fi
    fi
}

# ======================
# PREVIEW FUNCTIONS
# ======================

show_tmux_session_preview() {
    local session_name="$1"

    echo -e "${BLUE}${BOLD}● Tmux Session: ${session_name}${NC}"

    # Activity status (fast - just tmux info, no git)
    local activity=$(tmux display-message -p -t "$session_name" '#{session_activity}' 2>/dev/null)
    if [ -n "$activity" ]; then
        local now=$(date +%s)
        local since=$((now - activity))
        if [ $since -lt 300 ]; then
            echo -e "${CYAN}Status:${NC} ${GREEN}🟢 Active${NC} ($(human_time $since) ago)"
        elif [ $since -lt 3600 ]; then
            echo -e "${CYAN}Status:${NC} ${YELLOW}🟡 Idle${NC} ($(human_time $since) ago)"
        else
            echo -e "${CYAN}Status:${NC} ${RED}🔴 Stale${NC} ($(human_time $since) ago)"
        fi
    fi

    # Age
    local created=$(tmux display-message -p -t "$session_name" '#{session_created}' 2>/dev/null)
    if [ -n "$created" ]; then
        local now=$(date +%s)
        local age=$((now - created))
        echo -e "${CYAN}Age:${NC} $(human_time $age)"
    fi

    # Window and pane counts
    local window_count=$(tmux list-windows -t "$session_name" 2>/dev/null | wc -l | tr -d ' ')
    local pane_count=$(tmux list-panes -s -t "$session_name" 2>/dev/null | wc -l | tr -d ' ')
    echo -e "${CYAN}Windows:${NC} $window_count  ${CYAN}Panes:${NC} $pane_count"

    # Current path
    local current_path=$(tmux display-message -p -t "$session_name" '#{pane_current_path}' 2>/dev/null)
    if [ -n "$current_path" ]; then
        echo -e "${CYAN}Path:${NC} $current_path"
    fi

    # Live pane content preview
    echo ""
    echo -e "${CYAN}━━ Current Pane ━━${NC}"
    local active_pane=$(tmux display-message -p -t "$session_name" '#{pane_id}' 2>/dev/null)
    if [ -n "$active_pane" ]; then
        local content=$(tmux capture-pane -t "$active_pane" -p -e -J -S -30 2>/dev/null)
        if [ -n "$content" ]; then
            echo "$content" | tail -20
        else
            echo -e "${GRAY}(empty pane)${NC}"
        fi
    fi
}

show_tmuxinator_preview() {
    local session_name="$1"
    local config_file="$HOME/.config/tmuxinator/${session_name}.yml"

    if [ ! -f "$config_file" ]; then
        echo -e "${MAGENTA}◆ Tmuxinator: ${session_name}${NC}"
        echo -e "${YELLOW}⚠ Config file not found${NC}"
        return
    fi

    echo -e "${MAGENTA}${BOLD}◆ Tmuxinator Project: ${session_name}${NC}"

    # Check if session is running
    if tmux has-session -t "$session_name" 2>/dev/null; then
        echo -e "${CYAN}Status:${NC} ${GREEN}✓ Currently running${NC}"
    else
        echo -e "${CYAN}Status:${NC} ${YELLOW}○ Not running${NC}"
    fi

    # Get root directory
    local root_dir=$(grep "^root:" "$config_file" 2>/dev/null | sed 's/root: *//' | sed "s|~|$HOME|" | tr -d '"' | tr -d "'")
    if [ -n "$root_dir" ]; then
        echo -e "${CYAN}Path:${NC} $root_dir"
    fi

    echo -e "${CYAN}Config:${NC} $config_file"
}

show_sesh_custom_preview() {
    local session_name="$1"
    local dir_path=$(get_sesh_toml_path "$session_name")

    if [ -z "$dir_path" ] || [ ! -d "$dir_path" ]; then
        echo -e "${BLUE}${BOLD}◆ Sesh Config: ${session_name}${NC}"
        echo -e "${RED}⚠ Path not found or does not exist${NC}"
        return
    fi

    echo -e "${BLUE}${BOLD}◆ Sesh Config: ${session_name}${NC}"

    # Show path
    echo -e "${CYAN}Path:${NC} $dir_path"

    # Check if session is running as tmux
    if tmux has-session -t "$session_name" 2>/dev/null; then
        echo -e "${CYAN}Status:${NC} ${GREEN}✓ Running${NC}"
    else
        echo -e "${CYAN}Status:${NC} ${YELLOW}○ Not running${NC}"
    fi

    # Quick project type detection (just file existence checks, no deep scanning)
    local project_type=""
    [ -f "$dir_path/package.json" ] && project_type="Node.js"
    [ -f "$dir_path/Cargo.toml" ] && project_type="Rust"
    [ -f "$dir_path/go.mod" ] && project_type="Go"
    [ -f "$dir_path/Dockerfile" ] && project_type="Docker"

    if [ -n "$project_type" ]; then
        echo -e "${CYAN}Type:${NC} $project_type"
    fi
}

show_directory_preview() {
    local dir_path="$1"

    if [ ! -d "$dir_path" ]; then
        echo -e "${YELLOW}📁 Path: ${dir_path}${NC}"
        echo -e "${RED}⚠ Directory does not exist${NC}"
        return
    fi

    echo -e "${YELLOW}${BOLD}📁 Directory: ${dir_path}${NC}"

    # Show path
    echo -e "${CYAN}Path:${NC} $dir_path"

    # Quick project type detection (just file existence checks, no deep scanning)
    local project_type=""
    [ -f "$dir_path/package.json" ] && project_type="Node.js"
    [ -f "$dir_path/Cargo.toml" ] && project_type="Rust"
    [ -f "$dir_path/go.mod" ] && project_type="Go"
    [ -f "$dir_path/Dockerfile" ] && project_type="Docker"

    if [ -n "$project_type" ]; then
        echo -e "${CYAN}Type:${NC} $project_type"
    fi
}

# ======================
# MAIN
# ======================

SESSION_TYPE=$(detect_session_type)

case "$SESSION_TYPE" in
    "tmux")
        show_tmux_session_preview "$SESSION_CLEAN"
        ;;
    "tmuxinator")
        show_tmuxinator_preview "$SESSION_CLEAN"
        ;;
    "sesh_custom")
        show_sesh_custom_preview "$SESSION_CLEAN"
        ;;
    "directory")
        show_directory_preview "$SESSION_CLEAN"
        ;;
    *)
        echo -e "${YELLOW}Session: ${SESSION_CLEAN}${NC}"
        echo "No additional info available"
        ;;
esac
