#!/bin/bash

# Option D: Ring/Donut style RAM display
# Shows memory usage as a Unicode circle segment

source "$CONFIG_DIR/colors.sh"

# Get memory stats from macmon
MEM_DATA=$(timeout 3 macmon pipe -s 1 -i 100 2>/dev/null | jq -r '.memory.ram_usage, .memory.ram_total' | tr '\n' '|')

USED_BYTES=$(echo "$MEM_DATA" | cut -d'|' -f1)
TOTAL_BYTES=$(echo "$MEM_DATA" | cut -d'|' -f2)

# Fallback if macmon fails
if [ -z "$USED_BYTES" ] || [ "$USED_BYTES" = "null" ]; then
  USED_BYTES=0
  TOTAL_BYTES=1
fi

PERCENTAGE=$(( USED_BYTES * 100 / TOTAL_BYTES ))

# Select ring character based on percentage
# ○ = empty, ◔ = 25%, ◑ = 50%, ◕ = 75%, ● = full
if [ "$PERCENTAGE" -lt 15 ]; then
  RING="○"
elif [ "$PERCENTAGE" -lt 35 ]; then
  RING="◔"
elif [ "$PERCENTAGE" -lt 55 ]; then
  RING="◑"
elif [ "$PERCENTAGE" -lt 75 ]; then
  RING="◕"
else
  RING="●"
fi

# Color based on usage
if [ "$PERCENTAGE" -gt 85 ]; then
  COLOR=$RED
elif [ "$PERCENTAGE" -gt 70 ]; then
  COLOR=$ORANGE
elif [ "$PERCENTAGE" -gt 50 ]; then
  COLOR=$YELLOW
else
  COLOR=$GREEN
fi

sketchybar --set $NAME label="$RING" label.color=$COLOR icon.color=$COLOR
