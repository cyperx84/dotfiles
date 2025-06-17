#!/bin/bash

project=(
  icon=$PROJECT
  icon.font="$ICON_FONT"
  icon.color=$BLUE
  label.font="$LABEL_FONT"
  label.color=$WHITE
  padding_left=2
  padding_right=4
  update_freq=10
  script="$PLUGIN_DIR/project.sh"
  click_script="open ."
)

sketchybar --add item project left \
  --set project "${project[@]}"