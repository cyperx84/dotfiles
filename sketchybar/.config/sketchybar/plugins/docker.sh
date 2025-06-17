#!/bin/bash

# Docker plugin with error handling

# Check if NAME variable is set
if [ -z "$NAME" ]; then
  echo "Error: NAME variable not set" >&2
  exit 1
fi

# Check if Docker is available
if ! command -v docker &> /dev/null; then
  echo "Warning: docker command not found" >&2
  sketchybar --set $NAME drawing=off 2>/dev/null
  exit 0
fi

# Check if Docker is running
if ! docker info &>/dev/null; then
  # Docker not running
  if ! sketchybar --set $NAME drawing=off 2>/dev/null; then
    echo "Warning: Failed to set drawing=off for docker plugin" >&2
  fi
  exit 0
fi

# Docker is running, make sure we're visible
if ! sketchybar --set $NAME drawing=on 2>/dev/null; then
  echo "Warning: Failed to set drawing=on for docker plugin" >&2
fi

# Get running container count
CONTAINER_COUNT=$(docker ps --format "table {{.Names}}" 2>/dev/null | tail -n +2 | wc -l | tr -d ' ')

# Handle display based on container count
# Update display based on container count with error handling
if [ "$CONTAINER_COUNT" -eq 0 ]; then
  # No containers running
  if ! sketchybar --set $NAME label="0" label.color="0xff6e6a86" 2>/dev/null; then
    echo "Warning: Failed to update sketchybar for 0 containers" >&2
  fi
elif [ "$CONTAINER_COUNT" -eq 1 ]; then
  # Single container
  if ! sketchybar --set $NAME label="1" label.color="0xffa6da95" 2>/dev/null; then
    echo "Warning: Failed to update sketchybar for 1 container" >&2
  fi
elif [ "$CONTAINER_COUNT" -le 5 ]; then
  # Few containers
  if ! sketchybar --set $NAME label="$CONTAINER_COUNT" label.color="0xff80ff00" 2>/dev/null; then
    echo "Warning: Failed to update sketchybar for few containers" >&2
  fi
else
  # Many containers
  if ! sketchybar --set $NAME label="$CONTAINER_COUNT" label.color="0xfff5a97f" 2>/dev/null; then
    echo "Warning: Failed to update sketchybar for many containers" >&2
  fi
fi