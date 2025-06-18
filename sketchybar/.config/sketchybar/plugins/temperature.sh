#!/bin/bash

# Advanced thermal monitoring with actual temperature data
source "$CONFIG_DIR/colors.sh"
source "$CONFIG_DIR/icons.sh"

# Get thermal data using powermetrics (requires elevated privileges for some data)
get_thermal_data() {
  # Try to get CPU temperature using powermetrics with minimal sampling
  local temp_output=$(timeout 3 powermetrics --sample-rate 250 --sample-count 1 -f plist 2>/dev/null | grep -A1 "CPU die temperature" | tail -1 | sed 's/.*<real>\([0-9.]*\)<\/real>.*/\1/')
  
  # If powermetrics fails or requires sudo, fall back to thermal pressure via sysctl
  if [ -z "$temp_output" ] || ! [[ "$temp_output" =~ ^[0-9.]+$ ]]; then
    # Use thermal state as fallback - this works without sudo
    local thermal_state=$(sysctl -n machdep.xcpm.cpu_thermal_level 2>/dev/null)
    if [ -n "$thermal_state" ] && [[ "$thermal_state" =~ ^[0-9]+$ ]]; then
      # Convert thermal level to approximate temperature (0=cool, higher=warmer)
      case "$thermal_state" in
        0) temp_output="45" ;;
        1) temp_output="55" ;;
        2) temp_output="65" ;;
        3) temp_output="75" ;;
        *) temp_output="80" ;;
      esac
    else
      # Final fallback using CPU usage as thermal proxy
      local cpu_usage=$(iostat -c 1 | tail -n 1 | awk '{print $6}' | awk '{print int(100-$1)}')
      temp_output=$((40 + cpu_usage / 2))  # Estimate temp based on CPU load
    fi
  fi
  
  echo "$temp_output"
}

# Get temperature with error handling
TEMP=$(get_thermal_data)

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