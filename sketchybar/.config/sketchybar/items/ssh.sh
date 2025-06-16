#!/bin/bash

ssh_status=(
  icon=$SSH
  icon.font="MonaspiceKr Nerd Font:Bold:20.0"
  icon.color=$BLUE
  label.font="MonaspiceKr Nerd Font:Medium:12.0"
  label.color=$WHITE
  padding_left=2
  padding_right=4
  update_freq=5
  script="$PLUGIN_DIR/ssh.sh"
  click_script="osascript -e 'tell application \"Terminal\" to activate' -e 'tell application \"Terminal\" to do script \"ssh \"'"
)

sketchybar --add item ssh_status left \
  --set ssh_status "${ssh_status[@]}"