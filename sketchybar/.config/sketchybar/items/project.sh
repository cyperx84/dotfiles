#!/bin/bash

project=(
  icon=$PROJECT
  icon.font="MonaspiceKr Nerd Font:Bold:20.0"
  icon.color=$BLUE
  label.font="MonaspiceKr Nerd Font:Medium:12.0"
  label.color=$WHITE
  padding_left=2
  padding_right=4
  update_freq=10
  script="$PLUGIN_DIR/project.sh"
  click_script="open ."
)

sketchybar --add item project left \
  --set project "${project[@]}"