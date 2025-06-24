#!/bin/bash

SPACE_ICONS=("👾" "🌀" "⚡️" "🔥" "🌟" "🎨" "🚀" "📦" "🔔" "✈️" "🧊" "🔮")

# Destroy space on right click, focus space on left click.
# New space by left clicking separator (>)

sid=0
spaces=()
for i in "${!SPACE_ICONS[@]}"
do
  sid=$(($i+1))

  space=(
    space=$sid
    icon="${SPACE_ICONS[i]}"
    icon.padding_left=8
    icon.padding_right=2
    label.padding_left=2
    label.padding_right=8
    padding_left=1
    padding_right=1
    icon.highlight_color=$SPACE_ACTIVE_TEXT
    label.color=$SPACE_WINDOW_INDICATOR
    label.highlight_color=$SPACE_WINDOW_INDICATOR
    label.font="sketchybar-app-font:Medium:14.0"
    label.y_offset=0
    background.color=$SPACE_INACTIVE_BG
    background.border_color=$SPACE_INACTIVE_BORDER
    background.corner_radius=10
    background.height=20
    background.border_width=1
    script="$PLUGIN_DIR/space.sh"
  )

  sketchybar --add space space.$sid left    \
             --set space.$sid "${space[@]}" \
             --subscribe space.$sid mouse.clicked space_change
done

space_creator=(
  icon=󱙝
  icon.font="$FONT:Heavy:16.0"
  padding_left=10
  padding_right=8
  label.drawing=off
  display=active
  click_script='yabai -m space --create'
  script="$PLUGIN_DIR/space_windows.sh"
  icon.color=$WHITE
)

sketchybar --add item space_creator left               \
           --set space_creator "${space_creator[@]}"   \
           --subscribe space_creator space_windows_change windows_on_spaces
