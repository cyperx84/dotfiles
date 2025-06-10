#!/bin/bash

memory=(
  icon=$MEMORY
  icon.font="MonaspiceKr Nerd Font:Bold:20.0"
  icon.color=$MAGENTA
  label.font="MonaspiceKr Nerd Font:Medium:12.0"
  label.color=$WHITE
  padding_left=1
  padding_right=4
  update_freq=10
  script="$PLUGIN_DIR/memory.sh"
)

sketchybar --add item memory right \
  --set memory "${memory[@]}"