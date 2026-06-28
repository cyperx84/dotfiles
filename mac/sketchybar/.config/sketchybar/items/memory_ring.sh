#!/bin/bash

# Option D: Icon + Ring style RAM display
# Uses Unicode circle segments to show usage level

source "$CONFIG_DIR/colors.sh"

memory_ring=(
  icon=󰍛
  icon.font="MonaspiceKr Nerd Font:Bold:16.0"
  icon.color=$MAGENTA
  icon.padding_right=0
  label.font="MonaspiceRn Nerd Font:Bold:14.0"
  label.color=$GREEN
  label.padding_left=2
  padding_left=4
  padding_right=4
  background.drawing=off
  update_freq=10
  script="$PLUGIN_DIR/memory_ring.sh"
)

sketchybar --add item memory_ring right \
           --set memory_ring "${memory_ring[@]}"
