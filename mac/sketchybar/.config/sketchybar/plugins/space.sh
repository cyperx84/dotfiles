#!/bin/bash

# Space click handler - handles user interactions only
# Visual updates are handled by aerospace.sh

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

set_space_label() {
  sketchybar --set "$NAME" icon="$@"
}

mouse_clicked() {
  if [ "$BUTTON" = "right" ]; then
    # Right-click: do nothing
    :
  else
    # Left-click: Switch to workspace
    WM_CMD=$(get_wm_command)
    $WM_CMD workspace "$SID" 2>/dev/null
  fi
}

case "$SENDER" in
  "mouse.clicked") mouse_clicked
  ;;
esac
