#!/bin/bash

front_app=(
  label.padding_left=4
  label.padding_right=10
  # Using "JetBrainsMono Nerd Font"
  label.font="MonaspiceRn Nerd Font:Bold:20.0"
  # Using default "SF Pro"
  # label.font="$FONT:Black:13.0"
  icon.background.drawing=on
  display=active
  script="$PLUGIN_DIR/front_app.sh"
  click_script="open -a 'Mission Control'"
)

sketchybar --add item front_app left \
  --set front_app "${front_app[@]}" \
  --subscribe front_app front_app_switched
