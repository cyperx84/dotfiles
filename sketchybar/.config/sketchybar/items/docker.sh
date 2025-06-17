#!/bin/bash

docker_status=(
  icon=$DOCKER
  icon.font="$ICON_FONT"
  icon.color=$BLUE
  label.font="$LABEL_FONT"
  label.color=$WHITE
  padding_left=2
  padding_right=4
  update_freq=10
  script="$PLUGIN_DIR/docker.sh"
  click_script="open -a 'Docker Desktop'"
)

sketchybar --add item docker_status left \
  --set docker_status "${docker_status[@]}"