#!/bin/bash

network=(
  icon=$NETWORK_UP
  icon.font="MonaspiceKr Nerd Font:Bold:20.0"
  icon.color=$BLUE
  label.font="MonaspiceKr Nerd Font:Medium:12.0"
  label.color=$WHITE
  padding_left=1
  padding_right=4
  update_freq=2
  script="$PLUGIN_DIR/network.sh"
)

sketchybar --add item network right \
  --set network "${network[@]}"