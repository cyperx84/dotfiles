#!/bin/bash

tmux_status=(
  icon=$TMUX
  icon.font="MonaspiceKr Nerd Font:Bold:20.0"
  icon.color=$GREEN
  label.font="MonaspiceKr Nerd Font:Medium:12.0"
  label.color=$WHITE
  padding_left=2
  padding_right=4
  update_freq=5
  script="$PLUGIN_DIR/tmux.sh"
  click_script="osascript -e 'tell application \"Terminal\" to activate' -e 'tell application \"Terminal\" to do script \"tmux list-sessions\"'"
)

sketchybar --add item tmux_status left \
  --set tmux_status "${tmux_status[@]}"