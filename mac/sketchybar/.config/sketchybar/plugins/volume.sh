#!/bin/bash

WIDTH=100

volume_change() {
	CONFIG_DIR="${CONFIG_DIR:-${HOME}/.config/sketchybar}"
	source "$CONFIG_DIR/icons.sh"
	source "$CONFIG_DIR/colors.sh"

	# Determine icon based on volume level
	case $INFO in
	[6-9][0-9] | 100)
		ICON=$VOLUME_100
		;;
	[3-5][0-9])
		ICON=$VOLUME_66
		;;
	[1-2][0-9])
		ICON=$VOLUME_33
		;;
	[1-9])
		ICON=$VOLUME_10
		;;
	0)
		ICON=$VOLUME_0
		;;
	*) ICON=$VOLUME_100 ;;
	esac

	# Determine color based on volume level
	if [ "$INFO" -eq 0 ]; then
		COLOR=$GREY  # Muted
	elif [ "$INFO" -gt 70 ]; then
		COLOR=$GREEN  # High volume
	elif [ "$INFO" -gt 30 ]; then
		COLOR=$YELLOW  # Medium volume
	else
		COLOR=$ORANGE  # Low volume
	fi

	sketchybar --set volume_icon icon=$ICON icon.color=$COLOR \
		--set $NAME slider.percentage=$INFO

	INITIAL_WIDTH="$(sketchybar --query $NAME | jq -r ".slider.width")"
	if [ "$INITIAL_WIDTH" -eq "0" ]; then
		sketchybar --animate tanh 30 --set $NAME slider.width=$WIDTH
	fi

	# Reduced sleep for faster UI response (was 2, now 1)
	# This wait allows the animation to be visible before auto-collapsing
	sleep 1

	# Check whether the volume was changed another time while sleeping
	FINAL_PERCENTAGE="$(sketchybar --query $NAME | jq -r ".slider.percentage")"
	if [ "$FINAL_PERCENTAGE" -eq "$INFO" ]; then
		sketchybar --animate tanh 30 --set $NAME slider.width=0
	fi
}

mouse_clicked() {
	osascript -e "set volume output volume $PERCENTAGE"
}

case "$SENDER" in
"volume_change")
	volume_change
	;;
"mouse.clicked")
	mouse_clicked
	;;
esac
