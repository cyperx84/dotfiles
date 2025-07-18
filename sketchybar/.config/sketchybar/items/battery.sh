#!/bin/bash

battery=(
	script="$PLUGIN_DIR/battery.sh"
	icon.font="MonaspiceKr Nerd Font:Regular:24.0"
	icon.color=$YELLOW
	padding_right=3
	padding_left=0
	label.drawing=on
	update_freq=120
	updates=on
)

sketchybar --add item battery right \
	--set battery "${battery[@]}" \
	--subscribe battery power_source_change system_woke
