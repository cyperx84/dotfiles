#!/bin/bash

WIDTH=100

detail_on() {
	sketchybar --animate tanh 30 --set volume slider.width=$WIDTH
}

detail_off() {
	sketchybar --animate tanh 30 --set volume slider.width=0
}

toggle_detail() {
	INITIAL_WIDTH=$(sketchybar --query volume | jq -r ".slider.width")
	if [ "$INITIAL_WIDTH" -eq "0" ]; then
		detail_on
	else
		detail_off
	fi
}

toggle_devices() {
	which SwitchAudioSource >/dev/null || exit 0
	source "$CONFIG_DIR/colors.sh"
	source "$CONFIG_DIR/icons.sh"

	args=(--remove '/volume.device\.*/' --set "$NAME" popup.drawing=toggle)
	COUNTER=0
	CURRENT="$(SwitchAudioSource -t output -c)"
	while IFS= read -r device; do
		COLOR=$GREY
		ICON_COLOR=$GREY
		if [ "${device}" = "$CURRENT" ]; then
			COLOR=$WHITE
			ICON_COLOR=$GREEN
		fi
		args+=(--clone volume.device.$COUNTER volume.template
			--set volume.device.$COUNTER \
			icon="$AUDIO_DEVICE" \
			icon.color="$ICON_COLOR" \
			icon.font="$ICON_FONT" \
			label="${device}" \
			label.color="$COLOR" \
			label.font="$LABEL_FONT" \
			drawing=on \
			click_script="SwitchAudioSource -s \"${device}\" && sketchybar --set /volume.device\.*/ label.color=$GREY icon.color=$GREY --set \$NAME label.color=$WHITE icon.color=$GREEN --set volume_icon popup.drawing=off")
		COUNTER=$((COUNTER + 1))
	done <<<"$(SwitchAudioSource -a -t output)"

	sketchybar -m "${args[@]}" >/dev/null
}

popup() {
	sketchybar --set volume_icon popup.drawing=$1
}

case "$SENDER" in
"mouse.entered")
	if command -v SwitchAudioSource &> /dev/null; then
		toggle_devices
	fi
	;;
"mouse.exited" | "mouse.exited.global")
	popup off
	;;
"mouse.clicked")
	if [ "$BUTTON" = "right" ] || [ "$MODIFIER" = "shift" ]; then
		toggle_devices
	else
		toggle_detail
	fi
	;;
*)
	if [ "$BUTTON" = "right" ] || [ "$MODIFIER" = "shift" ]; then
		toggle_devices
	else
		toggle_detail
	fi
	;;
esac
