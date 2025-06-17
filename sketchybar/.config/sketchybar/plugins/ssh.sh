#!/bin/bash

# SSH plugin with error handling

# Check if NAME variable is set
if [ -z "$NAME" ]; then
  echo "Error: NAME variable not set" >&2
  exit 1
fi

# Check if we're in an SSH session
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
  # We're in an SSH session - show remote host info
  REMOTE_HOST=$(echo $SSH_CLIENT | awk '{print $3}')
  if [ -n "$HOSTNAME" ]; then
    LABEL="$HOSTNAME"
  elif [ -n "$REMOTE_HOST" ]; then
    LABEL="$REMOTE_HOST"
  else
    LABEL="SSH"
  fi
  
  if ! sketchybar --set $NAME drawing=on label="$LABEL" label.color="0xffa6da95" 2>/dev/null; then
    echo "Warning: Failed to update sketchybar for SSH session" >&2
  fi
  exit 0
fi

# Check for active SSH connections from this machine
if ! command -v ss &> /dev/null; then
  echo "Warning: ss command not available, using fallback" >&2
  # Use netstat as fallback
  if command -v netstat &> /dev/null; then
    SSH_CONNECTIONS=$(netstat -t 2>/dev/null | grep :22 | grep ESTABLISHED | wc -l | tr -d ' ')
  else
    echo "Error: Neither ss nor netstat available" >&2
    sketchybar --set $NAME drawing=off 2>/dev/null
    exit 1
  fi
else
  SSH_CONNECTIONS=$(ss -t 2>/dev/null | grep :22 | grep ESTAB | wc -l | tr -d ' ')
fi

if [ "$SSH_CONNECTIONS" -eq 0 ]; then
  # No SSH connections
  if ! sketchybar --set $NAME drawing=off 2>/dev/null; then
    echo "Warning: Failed to set drawing=off for SSH plugin" >&2
  fi
elif [ "$SSH_CONNECTIONS" -eq 1 ]; then
  # Single SSH connection
  # Try to get hostname from most recent ssh process
  SSH_HOST=$(ps aux | grep 'ssh ' | grep -v grep | tail -1 | awk '{for(i=11;i<=NF;i++) if($i!~/-/) {print $i; break}}')
  if [ -n "$SSH_HOST" ] && [ "$SSH_HOST" != "ssh" ]; then
    LABEL="$SSH_HOST"
  else
    LABEL="1"
  fi
  
  if ! sketchybar --set $NAME drawing=on label="$LABEL" label.color="0xff80ff00" 2>/dev/null; then
    echo "Warning: Failed to update sketchybar for single SSH connection" >&2
  fi
else
  # Multiple SSH connections
  if ! sketchybar --set $NAME drawing=on label="$SSH_CONNECTIONS" label.color="0xfff5a97f" 2>/dev/null; then
    echo "Warning: Failed to update sketchybar for multiple SSH connections" >&2
  fi
fi