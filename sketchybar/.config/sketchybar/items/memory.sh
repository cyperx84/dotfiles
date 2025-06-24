#!/bin/bash

memory=(
  icon=$MEMORY
  icon.font="MonaspiceKr Nerd Font:Bold:20.0"
  icon.color=$MAGENTA
  label.font="MonaspiceKr Nerd Font:Medium:8.0"
  label.color=$WHITE
  padding_left=2
  padding_right=2
  background.drawing=off
  update_freq=2
  script="$PLUGIN_DIR/memory.sh"
)

sketchybar --add item memory right \
  --set memory "${memory[@]}"
