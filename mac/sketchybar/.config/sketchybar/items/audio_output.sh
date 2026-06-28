#!/bin/bash

audio_output=(
  script="$PLUGIN_DIR/audio_output.sh"
  update_freq=10
  updates=on
  padding_left=2
  padding_right=2
  icon.font="$ICON_FONT"
  icon.color=$GREEN
  label.font="$SMALL_LABEL_FONT"
  label.color=$GREEN
  label.padding_left=2
  label.padding_right=2
  click_script="$PLUGIN_DIR/volume_click.sh"
)

sketchybar --add item audio_output right \
  --set audio_output "${audio_output[@]}" \
  --subscribe audio_output volume_change mouse.clicked
