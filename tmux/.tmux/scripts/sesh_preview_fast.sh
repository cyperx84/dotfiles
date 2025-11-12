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

# Clean input - remove ANSI codes and icons (use perl for better compatibility)
if command -v perl &> /dev/null; then
    SESSION_CLEAN=$(echo "$SESSION_INPUT" | perl -pe 's/\e\[[0-9;]*m//g' | sed -e 's/^[●○◆◉📁▣▪][[:space:]]*//' | xargs)
else
    SESSION_CLEAN=$(echo "$SESSION_INPUT" | LC_ALL=C sed 's/'$(printf '\033')'\[[0-9;]*m//g' | sed -e 's/^[●○◆◉📁▣▪][[:space:]]*//' | xargs)
fi
# Remove emoji prefixes
SESSION_CLEAN=$(echo "$SESSION_CLEAN" | sed -E 's/^[^[:alnum:]~\/\._-]+[[:space:]]*//')
# Remove metadata like (2w 3p)
SESSION_CLEAN=$(echo "$SESSION_CLEAN" | sed -E 's/[[:space:]]+\([0-9].*//')
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
    echo -e "${BLUE}▣ Tmuxinator: ${SESSION_CLEAN}${NC}"

    # Check if running
    if tmux has-session -t "$SESSION_CLEAN" 2>/dev/null; then
        echo -e "${CYAN}Status:${NC} ${GREEN}✓ Running${NC}"
        window_count=$(tmux list-windows -t "$SESSION_CLEAN" 2>/dev/null | wc -l | tr -d ' ')
        pane_count=$(tmux list-panes -s -t "$SESSION_CLEAN" 2>/dev/null | wc -l | tr -d ' ')
        echo -e "${CYAN}Windows:${NC} $window_count  ${CYAN}Panes:${NC} $pane_count"
    else
        echo -e "${CYAN}Status:${NC} ${YELLOW}○ Not running${NC}"
        window_count=$(grep -c "^  - " "$HOME/.config/tmuxinator/${SESSION_CLEAN}.yml" 2>/dev/null || echo "1")
        echo -e "${CYAN}Configured:${NC} $window_count window(s)"
    fi

    # Extract root path (single grep, no complex parsing)
    root=$(grep "^root:" "$HOME/.config/tmuxinator/${SESSION_CLEAN}.yml" 2>/dev/null | \
        sed 's/root: *//' | sed "s|~|$HOME|" | tr -d '"' | tr -d "'")

    [ -n "$root" ] && echo -e "${CYAN}Path:${NC} $root"

    # Always show directory preview
    if [ -n "$root" ] && [ -d "$root" ]; then
        echo ""
        echo -e "${CYAN}━━ Directory Preview ━━${NC}"
        if command -v eza &> /dev/null; then
            eza --icons --color=always --group-directories-first -a -l "$root" 2>/dev/null | head -8
        else
            ls -lA "$root" 2>/dev/null | head -8
        fi
    fi

else
    # Check if it's a sesh.toml custom session
    sesh_config="$HOME/.config/sesh/sesh.toml"
    session_path=""

    if [ -f "$sesh_config" ]; then
        # Quick check if session is in sesh.toml
        if grep -q "^name = \"${SESSION_CLEAN}\"" "$sesh_config" 2>/dev/null; then
            # Extract path for this session
            session_path=$(awk "/^name = \"${SESSION_CLEAN}\"/,/^\[/ {if (/^path = /) {gsub(/.*= \"/, \"\"); gsub(/\".*/, \"\"); print; exit}}" "$sesh_config")
            session_path="${session_path/#\~/$HOME}"
        fi
    fi

    if [ -n "$session_path" ] && [ -d "$session_path" ]; then
        # Sesh.toml custom session
        echo -e "${BLUE}◆ Sesh Config: ${SESSION_CLEAN}${NC}"

        # Check if running
        if tmux has-session -t "$SESSION_CLEAN" 2>/dev/null; then
            echo -e "${CYAN}Status:${NC} ${GREEN}✓ Running${NC}"
            window_count=$(tmux list-windows -t "$SESSION_CLEAN" 2>/dev/null | wc -l | tr -d ' ')
            pane_count=$(tmux list-panes -s -t "$SESSION_CLEAN" 2>/dev/null | wc -l | tr -d ' ')
            echo -e "${CYAN}Windows:${NC} $window_count  ${CYAN}Panes:${NC} $pane_count"
        else
            echo -e "${CYAN}Status:${NC} ${YELLOW}○ Not running${NC}"
            echo -e "${CYAN}Will create:${NC} 1 window, 1 pane"
        fi

        echo -e "${CYAN}Path:${NC} $session_path"

        # Always show directory preview
        echo ""
        echo -e "${CYAN}━━ Directory Preview ━━${NC}"
        if command -v eza &> /dev/null; then
            eza --icons --color=always --group-directories-first -a -l "$session_path" 2>/dev/null | head -8
        else
            ls -lA "$session_path" 2>/dev/null | head -8
        fi
    elif [ -d "$SESSION_CLEAN" ]; then
        # Regular directory
        echo -e "${YELLOW}📁 Directory: ${SESSION_CLEAN}${NC}"

        echo -e "${CYAN}Status:${NC} ${YELLOW}○ Not a session${NC}"
        echo -e "${CYAN}Will create:${NC} 1 window, 1 pane"
        echo -e "${CYAN}Path:${NC} $SESSION_CLEAN"

        # Always show directory preview
        echo ""
        echo -e "${CYAN}━━ Directory Preview ━━${NC}"
        if command -v eza &> /dev/null; then
            eza --icons --color=always --group-directories-first -a -l "$SESSION_CLEAN" 2>/dev/null | head -8
        else
            ls -lA "$SESSION_CLEAN" 2>/dev/null | head -8
        fi
    else
        # Unknown/config
        echo -e "${GRAY}Session: ${SESSION_CLEAN}${NC}"
        echo "Type: Custom or unknown"
    fi
fi
