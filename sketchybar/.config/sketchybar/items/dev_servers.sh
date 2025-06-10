#!/bin/bash

dev_servers=(
  icon=$DEV_SERVER
  icon.font="MonaspiceKr Nerd Font:Bold:20.0"
  icon.color=$GREEN
  label.font="MonaspiceKr Nerd Font:Medium:12.0"
  label.color=$WHITE
  padding_left=2
  padding_right=4
  update_freq=15
  script="$PLUGIN_DIR/dev_servers.sh"
  click_script="open http://localhost:3000"
)

sketchybar --add item dev_servers left \
  --set dev_servers "${dev_servers[@]}"