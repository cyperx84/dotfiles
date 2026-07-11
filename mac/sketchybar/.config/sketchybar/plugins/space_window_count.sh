#!/usr/bin/env bash

# Update window count for a specific workspace
# Shows dots (•) for 1-3 windows, then numbers for 4+
# Called by aerospace.sh on workspace changes

# Auto-detect which window manager is running (HyprSpace or AeroSpace)
get_wm_command() {
  if pgrep -x "HyprSpace" >/dev/null 2>&1; then
    echo "hyprspace"
  elif pgrep -x "AeroSpace" >/dev/null 2>&1; then
    echo "aerospace"
  else
    # Default to aerospace if neither is detected
    echo "aerospace"
  fi
}

SID="$1"

# Exit if no workspace ID provided
if [ -z "$SID" ]; then
  exit 0
fi

# Get window count for this workspace
WM_CMD=$(get_wm_command)
window_count=$($WM_CMD list-windows --workspace "$SID" 2>/dev/null | wc -l | tr -d ' ')

# Set label based on window count
case $window_count in
  0) label="" ;;
  1) label="•" ;;
  2) label="••" ;;
  3) label="•••" ;;
  *) label="$window_count" ;;
esac

# Update the space indicator
sketchybar --set "space.$SID" label="$label"
