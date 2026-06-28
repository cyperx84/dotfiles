#!/usr/bin/env bash

# Preview helper functions for sesh scripts
# Provides shared preview functionality across different session types
# Extracted from sesh_preview_fast.sh and sesh_preview.sh for reusability

# Source common utilities (for human_time, colors, etc.)
SCRIPT_DIR="$(dirname "${BASH_SOURCE[0]}")"
# shellcheck source=./sesh_common.sh
source "$SCRIPT_DIR/sesh_common.sh"

# Show tmux session preview with windows, panes, activity, and pane content
# Usage: show_tmux_session_preview <session_name>
# Displays: Status, age, window/pane counts, path, current pane content, directory preview
show_tmux_session_preview() {
    local session_name="$1"

    if [ -z "$session_name" ]; then
        echo -e "${RED}Error: Session name required${NC}"
        return 1
    fi

    if ! tmux has-session -t "$session_name" 2>/dev/null; then
        echo -e "${RED}Error: Session '$session_name' not found${NC}"
        return 1
    fi

    # Get session info in a single tmux call (optimized)
    IFS='|' read -r windows session_id path activity created < <(
        tmux display-message -p -t "$session_name" \
            '#{session_windows}|#{session_id}|#{pane_current_path}|#{session_activity}|#{session_created}' 2>/dev/null
    )

    # Calculate pane count
    local panes=$(tmux list-panes -s -t "$session_name" 2>/dev/null | wc -l | tr -d ' ')

    # Build compact single-line status with nerd font icons
    local status_icon status_color status_time=""
    if [ -n "$activity" ]; then
        local now=$(date +%s)
        local since=$((now - activity))
        status_time="$(human_time $since)"
        if [ $since -lt 300 ]; then
            status_icon="" status_color="${GREEN}"
        elif [ $since -lt 3600 ]; then
            status_icon="" status_color="${YELLOW}"
        else
            status_icon="󰒲" status_color="${RED}"
        fi
    fi

    # Compact path (replace $HOME with ~)
    local short_path="${path/#$HOME/\~}"

    # Single-line session info with clean spacing and nerd font icons
    #  session   status  time 󰖯 windows  panes  path
    echo -e "${BLUE}${BOLD} ${session_name}${NC}  ${status_color}${status_icon}${NC}  ${MAGENTA} ${status_time}${NC}  ${CYAN}󰖯 ${windows}${NC}  ${CYAN} ${panes}${NC}  ${GRAY} ${short_path}${NC}"

    # Current pane content preview
    echo ""
    echo -e "${CYAN} ─────────────────────────────────────${NC}"
    local active_pane=$(tmux display-message -p -t "$session_name" '#{pane_id}' 2>/dev/null)
    if [ -n "$active_pane" ]; then
        local content=$(tmux capture-pane -t "$active_pane" -p -e -J -S -50 2>/dev/null)
        if [ -n "$content" ]; then
            echo "$content" | tail -40
        else
            echo -e "${GRAY}(empty pane)${NC}"
        fi
    fi

    # Directory preview
    if [ -n "$path" ] && [ -d "$path" ]; then
        echo ""
        echo -e "${CYAN} ─────────────────────────────────────${NC}"
        if command -v eza &> /dev/null; then
            eza --icons --color=always --group-directories-first -a -l "$path" 2>/dev/null | head -8
        else
            ls -lA "$path" 2>/dev/null | head -8
        fi
    fi
}

# Show tmuxinator project preview with config details and directory
# Usage: show_tmuxinator_preview <session_name>
# Displays: Status (running/not running), window/pane counts, root path, directory preview
show_tmuxinator_preview() {
    local session_name="$1"
    local config_file="$HOME/.config/tmuxinator/${session_name}.yml"

    if [ -z "$session_name" ]; then
        echo -e "${RED}Error: Session name required${NC}"
        return 1
    fi

    if [ ! -f "$config_file" ]; then
        echo -e "${MAGENTA}${BOLD}▣ Tmuxinator: ${session_name}${NC}"
        echo -e "${RED}⚠ Config file not found: $config_file${NC}"
        return 1
    fi

    echo -e "${MAGENTA}${BOLD}▣ Tmuxinator Project: ${session_name}${NC}"

    # Check if session is running
    local is_running=false
    if tmux has-session -t "$session_name" 2>/dev/null; then
        is_running=true
        echo -e "${CYAN}Status:${NC} ${GREEN}✓ Currently running${NC}"

        # Show live window and pane counts
        local window_count=$(tmux list-windows -t "$session_name" 2>/dev/null | wc -l | tr -d ' ')
        local pane_count=$(tmux list-panes -s -t "$session_name" 2>/dev/null | wc -l | tr -d ' ')
        echo -e "${CYAN}Windows:${NC} $window_count  ${CYAN}Panes:${NC} $pane_count"
    else
        echo -e "${CYAN}Status:${NC} ${YELLOW}○ Not running${NC}"

        # Count configured windows from tmuxinator config
        local window_count=$(grep -c "^  - " "$config_file" 2>/dev/null || echo "1")
        echo -e "${CYAN}Configured:${NC} $window_count window(s)"
    fi

    # Extract root directory from config
    local root_dir=$(grep "^root:" "$config_file" 2>/dev/null | \
        sed 's/root: *//' | \
        sed "s|~|$HOME|" | \
        tr -d '"' | \
        tr -d "'")

    if [ -n "$root_dir" ]; then
        echo -e "${CYAN}Path:${NC} $root_dir"
    fi

    # Show pane content if session is running
    if [ "$is_running" = true ]; then
        echo ""
        echo -e "${CYAN}━━ Current Pane ━━${NC}"
        local active_pane=$(tmux display-message -p -t "$session_name" '#{pane_id}' 2>/dev/null)
        if [ -n "$active_pane" ]; then
            local content=$(tmux capture-pane -t "$active_pane" -p -e -J -S -50 2>/dev/null)
            if [ -n "$content" ]; then
                echo "$content" | tail -40
            else
                echo -e "${GRAY}(empty pane)${NC}"
            fi
        fi
    fi

    # Always show directory preview
    if [ -n "$root_dir" ] && [ -d "$root_dir" ]; then
        echo ""
        echo -e "${CYAN}━━ Directory Preview ━━${NC}"
        if command -v eza &> /dev/null; then
            eza --icons --color=always --group-directories-first -a -l "$root_dir" 2>/dev/null | head -8
        else
            ls -lA "$root_dir" 2>/dev/null | head -8
        fi
    fi
}

# Show directory preview with file listing
# Usage: show_directory_preview <directory_path>
# Displays: Directory status and file listing (with eza or ls fallback)
show_directory_preview() {
    local dir_path="$1"

    if [ -z "$dir_path" ]; then
        echo -e "${RED}Error: Directory path required${NC}"
        return 1
    fi

    if [ ! -d "$dir_path" ]; then
        echo -e "${YELLOW}${BOLD}📁 Path: ${dir_path}${NC}"
        echo -e "${RED}⚠ Directory does not exist${NC}"
        return 1
    fi

    echo -e "${YELLOW}${BOLD}📁 Directory: ${dir_path}${NC}"

    echo -e "${CYAN}Status:${NC} ${YELLOW}○ Not a session${NC}"
    echo -e "${CYAN}Will create:${NC} 1 window, 1 pane"
    echo -e "${CYAN}Path:${NC} $dir_path"

    # Always show directory preview
    echo ""
    echo -e "${CYAN}━━ Directory Preview ━━${NC}"
    if command -v eza &> /dev/null; then
        eza --icons --color=always --group-directories-first -a -l "$dir_path" 2>/dev/null | head -8
    else
        ls -lA "$dir_path" 2>/dev/null | head -8
    fi
}

# Show "no session found" message
# Usage: show_no_session_preview <session_name>
# Displays: Generic message for unknown/invalid sessions
show_no_session_preview() {
    local session_name="$1"

    if [ -z "$session_name" ]; then
        echo -e "${GRAY}No session specified${NC}"
        echo "No additional info available"
        return 1
    fi

    echo -e "${GRAY}${BOLD}Session: ${session_name}${NC}"
    echo -e "${YELLOW}Type: Custom or unknown${NC}"
    echo "No additional info available"
}

# Get sesh.toml path for a custom session
# Usage: get_sesh_toml_path <session_name>
# Returns: Path configured in sesh.toml, or empty if not found
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

# Show sesh custom session preview (from sesh.toml config)
# Usage: show_sesh_custom_preview <session_name>
# Displays: Status, window/pane counts, path, directory preview
show_sesh_custom_preview() {
    local session_name="$1"
    local dir_path=$(get_sesh_toml_path "$session_name")

    if [ -z "$dir_path" ] || [ ! -d "$dir_path" ]; then
        echo -e "${BLUE}${BOLD}◆ Sesh Config: ${session_name}${NC}"
        echo -e "${RED}⚠ Path not found or does not exist${NC}"
        return 1
    fi

    echo -e "${BLUE}${BOLD}◆ Sesh Config: ${session_name}${NC}"

    # Check if session is running as tmux
    local is_running=false
    if tmux has-session -t "$session_name" 2>/dev/null; then
        is_running=true
        echo -e "${CYAN}Status:${NC} ${GREEN}✓ Running${NC}"

        # Show live window and pane counts
        local window_count=$(tmux list-windows -t "$session_name" 2>/dev/null | wc -l | tr -d ' ')
        local pane_count=$(tmux list-panes -s -t "$session_name" 2>/dev/null | wc -l | tr -d ' ')
        echo -e "${CYAN}Windows:${NC} $window_count  ${CYAN}Panes:${NC} $pane_count"
    else
        echo -e "${CYAN}Status:${NC} ${YELLOW}○ Not running${NC}"
        echo -e "${CYAN}Will create:${NC} 1 window, 1 pane"
    fi

    # Show path
    echo -e "${CYAN}Path:${NC} $dir_path"

    # Show pane content if session is running
    if [ "$is_running" = true ]; then
        echo ""
        echo -e "${CYAN}━━ Current Pane ━━${NC}"
        local active_pane=$(tmux display-message -p -t "$session_name" '#{pane_id}' 2>/dev/null)
        if [ -n "$active_pane" ]; then
            local content=$(tmux capture-pane -t "$active_pane" -p -e -J -S -50 2>/dev/null)
            if [ -n "$content" ]; then
                echo "$content" | tail -40
            else
                echo -e "${GRAY}(empty pane)${NC}"
            fi
        fi
    fi

    # Always show directory preview
    echo ""
    echo -e "${CYAN}━━ Directory Preview ━━${NC}"
    if command -v eza &> /dev/null; then
        eza --icons --color=always --group-directories-first -a -l "$dir_path" 2>/dev/null | head -8
    else
        ls -lA "$dir_path" 2>/dev/null | head -8
    fi
}
