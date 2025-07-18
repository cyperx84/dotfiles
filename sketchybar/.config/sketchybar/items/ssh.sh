#!/bin/bash

ssh_status=(
  icon=$SSH
  icon.font="$ICON_FONT"
  icon.color=$BLUE
  label.font="$LABEL_FONT"
  label.color=$WHITE
  padding_left=2
  padding_right=4
  update_freq=5
  script="$PLUGIN_DIR/ssh.sh"
  click_script="osascript -e 'tell application \"Terminal\" to activate' -e 'tell application \"Terminal\" to do script \"ssh \"'"
)

sketchybar --add item ssh_status left \
  --set ssh_status "${ssh_status[@]}"