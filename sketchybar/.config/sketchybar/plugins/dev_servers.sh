#!/bin/bash

# Development servers plugin with error handling

# Check if NAME variable is set
if [ -z "$NAME" ]; then
  echo "Error: NAME variable not set" >&2
  exit 1
fi

# Check if lsof is available
if ! command -v lsof &> /dev/null; then
  echo "Error: lsof command not found" >&2
  sketchybar --set $NAME drawing=off 2>/dev/null
  exit 1
fi

# Common development server ports to check
DEV_PORTS=(3000 3001 4000 5000 8000 8080 8888 9000)
RUNNING_PORTS=()

# Check each port
for port in "${DEV_PORTS[@]}"; do
  if lsof -i :$port -sTCP:LISTEN &>/dev/null; then
    RUNNING_PORTS+=($port)
  fi
done

# Update display based on running servers
if [ ${#RUNNING_PORTS[@]} -eq 0 ]; then
  # No servers running
  if ! sketchybar --set $NAME drawing=off 2>/dev/null; then
    echo "Warning: Failed to set drawing=off for dev_servers plugin" >&2
  fi
else
  # Show running servers
  sketchybar --set $NAME drawing=on
  
  if [ ${#RUNNING_PORTS[@]} -eq 1 ]; then
    # Single server
    LABEL="${RUNNING_PORTS[0]}"
  elif [ ${#RUNNING_PORTS[@]} -le 3 ]; then
    # Few servers - show all ports
    LABEL=$(IFS=','; echo "${RUNNING_PORTS[*]}")
  else
    # Many servers - show count
    LABEL="${#RUNNING_PORTS[@]} servers"
  fi
  
  # Set color based on number of servers
  if [ ${#RUNNING_PORTS[@]} -gt 3 ]; then
    COLOR="0xfff5a97f"  # Orange for many servers
  else
    COLOR="0xffa6da95"  # Green for normal load
  fi
  
  if ! sketchybar --set $NAME label="$LABEL" label.color=$COLOR 2>/dev/null; then
    echo "Warning: Failed to update sketchybar for dev_servers plugin" >&2
  fi
fi