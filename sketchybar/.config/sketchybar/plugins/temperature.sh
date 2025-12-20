#!/bin/bash

# CPU temperature monitoring using smctemp (direct SMC access)
source "$CONFIG_DIR/colors.sh"
source "$CONFIG_DIR/icons.sh"

# Get CPU temperature using smctemp's heatsink sensor (TH0x)
# This is more meaningful than die hotspot (TCMb) which is always high
get_cpu_temp() {
  # Try smctemp first - reads heatsink temp (TH0x) which is more useful
  if command -v smctemp &>/dev/null; then
    # Get TH0x (heatsink max) - more representative than die hotspot
    local heatsink=$(smctemp -l 2>/dev/null | grep "TH0x" | awk '{print $4}')

    if [[ -n "$heatsink" ]] && [[ "$heatsink" =~ ^[0-9.]+$ ]]; then
      local temp_int=${heatsink%.*}
      echo "$temp_int" > /tmp/sketchybar_temp_cache
      echo "$temp_int"
      return
    fi
  fi

  # Fallback to macmon if smctemp unavailable
  local macmon_data=$(timeout 3 macmon pipe -s 1 -i 100 2>/dev/null)
  if [ -n "$macmon_data" ]; then
    local temp=$(echo "$macmon_data" | jq -r '.temp.cpu_temp_avg' 2>/dev/null)
    if [[ -n "$temp" ]] && [[ "$temp" =~ ^[0-9.]+$ ]]; then
      local temp_int=${temp%.*}
      echo "$temp_int" > /tmp/sketchybar_temp_cache
      echo "$temp_int"
      return
    fi
  fi

  # Use cached value if available
  if [ -f /tmp/sketchybar_temp_cache ]; then
    cat /tmp/sketchybar_temp_cache
    return
  fi

  echo "40"  # Safe default
}

# Get temperature with error handling
TEMP=$(get_cpu_temp)

# Ensure we have a valid temperature
if [ -z "$TEMP" ] || ! [[ "$TEMP" =~ ^[0-9.]+$ ]]; then
  TEMP=50  # Safe default
fi

# Convert to integer for comparison
TEMP_INT=${TEMP%.*}

# Set color and icon based on temperature thresholds
if [ "$TEMP_INT" -gt 80 ]; then
  COLOR=$RED
  ICON="󰸁"  # Hot temperature icon
  TEMP_LABEL="${TEMP_INT}°"
elif [ "$TEMP_INT" -gt 70 ]; then
  COLOR=$ORANGE
  ICON="󰔏"  # Warning temperature icon
  TEMP_LABEL="${TEMP_INT}°"
elif [ "$TEMP_INT" -gt 60 ]; then
  COLOR=$YELLOW
  ICON="󰔏"  # Medium temperature icon
  TEMP_LABEL="${TEMP_INT}°"
else
  COLOR=$GREEN
  ICON="󰔏"  # Cool temperature icon
  TEMP_LABEL="${TEMP_INT}°"
fi

# Update the display
sketchybar --set $NAME label="$TEMP_LABEL" \
                    label.color=$COLOR \
                    icon="$ICON"
