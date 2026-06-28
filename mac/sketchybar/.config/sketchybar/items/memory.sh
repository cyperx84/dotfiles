#!/bin/bash

# Single memory item (icon + compact label showing GB and %)
# No popup - just display
memory=(
  icon=$MEMORY
  icon.font="MonaspiceKr Nerd Font:Bold:20.0"
  icon.color=$MAGENTA
  label.font="MonaspiceRn Nerd Font:Heavy:10"
  label.color=$WHITE
  padding_left=2
  padding_right=2
  background.drawing=off
  update_freq=10
  script="$PLUGIN_DIR/memory.sh"
)

sketchybar --add item memory right \
           --set memory "${memory[@]}"
