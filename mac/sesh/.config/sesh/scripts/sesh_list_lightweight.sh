#!/usr/bin/env bash

# Lightweight session list formatter - fast status indicators
# Shows active/inactive sessions without expensive git/resource checks

# Get active tmux sessions
declare -A active_sessions
while IFS= read -r session; do
    active_sessions["$session"]=1
done < <(tmux list-sessions -F '#{session_name}' 2>/dev/null)

# Color definitions
COLOR_ACTIVE='\033[38;2;128;255;0m'      # Neon green
COLOR_INACTIVE='\033[38;2;164;140;242m'  # Purple (tmuxinator/config)
COLOR_DIR='\033[38;2;241;252;121m'       # Yellow (directories)
COLOR_RESET='\033[0m'

ICON_ACTIVE="●"      # Active session (filled)
ICON_INACTIVE="○"    # Inactive/config (hollow)
ICON_DIR="◆"         # Directory (diamond)

# Process sesh list output with deduplication
sesh list | awk '!seen[$0]++' | while IFS= read -r session; do
    if [ -z "$session" ]; then
        continue
    fi

    # Check if it's an active tmux session
    if [[ -n "${active_sessions[$session]}" ]]; then
        # Active tmux session
        echo -e "${COLOR_ACTIVE}${ICON_ACTIVE} ${session}${COLOR_RESET}"
    elif [ -d "${session/#\~/$HOME}" ]; then
        # Directory/zoxide
        echo -e "${COLOR_DIR}${ICON_DIR} ${session}${COLOR_RESET}"
    else
        # Inactive (tmuxinator config or custom session)
        echo -e "${COLOR_INACTIVE}${ICON_INACTIVE} ${session}${COLOR_RESET}"
    fi
done
