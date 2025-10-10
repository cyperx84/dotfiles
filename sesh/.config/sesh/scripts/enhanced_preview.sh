#!/usr/bin/env bash

# Enhanced Preview Script for Sesh Session Manager
# Provides detailed, contextual previews with visual status indicators
# Works EVERYWHERE - inside or outside tmux

set -euo pipefail

# Strip ANSI color codes, quotes, apostrophes, and trim whitespace from session name
session_name=$(echo "$1" | sed -e 's/\x1b\[[0-9;]*m//g' -e "s/['\"]//g" -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')

# Color definitions
RED='\033[0;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
MAGENTA='\033[1;35m'
CYAN='\033[1;36m'
BOLD='\033[1m'
DIM='\033[2m'
NC='\033[0m' # No Color

# Box drawing characters - removed for cleaner display
BOX_TOP=""
BOX_SEP=""
BOX_BOT=""
BOX_SIDE=""

# Status symbols
SYMBOL_ACTIVE_ATTACHED="●"  # Filled circle - active and attached
SYMBOL_ACTIVE_DETACHED="◉"  # Fisheye - active but detached
SYMBOL_INACTIVE="○"          # Empty circle - not running
SYMBOL_TEMPLATE="◆"          # Diamond - tmuxinator template
SYMBOL_PATH="📂"             # Folder - zoxide path
SYMBOL_CHECK="✓"             # Check mark
SYMBOL_WINDOW="◇"            # Diamond outline
SYMBOL_ACTIVE_WINDOW="▶"     # Play symbol

# ============================================================================
# UNIVERSAL STATUS DETECTION - Works anywhere (inside/outside tmux)
# ============================================================================

get_session_status() {
    local session_name="$1"

    # Check if tmux is running at all
    if ! tmux list-sessions 2>/dev/null | grep -q "^"; then
        echo "INACTIVE|${SYMBOL_INACTIVE}|${YELLOW}||"
        return
    fi

    # Extract the text part (remove emojis and special chars for flexible matching)
    local session_text=$(echo "$session_name" | sed -E 's/[^A-Za-z0-9 _-]//g' | xargs)

    # Try to find session by exact match or text-based matching (handles emoji rendering differences)
    local found_session=""
    while IFS=: read -r tmux_session_name rest; do
        local tmux_text=$(echo "$tmux_session_name" | sed -E 's/[^A-Za-z0-9 _-]//g' | xargs)

        # Check for exact match, text match, or suffix match (handles emoji differences)
        if [[ "$tmux_session_name" == "$session_name" ]] || \
           [[ -n "$session_text" && "$tmux_text" == "$session_text" ]] || \
           [[ "$tmux_session_name" =~ [[:space:]]${session_name}$ ]] || \
           [[ "$tmux_session_name" =~ ${session_name}$ ]]; then
            found_session="$tmux_session_name"
            break
        fi
    done < <(tmux list-sessions -F "#{session_name}:#{session_attached}:#{session_created}" 2>/dev/null)

    if [[ -n "$found_session" ]]; then
        # Get session details
        local session_info=$(tmux list-sessions -F "#{session_name}|#{session_attached}|#{session_created}" 2>/dev/null | grep "^${found_session}|")
        IFS='|' read -r sess_name attached created <<< "$session_info"

        if [[ "$attached" == "1" ]]; then
            echo "ACTIVE (ATTACHED)|${SYMBOL_ACTIVE_ATTACHED}|${GREEN}|${created}|${found_session}"
        else
            echo "ACTIVE (DETACHED)|${SYMBOL_ACTIVE_DETACHED}|${CYAN}|${created}|${found_session}"
        fi
    else
        echo "INACTIVE|${SYMBOL_INACTIVE}|${YELLOW}||"
    fi
}

get_tmuxinator_status() {
    local project="$1"

    # Extract text part for flexible matching
    local project_text=$(echo "$project" | sed -E 's/[^A-Za-z0-9 _-]//g' | xargs)

    # Check if a session with this project name exists (handle emoji rendering differences)
    local found_session=""
    while IFS=: read -r tmux_session_name rest; do
        local tmux_text=$(echo "$tmux_session_name" | sed -E 's/[^A-Za-z0-9 _-]//g' | xargs)

        if [[ "$tmux_session_name" == "$project" ]] || \
           [[ -n "$project_text" && "$tmux_text" == "$project_text" ]] || \
           [[ "$tmux_session_name" =~ [[:space:]]${project}$ ]] || \
           [[ "$tmux_session_name" =~ ${project}$ ]]; then
            found_session="$tmux_session_name"
            break
        fi
    done < <(tmux list-sessions -F "#{session_name}:#{session_attached}:#{session_created}" 2>/dev/null)

    if [[ -n "$found_session" ]]; then
        local session_info=$(tmux list-sessions -F "#{session_name}|#{session_attached}|#{session_created}" 2>/dev/null | grep "^${found_session}|")
        IFS='|' read -r sess_name attached created <<< "$session_info"

        if [[ "$attached" == "1" ]]; then
            echo "ACTIVE (ATTACHED)|${SYMBOL_ACTIVE_ATTACHED}|${GREEN}|${created}|${found_session}"
        else
            echo "ACTIVE (DETACHED)|${SYMBOL_ACTIVE_DETACHED}|${CYAN}|${created}|${found_session}"
        fi
    else
        echo "TEMPLATE|${SYMBOL_TEMPLATE}|${MAGENTA}||"
    fi
}

# ============================================================================
# UTILITY FUNCTIONS
# ============================================================================

format_uptime() {
    local created="$1"
    [[ -z "$created" ]] && return

    local now=$(date +%s)
    local diff=$((now - created))

    local days=$((diff / 86400))
    local hours=$(((diff % 86400) / 3600))
    local mins=$(((diff % 3600) / 60))

    if [[ $days -gt 0 ]]; then
        echo "${days}d ${hours}h"
    elif [[ $hours -gt 0 ]]; then
        echo "${hours}h ${mins}m"
    else
        echo "${mins}m"
    fi
}

# ============================================================================
# STATUS BADGE RENDERING
# ============================================================================

show_status_badge() {
    local status_line="$1"
    local session_type="$2"
    local session_name="$3"

    IFS='|' read -r status symbol color created found_name <<< "$status_line"

    echo -e "${BOX_TOP}"
    echo -e "${BOX_SIDE} ${color}[${symbol}] ${status}${NC} - ${session_type}"
    echo -e "${BOX_SIDE} ${BOLD}${session_name}${NC}"

    # Show uptime if session is active
    if [[ -n "$created" ]]; then
        local uptime=$(format_uptime "$created")
        [[ -n "$uptime" ]] && echo -e "${BOX_SIDE} ${DIM}⏱  Uptime: ${uptime}${NC}"
    fi

    echo -e "${BOX_SEP}"
}

show_box_section() {
    local title="$1"
    local color="${2:-$BLUE}"
    echo -e "${BOX_SIDE} ${color}${title}${NC}"
}

show_box_item() {
    local symbol="$1"
    local label="$2"
    local value="$3"
    local color="${4:-$NC}"

    if [[ -n "$value" ]]; then
        echo -e "${BOX_SIDE}   ${symbol} ${label}: ${color}${value}${NC}"
    fi
}

show_box_bullet() {
    local symbol="$1"
    local text="$2"
    local color="${3:-$NC}"
    echo -e "${BOX_SIDE}   ${symbol} ${color}${text}${NC}"
}

show_box_end() {
    echo -e "${BOX_BOT}"
}

# ============================================================================
# TMUXINATOR PROJECT PREVIEW
# ============================================================================

show_tmuxinator_preview() {
    local project="$1"
    local config_file="$HOME/.config/tmuxinator/${project}.yml"

    # Get status
    local status_line=$(get_tmuxinator_status "$project")

    # Show status badge
    show_status_badge "$status_line" "🎛️  TMUXINATOR" "$project"

    if [[ ! -f "$config_file" ]]; then
        show_box_section "❌ Configuration Not Found" "$RED"
        show_box_item "📁" "Expected" "$config_file" "$DIM"
        show_box_end
        return
    fi

    # Extract configuration details
    local name=$(grep "^name:" "$config_file" 2>/dev/null | cut -d: -f2- | xargs)
    local root=$(grep "^root:" "$config_file" 2>/dev/null | cut -d: -f2- | xargs)
    # Expand tilde in root path
    root="${root/#\~/$HOME}"

    # Configuration section
    show_box_section "📄 Configuration" "$YELLOW"
    show_box_item "📝" "Config" "${config_file/#$HOME/~}" "$DIM"
    [[ -n "$root" ]] && show_box_item "📂" "Root" "${root/#$HOME/~}"

    # Windows section
    echo -e "${BOX_SIDE}"
    show_box_section "🪟 Windows" "$YELLOW"

    local window_count=0
    while IFS= read -r line; do
        if [[ "$line" =~ ^[[:space:]]*-[[:space:]]*([^:]+): ]]; then
            window_name=$(echo "$line" | sed 's/^[[:space:]]*-[[:space:]]*//' | cut -d: -f1)
            show_box_bullet "${SYMBOL_WINDOW}" "$window_name"
            ((window_count++))
        fi
    done < <(grep -A20 "^windows:" "$config_file" 2>/dev/null | tail -n +2)

    if [[ $window_count -eq 0 ]]; then
        show_box_bullet "${SYMBOL_WINDOW}" "No windows defined" "$DIM"
    fi

    # Git info if directory exists
    if [[ -n "$root" ]] && [[ -d "$root" ]]; then
        if [[ -d "$root/.git" ]]; then
            echo -e "${BOX_SIDE}"
            show_box_section "🌿 Git Repository" "$GREEN"

            cd "$root" 2>/dev/null && {
                local branch=$(git branch --show-current 2>/dev/null || echo "detached")
                local status_count=$(git status --porcelain 2>/dev/null | wc -l | xargs)
                local commits=$(git rev-list --count HEAD 2>/dev/null || echo "0")

                show_box_item "🌿" "Branch" "$branch"
                show_box_item "📊" "Commits" "$commits" "$DIM"

                if [[ "$status_count" -gt 0 ]]; then
                    show_box_item "📝" "Changes" "$status_count files" "$YELLOW"
                else
                    show_box_item "${SYMBOL_CHECK}" "Status" "Clean" "$GREEN"
                fi
            }
        fi
    fi

    show_box_end
}

# ============================================================================
# SESH SESSION PREVIEW
# ============================================================================

show_sesh_session_preview() {
    local session="$1"

    # Get status (works outside tmux too!)
    local status_line=$(get_session_status "$session")
    IFS='|' read -r status symbol color created found_session <<< "$status_line"

    # Use the found session name (handles emoji prefixes) or fall back to input
    local tmux_session="${found_session:-$session}"

    # Check if it's an active tmux session
    if [[ -n "$found_session" ]] && tmux has-session -t "$tmux_session" 2>/dev/null; then
        # Show status badge
        show_status_badge "$status_line" "🪟 TMUX SESSION" "$session"

        local windows=$(tmux list-windows -t "$tmux_session" 2>/dev/null | wc -l | xargs)
        local current_path=$(tmux display-message -p -t "$tmux_session" '#{pane_current_path}' 2>/dev/null || echo "Unknown")

        # Status section
        show_box_section "📊 Status" "$YELLOW"
        show_box_item "${symbol}" "Windows" "$windows"
        show_box_item "📂" "Path" "${current_path/#$HOME/~}"

        # Windows section with enhanced details
        echo -e "${BOX_SIDE}"
        local total_panes=$(tmux list-panes -s -t "$tmux_session" 2>/dev/null | wc -l | xargs)
        show_box_section "🪟 Windows ($windows total, $total_panes panes)" "$YELLOW"

        # Get detailed window information
        tmux list-windows -t "$tmux_session" -F "#{window_index}|#{window_name}|#{window_active}|#{window_panes}" 2>/dev/null | head -5 | while IFS='|' read -r win_idx win_name is_active pane_count; do
            # Get the command running in the first pane of this window
            local command=$(tmux list-panes -t "$tmux_session:$win_idx" -F "#{pane_current_command}" 2>/dev/null | head -1)

            # Format pane count display
            local pane_text
            if [[ "$pane_count" == "1" ]]; then
                pane_text="1 pane"
            else
                pane_text="$pane_count panes"
            fi

            # Display window with details
            if [[ "$is_active" == "1" ]]; then
                show_box_bullet "${SYMBOL_ACTIVE_WINDOW}" "$win_name (${pane_text}) • ${command}" "$GREEN"
            else
                show_box_bullet "${SYMBOL_WINDOW}" "$win_name (${pane_text}) • ${DIM}${command}${NC}"
            fi
        done

        # Git info if in a git repository
        if [[ -d "$current_path/.git" ]]; then
            echo -e "${BOX_SIDE}"
            show_box_section "🌿 Git Repository" "$GREEN"

            cd "$current_path" 2>/dev/null && {
                local branch=$(git branch --show-current 2>/dev/null || echo "detached")
                local status_count=$(git status --porcelain 2>/dev/null | wc -l | xargs)

                show_box_item "🌿" "Branch" "$branch"

                if [[ "$status_count" -gt 0 ]]; then
                    show_box_item "📝" "Changes" "$status_count files" "$YELLOW"
                else
                    show_box_item "${SYMBOL_CHECK}" "Status" "Clean" "$GREEN"
                fi
            }
        fi

        # Add default sesh-style file listing at the end
        echo -e "${BOX_SIDE}"
        show_box_section "📂 Files (Default Sesh Style)" "$CYAN"
        echo -e "${BOX_SIDE}"

        if command -v eza &> /dev/null; then
            eza --all --git --icons --color=always "$current_path" 2>/dev/null | head -15 | while IFS= read -r line; do
                echo -e "${BOX_SIDE}   ${line}"
            done
        else
            ls -lAh "$current_path" 2>/dev/null | head -15 | while IFS= read -r line; do
                echo -e "${BOX_SIDE}   ${line}"
            done
        fi

        show_box_end
    else
        # Session not found - show directory preview like default sesh
        show_status_badge "$status_line" "⚙️  SESH SESSION" "$session"

        show_box_section "📊 Status" "$YELLOW"
        show_box_item "${SYMBOL_INACTIVE}" "State" "Not running"

        # Add default sesh-style simple file listing
        echo -e "${BOX_SIDE}"
        show_box_section "📁 Directory Preview (Default Style)" "$BLUE"
        echo -e "${BOX_SIDE}"

        # Try eza first (prettier), fallback to ls
        if command -v eza &> /dev/null; then
            eza --all --git --icons --color=always "$session" 2>/dev/null | head -20 | while IFS= read -r line; do
                echo -e "${BOX_SIDE}   ${line}"
            done
        else
            ls -lAh "$session" 2>/dev/null | head -20 | while IFS= read -r line; do
                echo -e "${BOX_SIDE}   ${line}"
            done
        fi

        show_box_end
    fi
}

# ============================================================================
# DIRECTORY PREVIEW (for zoxide paths)
# ============================================================================

show_directory_preview() {
    local dir_path="$1"

    # Expand tilde
    dir_path="${dir_path/#\~/$HOME}"

    if [[ ! -d "$dir_path" ]]; then
        echo "Directory not found: ${dir_path/#$HOME/~}"
        return
    fi

    # Simple default sesh-style file listing
    if command -v eza &> /dev/null; then
        eza --all --git --icons --color=always "$dir_path" 2>/dev/null
    else
        ls -lAh "$dir_path" 2>/dev/null
    fi
}

# ============================================================================
# MAIN LOGIC - Route to appropriate preview function
# ============================================================================

# First, check if it's a tmuxinator project
if tmuxinator list 2>/dev/null | tail -n +2 | tr -s ' ' '\n' | grep -q "^${session_name}$"; then
    show_tmuxinator_preview "$session_name"

# Check if it's a directory path (starts with ~ or /)
elif [[ "$session_name" =~ ^~ ]] || [[ "$session_name" =~ ^/ ]]; then
    show_directory_preview "$session_name"

# Otherwise, treat as a sesh session
else
    show_sesh_session_preview "$session_name"
fi
