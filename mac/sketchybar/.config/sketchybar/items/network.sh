#!/bin/bash

network=(
  icon=$NETWORK_UP
  icon.font="MonaspiceKr Nerd Font:Bold:20.0"
  icon.color=$BLUE
  label.font="MonaspiceKr Nerd Font:Medium:8.0"
  label.color=$WHITE
  padding_left=2
  padding_right=4
  background.drawing=off
  update_freq=10
  script="$PLUGIN_DIR/network.sh"
)

sketchybar --add item network right \
  --set network "${network[@]}"
