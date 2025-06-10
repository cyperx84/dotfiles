#!/bin/bash
brew=(
  icon=󰏖
  icon.font="MonaspiceKr Nerd Font:Bold:20.0"
  icon.color=$ORANGE
  label=?
  # Set update frequency to 30 min (30*60=1800)
  update_freq=1800
  padding_right=12
  label.padding_left=2
  script="$PLUGIN_DIR/brew.sh"
)

sketchybar --add event brew_update \
  --add item brew right \
  --set brew "${brew[@]}" \
  --subscribe brew brew_update
