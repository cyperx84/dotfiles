#!/usr/bin/env bash

# Ultra-fast preview - minimal tmux calls, cached where possible
# Focus: Show enough info quickly without slowing down fzf

SESSION_INPUT="$1"

# Color definitions
BLUE='\033[0;34m'
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
GRAY='\033[0;90m'
NC='\033[0m'

# Clean input - remove ANSI codes and icons
SESSION_CLEAN=$(echo "$SESSION_INPUT" | sed -E 's/\x1b\[[0-9;]*m//g' | sed -e 's/^[●○◆][[:space:]]*//' | xargs)
SESSION_CLEAN="${SESSION_CLEAN/#\~/$HOME}"

# Quick type detection
if tmux has-session -t "$SESSION_CLEAN" 2>/dev/null; then
    # Active tmux session - show minimal info
    echo -e "${BLUE}● Tmux Session: ${SESSION_CLEAN}${NC}"

    # Single tmux call to get all info at once (much faster than multiple calls)
    IFS='|' read -r windows panes path activity created < <(
        tmux display-message -p -t "$SESSION_CLEAN" \
            '#{session_windows}|#{session_id}|#{pane_current_path}|#{session_activity}|#{session_created}' 2>/dev/null
    )

    # Calculate pane count (one list-panes call)
    panes=$(tmux list-panes -s -t "$SESSION_CLEAN" 2>/dev/null | wc -l | tr -d ' ')

    echo -e "${CYAN}Windows:${NC} $windows  ${CYAN}Panes:${NC} $panes"
    [ -n "$path" ] && echo -e "${CYAN}Path:${NC} $path"

    # Activity (if available)
    if [ -n "$activity" ]; then
        since=$(( $(date +%s) - activity ))
        if [ $since -lt 300 ]; then
            echo -e "${CYAN}Status:${NC} ${GREEN}Active${NC} ($since ago)"
        elif [ $since -lt 3600 ]; then
            echo -e "${CYAN}Status:${NC} ${YELLOW}Idle${NC} ($(($since/60))m ago)"
        else
            echo -e "${CYAN}Status:${NC} ${GRAY}Stale${NC} ($(($since/3600))h ago)"
        fi
    fi

    # Pane preview - reduced from 30 to 10 lines for speed
    echo ""
    echo -e "${CYAN}━━ Current Pane ━━${NC}"
    tmux capture-pane -t "$SESSION_CLEAN" -p -e -J -S -10 2>/dev/null | tail -8

elif [ -f "$HOME/.config/tmuxinator/${SESSION_CLEAN}.yml" ]; then
    # Tmuxinator config
    echo -e "${BLUE}○ Tmuxinator: ${SESSION_CLEAN}${NC}"

    # Extract root path (single grep, no complex parsing)
    root=$(grep "^root:" "$HOME/.config/tmuxinator/${SESSION_CLEAN}.yml" 2>/dev/null | \
        sed 's/root: *//' | sed "s|~|$HOME|" | tr -d '"' | tr -d "'")

    [ -n "$root" ] && [ -d "$root" ] && echo -e "${CYAN}Path:${NC} $root"

    # Show first 5 windows defined
    echo ""
    echo -e "${CYAN}Windows:${NC}"
    grep "^  - " "$HOME/.config/tmuxinator/${SESSION_CLEAN}.yml" 2>/dev/null | head -5 | \
        sed 's/^  - /  • /'

elif [ -d "$SESSION_CLEAN" ]; then
    # Directory
    echo -e "${YELLOW}◆ Directory: ${SESSION_CLEAN}${NC}"

    # Fast ls without git status checks
    if [ -d "$SESSION_CLEAN" ]; then
        echo ""
        ls -1A "$SESSION_CLEAN" 2>/dev/null | head -15 | sed 's/^/  /'
    fi
else
    # Unknown/config
    echo -e "${GRAY}Session: ${SESSION_CLEAN}${NC}"
    echo "Type: Custom or unknown"
fi
