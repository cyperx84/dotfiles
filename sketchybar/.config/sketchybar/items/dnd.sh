#!/bin/bash
dnd=(
  updates=on
  label.font="$FONT:Regular:10.0"
  update_freq=10
  padding_right=2
  padding_left=4
  label.padding_left=0
  label.drawing=on
  script="$PLUGIN_DIR/dnd.sh"
)

sketchybar --add item dnd right \
  --set dnd "${dnd[@]}"
