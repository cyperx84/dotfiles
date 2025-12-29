#!/bin/bash

# Space click handler - handles user interactions only
# Visual updates are handled by aerospace.sh

set_space_label() {
  sketchybar --set "$NAME" icon="$@"
}

mouse_clicked() {
  if [ "$BUTTON" = "right" ]; then
    # Right-click: do nothing
    :
  else
    # Left-click: Switch to workspace
    aerospace workspace "$SID" 2>/dev/null
  fi
}

case "$SENDER" in
  "mouse.clicked") mouse_clicked
  ;;
esac
