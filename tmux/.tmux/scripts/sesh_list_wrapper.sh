#!/usr/bin/env bash

# Wrapper for sesh_list_enhanced.sh that toggles between display modes
# Tracks state in ~/.sesh_display_mode file
# The preview script reads this file to determine what to show

STATE_FILE="$HOME/.sesh_display_mode"
TOGGLE_MODE="${1:-false}"
shift  # Remove first arg, rest are passed to sesh_list_enhanced.sh

# Determine display mode based on state file
if [ "$TOGGLE_MODE" = "toggle" ]; then
    # Toggle mode: invert the current state
    if [ -f "$STATE_FILE" ]; then
        DISPLAY_MODE=$(cat "$STATE_FILE")
        # Toggle it
        if [ "$DISPLAY_MODE" = "detailed" ]; then
            DISPLAY_MODE="compact"
        else
            DISPLAY_MODE="detailed"
        fi
    else
        # Default to detailed on first toggle
        DISPLAY_MODE="detailed"
    fi
else
    # Direct mode specification
    DISPLAY_MODE="${TOGGLE_MODE:-compact}"
fi

# Save the current mode for next toggle (preview script reads this)
echo "$DISPLAY_MODE" > "$STATE_FILE"

# Run sesh_list_enhanced.sh with remaining args
# No markers added - preview script reads ~/.sesh_display_mode instead
~/.tmux/scripts/sesh_list_enhanced.sh "$@"
