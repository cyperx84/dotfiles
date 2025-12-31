#!/bin/bash

# HyprSpace workspace integration (optimized for instant updates)
# https://nikitabobko.github.io/AeroSpace/goodies

SPACE_ICONS=("󱙝" "󱌇" "󱍏" "󱃋" "󰋄" "󰟟")

# Add custom events for workspace and window changes
sketchybar --add event aerospace_workspace_change
sketchybar --add event window_change

for sid in 1 2 3 4 5 6 7 8 9 
do
  # Use custom icon if available, otherwise use default
  i=$((sid - 1))
  if [ $i -lt ${#SPACE_ICONS[@]} ]; then
    ICON="${SPACE_ICONS[i]}"
  else
    ICON="󰯈"
  fi

  space=(
    icon="$sid  $ICON"
    icon.color=$SPACE_WINDOW_INDICATOR
    icon.font="SF Pro:Semibold:14.0"
    icon.width=40
    icon.drawing=on
    icon.padding_left=8
    icon.padding_right=2
    label.width=20
    label.drawing=on
    label.padding_left=2
    label.padding_right=8
    padding_left=1
    padding_right=1
    icon.highlight_color=$SPACE_ACTIVE_TEXT
    label.color=$SPACE_ACTIVE_TEXT
    label.highlight_color=$SPACE_ACTIVE_TEXT
    label.font="sketchybar-app-font:Medium:14.0"
    label.y_offset=0
    background.color=$SPACE_INACTIVE_BG
    background.border_color=$SPACE_INACTIVE_BORDER
    background.corner_radius=10
    background.height=20
    background.border_width=1
    background.drawing=on
    script="$PLUGIN_DIR/aerospace.sh $sid"
  )

  sketchybar --add item space.$sid center \
             --subscribe space.$sid aerospace_workspace_change window_change front_app_switched mouse.clicked \
             --set space.$sid update_freq=2 "${space[@]}"

  # Set initial window count
  "$PLUGIN_DIR/space_window_count.sh" "$sid"
done

