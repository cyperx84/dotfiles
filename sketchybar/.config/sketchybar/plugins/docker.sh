#!/bin/bash

# Check if Docker is running
if ! docker info &>/dev/null; then
  # Docker not running
  sketchybar --set $NAME drawing=off
  exit 0
fi

# Docker is running, make sure we're visible
sketchybar --set $NAME drawing=on

# Get running container count
CONTAINER_COUNT=$(docker ps --format "table {{.Names}}" 2>/dev/null | tail -n +2 | wc -l | tr -d ' ')

# Handle display based on container count
if [ "$CONTAINER_COUNT" -eq 0 ]; then
  # No containers running
  sketchybar --set $NAME label="0" \
                      label.color="0xff6e6a86"  # Grey
elif [ "$CONTAINER_COUNT" -eq 1 ]; then
  # Single container
  sketchybar --set $NAME label="1" \
                      label.color="0xffa6da95"  # Green
elif [ "$CONTAINER_COUNT" -le 5 ]; then
  # Few containers
  sketchybar --set $NAME label="$CONTAINER_COUNT" \
                      label.color="0xff80ff00"  # Blue
else
  # Many containers
  sketchybar --set $NAME label="$CONTAINER_COUNT" \
                      label.color="0xfff5a97f"  # Orange
fi