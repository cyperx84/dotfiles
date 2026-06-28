#!/usr/bin/env bash
################################################################################
# sesh_kill.sh - Simplified Session Termination
################################################################################
# Kill a tmux session from sesh switcher
# Input: Formatted line from sesh_list_enhanced.sh (with icons, colors, etc.)
# Usage: sesh_kill.sh "formatted_session_line"

# Source shared utilities
SCRIPT_DIR="$(dirname "${BASH_SOURCE[0]}")"
SESH_SCRIPTS_LIB="${SCRIPT_DIR}/../lib"
source "${SESH_SCRIPTS_LIB}/sesh_common.sh"

# Clean session name using shared function
SESSION=$(clean_session_name "$1")

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
