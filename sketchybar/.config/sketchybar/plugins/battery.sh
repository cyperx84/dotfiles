#!/bin/bash

source "$CONFIG_DIR/colors.sh"

# Single pmset call - reuse output (optimized)
BATTERY_INFO="$(pmset -g batt)"

# Extract percentage from cached output
PERCENTAGE=$(echo "$BATTERY_INFO" | grep -Eo "[0-9]+%" | head -1 | tr -d '%')

# Check if charging from cached output
CHARGING=$(echo "$BATTERY_INFO" | grep -q 'AC Power' && echo "yes" || echo "no")

# Check for the absence of "InternalBattery" to determine no battery present
# My mac mini doesn't have a battery, and it was leaving a blank space where the
# battery was supposed to be
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
# [3-5][0-9])
#   ICON=""
#   COLOR=$YELLOW
#   ;;
[1-2][0-9])
  ICON=""
  COLOR=$RED
  ;;
*) ICON="" ;;
esac

if [ "$CHARGING" = "yes" ]; then
  ICON=""
fi

# The item invoking this script (name $NAME) will get its icon and label
# updated with the current battery status
sketchybar --set "$NAME" icon="$ICON" label="${PERCENTAGE}" icon.color=$COLOR
