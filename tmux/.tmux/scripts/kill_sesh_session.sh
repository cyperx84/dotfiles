#!/usr/bin/env bash

# Kill a tmux session from sesh switcher
# Extracts session name from formatted sesh output and kills the session
# Input: Formatted line from sesh_list_enhanced.sh (with icons, colors, etc.)
# Usage: kill_sesh_session.sh "formatted_session_line"

# Extract session name from formatted output
# Removes ANSI color codes (including actual ESC byte) and icon prefix
SESSION=$(echo "$1" | sed 's/\x1b\[[0-9;]*m//g' | sed -E 's/^[^[:alnum:]~\/\._-]+[[:space:]]*//' | xargs)

if [ -n "$SESSION" ]; then
    # Only kill if it's an actual tmux session
    if tmux has-session -t "$SESSION" 2>/dev/null; then
        tmux kill-session -t "$SESSION" 2>/dev/null
        # Invalidate session list cache
        touch "$HOME/.sesh_cache_invalidate"
        exit $?
    fi
fi

exit 0
