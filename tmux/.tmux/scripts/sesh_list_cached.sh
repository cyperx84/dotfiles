#!/usr/bin/env bash

# Cached session list with TTL for ultra-fast loading
# Cache invalidation: 2 second TTL or manual via $HOME/.sesh_cache_invalidate

CACHE_FILE="/tmp/sesh_list_cache"
CACHE_TTL=2  # 2 seconds - fast enough for most workflows
INVALIDATE_FLAG="$HOME/.sesh_cache_invalidate"

# Check if cache exists and is fresh
if [ -f "$CACHE_FILE" ] && [ ! -f "$INVALIDATE_FLAG" ]; then
    CACHE_AGE=$(($(date +%s) - $(stat -f %m "$CACHE_FILE" 2>/dev/null || echo 0)))
    if [ "$CACHE_AGE" -lt "$CACHE_TTL" ]; then
        # Cache hit - return immediately
        cat "$CACHE_FILE"
        exit 0
    fi
fi

# Cache miss or expired - regenerate
# Remove invalidation flag if present
rm -f "$INVALIDATE_FLAG" 2>/dev/null

# Get active tmux sessions (once, stored in memory)
declare -A active_sessions
while IFS= read -r session; do
    active_sessions["$session"]=1
done < <(tmux list-sessions -F '#{session_name}' 2>/dev/null)

# Color definitions
COLOR_ACTIVE='\033[38;2;128;255;0m'      # Neon green
COLOR_INACTIVE='\033[38;2;164;140;242m'  # Purple
COLOR_DIR='\033[38;2;241;252;121m'       # Yellow
COLOR_RESET='\033[0m'

ICON_ACTIVE="●"
ICON_INACTIVE="○"
ICON_DIR="◆"

# Generate output and cache it
{
    sesh list | awk '!seen[$0]++' | while IFS= read -r session; do
        [ -z "$session" ] && continue

        # Fast type detection - check active sessions first (hash lookup = O(1))
        if [[ -n "${active_sessions[$session]}" ]]; then
            echo -e "${COLOR_ACTIVE}${ICON_ACTIVE} ${session}${COLOR_RESET}"
        # Only check directories for paths (contain / or start with ~)
        elif [[ "$session" == */* ]] || [[ "$session" == ~* ]]; then
            if [ -d "${session/#\~/$HOME}" ]; then
                echo -e "${COLOR_DIR}${ICON_DIR} ${session}${COLOR_RESET}"
            else
                echo -e "${COLOR_INACTIVE}${ICON_INACTIVE} ${session}${COLOR_RESET}"
            fi
        else
            # Session name (not path) - must be config
            echo -e "${COLOR_INACTIVE}${ICON_INACTIVE} ${session}${COLOR_RESET}"
        fi
    done
} | tee "$CACHE_FILE"
