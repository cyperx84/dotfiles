#!/bin/bash

update() {
  source "$CONFIG_DIR/colors.sh"
  
  if [ "$SELECTED" = "true" ]; then
    # Active space: smaller pill styling with smooth animations
    sketchybar --animate tanh 15 --set $NAME \
      icon.highlight=on \
      icon.color=$SPACE_ACTIVE_TEXT \
      label.highlight=on \
      label.color=$SPACE_WINDOW_INDICATOR \
      background.color=$SPACE_ACTIVE_BG \
      background.border_color=$SPACE_ACTIVE_BORDER \
      background.border_width=2 \
      background.corner_radius=12 \
      background.height=24 \
      background.shadow.drawing=on \
      background.shadow.color=$SHADOW_COLOR \
      background.shadow.angle=30 \
      background.shadow.distance=1 \
      icon.font="$FONT:Bold:16.0" \
      padding_left=3 \
      padding_right=3
  else
    # Inactive space: smaller subtle styling with smooth transitions
    sketchybar --animate tanh 15 --set $NAME \
      icon.highlight=off \
      icon.color=$SPACE_INACTIVE_TEXT \
      label.highlight=off \
      label.color=$SPACE_WINDOW_INDICATOR \
      background.color=$SPACE_INACTIVE_BG \
      background.border_color=$SPACE_INACTIVE_BORDER \
      background.border_width=1 \
      background.corner_radius=10 \
      background.height=20 \
      background.shadow.drawing=off \
      icon.font="$FONT:Regular:14.0" \
      padding_left=2 \
      padding_right=2
  fi
}

set_space_label() {
  sketchybar --set $NAME icon="$@"
}

mouse_clicked() {
  if [ "$BUTTON" = "right" ]; then
    yabai -m space --destroy $SID
  else
    if [ "$MODIFIER" = "shift" ]; then
      SPACE_LABEL="$(osascript -e "return (text returned of (display dialog \"Give a name to space $NAME:\" default answer \"\" with icon note buttons {\"Cancel\", \"Continue\"} default button \"Continue\"))")"
      if [ $? -eq 0 ]; then
        if [ "$SPACE_LABEL" = "" ]; then
          set_space_label "${NAME:6}"
        else
          set_space_label "${NAME:6} ($SPACE_LABEL)"
        fi
      fi
    else
      yabai -m space --focus $SID 2>/dev/null
    fi
  fi
}

case "$SENDER" in
  "mouse.clicked") mouse_clicked
  ;;
  *) update
  ;;
esac
