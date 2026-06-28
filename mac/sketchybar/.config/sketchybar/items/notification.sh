#!/bin/bash

notification=(
  updates=on
  # update_freq=10
  label.drawing=off
  padding_right=3
  label.font="$FONT:Bold:10.0"
  # label.padding_left=3
  script="$PLUGIN_DIR/notification.sh"
)

sketchybar --add item notification right \
  --set notification "${notification[@]}"
