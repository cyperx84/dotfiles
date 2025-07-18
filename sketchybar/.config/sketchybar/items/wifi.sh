#!/bin/bash

# Filename: ~/github/dotfiles-latest/sketchybar/felixkratz-linkarzu/items/wifi.sh

source "$CONFIG_DIR/icons.sh"

wifi=(
  padding_right=6
  padding_left=0
  label.width=0
  label.max_chars=0
  label.padding_right=4
  icon="$WIFI_DISCONNECTED"
  icon.font="MonaspiceKr Nerd Font:Bold:20.0"
  icon.color=$BLUE
  script="$PLUGIN_DIR/wifi.sh"
)

sketchybar --add item wifi right \
  --set wifi "${wifi[@]}" \
  --subscribe wifi wifi_change mouse.clicked
