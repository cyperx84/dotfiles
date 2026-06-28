#!/bin/bash

# RAM plugin - pushes data to graph with smoothing

source "$CONFIG_DIR/colors.sh"

ALPHA=0.08
CACHE_FILE="/tmp/sketchybar_ram_cache"

# Get memory stats from macmon
MEM_DATA=$(timeout 3 macmon pipe -s 1 -i 100 2>/dev/null | jq -r '.memory.ram_usage, .memory.ram_total' | tr '\n' '|')

USED_BYTES=$(echo "$MEM_DATA" | cut -d'|' -f1)
TOTAL_BYTES=$(echo "$MEM_DATA" | cut -d'|' -f2)

# Fallback if macmon fails
if [ -z "$USED_BYTES" ] || [ "$USED_BYTES" = "null" ]; then
  sketchybar --set ram.percent label="--%"
  exit 0
fi

PERCENTAGE=$(( USED_BYTES * 100 / TOTAL_BYTES ))

# Load previous smoothed value
if [[ -f "$CACHE_FILE" ]]; then
  source "$CACHE_FILE"
else
  SMOOTH_RAM=$PERCENTAGE
fi

# Apply exponential moving average
SMOOTH_RAM=$(awk -v a="$ALPHA" -v cur="$PERCENTAGE" -v prev="${SMOOTH_RAM:-$PERCENTAGE}" \
  'BEGIN {printf "%.1f", a * cur + (1-a) * prev}')

echo "SMOOTH_RAM=$SMOOTH_RAM" > "$CACHE_FILE"

DISPLAY_PCT=$(printf "%.0f" "$SMOOTH_RAM")

# Color based on usage
if [ "$DISPLAY_PCT" -gt 85 ]; then
  COLOR=$RED
elif [ "$DISPLAY_PCT" -gt 70 ]; then
  COLOR=$ORANGE
elif [ "$DISPLAY_PCT" -gt 50 ]; then
  COLOR=$YELLOW
else
  COLOR=$GREEN
fi

GRAPH_VAL=$(awk -v v="$SMOOTH_RAM" 'BEGIN {printf "%.2f", v/100}')

sketchybar --set ram.percent label="${DISPLAY_PCT}%" label.color=$COLOR \
           --push ram.graph "$GRAPH_VAL"
