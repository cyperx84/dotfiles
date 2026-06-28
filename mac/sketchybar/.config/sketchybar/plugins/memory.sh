#!/bin/bash

# Simple and efficient memory monitoring using macmon
source "$CONFIG_DIR/colors.sh"

# Get memory stats from macmon
# Output format: ram_usage|ram_total
# Increased timeout to 3s as 1s was sometimes insufficient
MEM_DATA=$(timeout 3 macmon pipe -s 1 -i 100 2>/dev/null | jq -r '.memory.ram_usage, .memory.ram_total' | tr '\n' '|')

# Parse output
USED_BYTES=$(echo "$MEM_DATA" | cut -d'|' -f1)
TOTAL_BYTES=$(echo "$MEM_DATA" | cut -d'|' -f2)

# Fallback defaults if macmon fails
if [ -z "$USED_BYTES" ] || [ "$USED_BYTES" = "null" ]; then
  USED_BYTES=0
  TOTAL_BYTES=1
fi

# Calculate GB and Percentage using bash arithmetic
# 1 GB = 1073741824 bytes
USED_GB=$(( USED_BYTES / 1073741824 ))
PERCENTAGE=$(( USED_BYTES * 100 / TOTAL_BYTES ))

# Color logic
if [ "$PERCENTAGE" -gt 80 ]; then
  COLOR=$RED
  ICON_COLOR=$RED
elif [ "$PERCENTAGE" -gt 70 ]; then
  COLOR=$ORANGE
  ICON_COLOR=$ORANGE
elif [ "$PERCENTAGE" -gt 50 ]; then
  COLOR=$MAGENTA
  ICON_COLOR=$MAGENTA
else
  COLOR=$GREEN
  ICON_COLOR=$GREEN
fi

# Display: "21G 64%"
sketchybar --set $NAME label="${USED_GB}G ${PERCENTAGE}%" \
                    label.color=$COLOR \
                    icon.color=$ICON_COLOR
