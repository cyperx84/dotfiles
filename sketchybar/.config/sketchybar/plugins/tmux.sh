#!/bin/bash

# Tmux plugin with error handling

# Check if NAME variable is set
if [ -z "$NAME" ]; then
  echo "Error: NAME variable not set" >&2
  exit 1
fi

# Check if tmux is available
if ! command -v tmux &> /dev/null; then
  echo "Warning: tmux command not found" >&2
  sketchybar --set $NAME drawing=off 2>/dev/null
  exit 0
fi

# Check if tmux server is running
if ! pgrep tmux &>/dev/null; then
  # No tmux server running
  if ! sketchybar --set $NAME drawing=off 2>/dev/null; then
    echo "Warning: Failed to set drawing=off for tmux plugin" >&2
  fi
  exit 0
fi

# Get current tmux session info
CURRENT_SESSION=$(tmux display-message -p '#S' 2>/dev/null)
SESSION_COUNT=$(tmux list-sessions 2>/dev/null | wc -l | tr -d ' ')

if [ "$SESSION_COUNT" -eq 0 ]; then
  # No sessions (shouldn't happen if server is running, but just in case)
  if ! sketchybar --set $NAME drawing=off 2>/dev/null; then
    echo "Warning: Failed to set drawing=off for tmux plugin" >&2
  fi
elif [ -n "$CURRENT_SESSION" ]; then
  # We're attached to a session - show session name
  if ! sketchybar --set $NAME drawing=on label="$CURRENT_SESSION" label.color="0xffa6da95" 2>/dev/null; then
    echo "Warning: Failed to update sketchybar for active tmux session" >&2
  fi
elif [ "$SESSION_COUNT" -eq 1 ]; then
  # Single detached session
  SESSION_NAME=$(tmux list-sessions -F '#S' 2>/dev/null | head -1)
  if ! sketchybar --set $NAME drawing=on label="$SESSION_NAME" label.color="0xff80ff00" 2>/dev/null; then
    echo "Warning: Failed to update sketchybar for detached tmux session" >&2
  fi
else
  # Multiple sessions
  if ! sketchybar --set $NAME drawing=on label="$SESSION_COUNT" label.color="0xfff5a97f" 2>/dev/null; then
    echo "Warning: Failed to update sketchybar for multiple tmux sessions" >&2
  fi
fi