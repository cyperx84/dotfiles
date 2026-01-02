#!/bin/bash

tmux_status=(
  icon=$TMUX
  icon.font="$ICON_FONT"
  icon.color=$GREEN
  label.font="$LABEL_FONT"
  label.color=$WHITE
  padding_left=2
  padding_right=4
  update_freq=5
  script="$PLUGIN_DIR/tmux.sh"
  # click_script="osascript -e 'tell application \"Terminal\" to activate' -e 'tell application \"Terminal\" to do script \"tmux list-sessions\"'"
)

sketchybar --add item tmux_status left \
  --set tmux_status "${tmux_status[@]}"
