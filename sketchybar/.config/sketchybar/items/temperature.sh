#!/bin/bash

temperature=(
  icon=$TEMPERATURE
  icon.font="MonaspiceKr Nerd Font:Bold:20.0"
  icon.color=$YELLOW
  label.font="MonaspiceKr Nerd Font:Medium:12.0"
  label.color=$WHITE
  padding_left=1
  padding_right=4
  update_freq=5
  script="$PLUGIN_DIR/temperature.sh"
)

sketchybar --add item temperature right \
  --set temperature "${temperature[@]}"