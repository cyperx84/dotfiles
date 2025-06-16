#!/bin/bash

# Check if tmux server is running
if ! pgrep tmux &>/dev/null; then
  # No tmux server running
  sketchybar --set $NAME drawing=off
  exit 0
fi

# Get current tmux session info
CURRENT_SESSION=$(tmux display-message -p '#S' 2>/dev/null)
SESSION_COUNT=$(tmux list-sessions 2>/dev/null | wc -l | tr -d ' ')

if [ "$SESSION_COUNT" -eq 0 ]; then
  # No sessions (shouldn't happen if server is running, but just in case)
  sketchybar --set $NAME drawing=off
elif [ -n "$CURRENT_SESSION" ]; then
  # We're attached to a session - show session name
  sketchybar --set $NAME drawing=on \
                      label="$CURRENT_SESSION" \
                      label.color="0xffa6da95"  # Green - active session
elif [ "$SESSION_COUNT" -eq 1 ]; then
  # Single detached session
  SESSION_NAME=$(tmux list-sessions -F '#S' 2>/dev/null | head -1)
  sketchybar --set $NAME drawing=on \
                      label="$SESSION_NAME" \
                      label.color="0xff80ff00"  # Blue - detached session
else
  # Multiple sessions
  sketchybar --set $NAME drawing=on \
                      label="$SESSION_COUNT" \
                      label.color="0xfff5a97f"  # Orange - multiple sessions
fi