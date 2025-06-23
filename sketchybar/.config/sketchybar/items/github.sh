#!/bin/bash

POPUP_CLICK_SCRIPT="sketchybar --set \$NAME popup.drawing=toggle"

github_bell=(
  padding_right=0
  padding_left=2
  label.padding_left=2
  label.padding_right=0
  update_freq=90
  icon=$GITHUB
  icon.font="$ICON_FONT"
  icon.color=$GREEN
  label=$LOADING
  label.highlight_color=$MAGENTA
  popup.align=right
  script="$PLUGIN_DIR/github.sh"
  click_script="$POPUP_CLICK_SCRIPT"
)

github_template=(
  drawing=off
  background.corner_radius=8
  background.color=$BG0O85
  background.border_width=1
  background.border_color=$BG2
  padding_left=10
  padding_right=10
  padding_top=4
  padding_bottom=4
  icon.background.height=3
  icon.background.corner_radius=2
  icon.background.y_offset=-14
  icon.padding_right=8
  label.padding_left=4
  label.max_chars=50
)

sketchybar --add event github.update \
  --add item github.bell right \
  --set github.bell "${github_bell[@]}" \
  --subscribe github.bell mouse.entered \
  mouse.exited \
  mouse.exited.global \
  system_woke \
  github.update \
  \
  --add item github.template popup.github.bell \
  --set github.template "${github_template[@]}"
