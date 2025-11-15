#!/bin/bash

# Space click handler - handles user interactions only
# Visual updates are handled by aerospace.sh

set_space_label() {
  sketchybar --set "$NAME" icon="$@"
}

mouse_clicked() {
  if [ "$BUTTON" = "right" ]; then
    # Right-click: Remove this space from SketchyBar view
    sketchybar --remove "$NAME"
  else
    if [ "$MODIFIER" = "shift" ]; then
      # Shift+click: Rename workspace
      SPACE_LABEL="$(osascript -e "return (text returned of (display dialog \"Give a name to workspace $NAME:\" default answer \"\" with icon note buttons {\"Cancel\", \"Continue\"} default button \"Continue\"))")"
      if [ $? -eq 0 ]; then
        if [ "$SPACE_LABEL" = "" ]; then
          set_space_label "${NAME:6}"
        else
          set_space_label "${NAME:6} ($SPACE_LABEL)"
        fi
      fi
    else
      # Left-click: Switch to workspace
      aerospace workspace "$SID" 2>/dev/null
    fi
  fi
}

case "$SENDER" in
  "mouse.clicked") mouse_clicked
  ;;
esac
