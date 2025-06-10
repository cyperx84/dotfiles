#!/bin/bash

git_status=(
  icon=$GIT_BRANCH
  icon.font="MonaspiceKr Nerd Font:Bold:20.0"
  icon.color=$GREEN
  label.font="MonaspiceKr Nerd Font:Medium:12.0"
  label.color=$WHITE
  padding_left=2
  padding_right=4
  update_freq=5
  script="$PLUGIN_DIR/git.sh"
  click_script="open -a 'Terminal' ."
)

sketchybar --add item git_status left \
  --set git_status "${git_status[@]}"