#!/bin/bash

source "$CONFIG_DIR/colors.sh"

# Get battery status
BATTERY_INFO="$(pmset -g batt)"
PERCENTAGE=$(echo "$BATTERY_INFO" | grep -Eo "[0-9]+%" | head -1 | tr -d '%')
CHARGING=$(echo "$BATTERY_INFO" | grep -q 'AC Power' && echo "yes" || echo "no")

# Get real-time power usage from macmon (Apple Silicon specific)
# Uses total system power (sys_power)
POWER_WATT=$(timeout 3 macmon pipe -s 1 -i 100 2>/dev/null | jq -r '.sys_power' 2>/dev/null)
POWER_LABEL=""

if [[ -n "$POWER_WATT" ]] && [[ "$POWER_WATT" != "null" ]]; then
  # Format to integer
  POWER_INT=$(printf "%.0f" "$POWER_WATT")
  if [ "$CHARGING" = "yes" ]; then
    POWER_LABEL=" +${POWER_INT}W"
  else
    POWER_LABEL=" -${POWER_INT}W"
  fi
fi

if ! echo "$BATTERY_INFO" | grep -q "InternalBattery"; then
  sketchybar --set "$NAME" drawing=off
  exit 0
else
  sketchybar --set "$NAME" drawing=on
fi

if [ "$PERCENTAGE" = "" ]; then
  exit 0
fi

COLOR=$WHITE
case "${PERCENTAGE}" in
[8-9][0-9] | 100)
  ICON=""
  COLOR=$GREEN
  ;;
[3-7][0-9])
  ICON=""
  COLOR=$YELLOW
  ;;
[1-2][0-9])
  ICON=""
  COLOR=$RED
  ;;
*) ICON="" ;;
esac

if [ "$CHARGING" = "yes" ]; then
  ICON=""
fi

sketchybar --set "$NAME" icon="$ICON" label="${PERCENTAGE}%${POWER_LABEL}" icon.color=$COLOR
