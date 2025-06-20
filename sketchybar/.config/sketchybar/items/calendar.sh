#!/bin/bash
calendar=(
	icon=cal
	# Using "JetBrainsMono Nerd Font"
	icon.font="MonaspiceKr Nerd Font:Medium:12.0"
	icon.color=$GREEN
	# Using default "SF Pro"
	# icon.font="$FONT:Black:12.0"
	icon.padding_right=0
	# If showing the time, leave the width as 45
	# label.width=45
	label.width=5
	label.align=right
	padding_left=15
	update_freq=30
	script="$PLUGIN_DIR/calendar.sh"
	click_script="$PLUGIN_DIR/zen.sh"
)

sketchybar --add item calendar right \
	--set calendar "${calendar[@]}" \
	--subscribe calendar system_woke
