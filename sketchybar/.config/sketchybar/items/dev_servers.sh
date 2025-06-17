#!/bin/bash

dev_servers=(
  icon=$DEV_SERVER
  icon.font="$ICON_FONT"
  icon.color=$GREEN
  label.font="$LABEL_FONT"
  label.color=$WHITE
  padding_left=2
  padding_right=4
  update_freq=15
  script="$PLUGIN_DIR/dev_servers.sh"
  click_script="open http://localhost:3000"
)

sketchybar --add item dev_servers left \
  --set dev_servers "${dev_servers[@]}"