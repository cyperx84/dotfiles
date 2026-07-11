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

# Visibility: always show spaces 1-3; show 4-9 only when they hold windows or
# are the focused workspace. Empty, unfocused high spaces are hidden entirely.
focused=$($WM_CMD list-workspaces --focused 2>/dev/null)
if [ "$SID" -le 3 ] 2>/dev/null || [ "$window_count" -gt 0 ] || [ "$SID" = "$focused" ]; then
  drawing="on"
else
  drawing="off"
fi

# Update the space indicator
sketchybar --set "space.$SID" label="$label" drawing="$drawing"
