#!/usr/bin/env bash

# Kill a tmux session from sesh switcher
# Extracts session name from formatted sesh output and kills the session
# Input: Formatted line from sesh_list_enhanced.sh (with icons, colors, etc.)
# Usage: kill_sesh_session.sh "formatted_session_line"

# Extract session name from formatted output
# Removes ANSI color codes and icon prefix
SESSION=$(echo "$1" | sed 's/\x1b\[[0-9;]*m//g' | sed 's/^[◆▣📁📂🔷🔶⬢●◉○] *//' | awk '{print $1}')

if [ -n "$SESSION" ]; then
    # Kill the session
    tmux kill-session -t "$SESSION" 2>/dev/null
    exit $?
else
    exit 1
fi
