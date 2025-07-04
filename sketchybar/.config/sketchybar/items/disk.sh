#!/bin/bash

disk=(
  icon=$DISK
  icon.font="MonaspiceKr Nerd Font:Bold:20.0"
  icon.color=$ORANGE
  label.font="MonaspiceKr Nerd Font:Medium:8.0"
  label.color=$WHITE
  padding_left=2
  padding_right=2
  background.drawing=off
  update_freq=30
  script="$PLUGIN_DIR/disk.sh"
)

sketchybar --add item disk right \
  --set disk "${disk[@]}"
