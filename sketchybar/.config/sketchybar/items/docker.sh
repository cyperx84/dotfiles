#!/bin/bash

docker_status=(
  icon=$DOCKER
  icon.font="MonaspiceKr Nerd Font:Bold:20.0"
  icon.color=$BLUE
  label.font="MonaspiceKr Nerd Font:Medium:12.0"
  label.color=$WHITE
  padding_left=2
  padding_right=4
  update_freq=10
  script="$PLUGIN_DIR/docker.sh"
  click_script="open -a 'Docker Desktop'"
)

sketchybar --add item docker_status left \
  --set docker_status "${docker_status[@]}"