#!/bin/bash

# CPU temperature monitoring using osx-cpu-temp
source "$CONFIG_DIR/colors.sh"
source "$CONFIG_DIR/icons.sh"

# Get CPU temperature using osx-cpu-temp (fast and accurate)
get_cpu_temp() {
  # osx-cpu-temp returns format like "61.1°C"
  local temp_output=$(osx-cpu-temp -C 2>/dev/null)

  if [ -n "$temp_output" ]; then
    # Extract numeric value (e.g., "61.1" from "61.1°C")
    echo "$temp_output" | sed 's/°C//' | tr -d ' '
  else
    # Fallback to thermal state if osx-cpu-temp fails
    local thermal_state=$(sysctl -n machdep.xcpm.cpu_thermal_level 2>/dev/null)
    if [ -n "$thermal_state" ] && [[ "$thermal_state" =~ ^[0-9]+$ ]]; then
      # Convert thermal level to approximate temperature
      case "$thermal_state" in
        0) echo "45" ;;
        1) echo "55" ;;
        2) echo "65" ;;
        3) echo "75" ;;
        *) echo "80" ;;
      esac
    else
      echo "50"  # Safe default
    fi
  fi
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