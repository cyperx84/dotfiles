#!/bin/bash

# AeroSpace workspace integration following best practices
# https://nikitabobko.github.io/AeroSpace/goodies

SPACE_ICONS=("󱙝" "󱌇" "󱍏" "󱃋" "󰋄" "󰟟")

# Add aerospace workspace change event
sketchybar --add event aerospace_workspace_change

# Add space decorator (left side decoration)
# space_decorator=(
#   icon=󰯉
#   icon.font="$FONT:Heavy:20.0"
#   icon.color=$SPACE_ACTIVE_TEXT
#   padding_left=10
#   padding_right=8
#   label.drawing=off
#   display=active
# )

sketchybar --add item space_decorator center \
           --set space_decorator "${space_decorator[@]}"

for sid in 1 2 3 4 5 6
do
  # Use custom icon if available, otherwise use default
  i=$((sid - 1))
  if [ $i -lt ${#SPACE_ICONS[@]} ]; then
    ICON="${SPACE_ICONS[i]}"
  else
    ICON="󰿉"
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
             --subscribe space.$sid aerospace_workspace_change mouse.clicked \
             --set space.$sid "${space[@]}"

  # Set initial window count
  "$PLUGIN_DIR/space_window_count.sh" "$sid"
done

# space_creator=(
#   icon=󰯉
#   icon.font="$FONT:Heavy:20.0"
#   icon.color=$SPACE_ACTIVE_TEXT
#   padding_left=10
#   padding_right=8
#   label.drawing=off
#   display=active
# )

sketchybar --add item space_creator center \
           --set space_creator "${space_creator[@]}"
