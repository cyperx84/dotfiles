#!/bin/bash

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
  
  sketchybar --set $NAME drawing=on \
                      label="$LABEL" \
                      label.color="0xffa6da95"  # Green - connected
  exit 0
fi

# Check for active SSH connections from this machine
SSH_CONNECTIONS=$(ss -t 2>/dev/null | grep :22 | grep ESTAB | wc -l | tr -d ' ')

if [ "$SSH_CONNECTIONS" -eq 0 ]; then
  # No SSH connections
  sketchybar --set $NAME drawing=off
elif [ "$SSH_CONNECTIONS" -eq 1 ]; then
  # Single SSH connection
  # Try to get hostname from most recent ssh process
  SSH_HOST=$(ps aux | grep 'ssh ' | grep -v grep | tail -1 | awk '{for(i=11;i<=NF;i++) if($i!~/-/) {print $i; break}}')
  if [ -n "$SSH_HOST" ] && [ "$SSH_HOST" != "ssh" ]; then
    LABEL="$SSH_HOST"
  else
    LABEL="1"
  fi
  
  sketchybar --set $NAME drawing=on \
                      label="$LABEL" \
                      label.color="0xff80ff00"  # Blue - single connection
else
  # Multiple SSH connections
  sketchybar --set $NAME drawing=on \
                      label="$SSH_CONNECTIONS" \
                      label.color="0xfff5a97f"  # Orange - multiple connections
fi