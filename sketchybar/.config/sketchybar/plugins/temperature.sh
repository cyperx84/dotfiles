#!/bin/bash

# Simple thermal monitor using iostat for CPU load
CPU_IDLE=$(iostat -c 1 | tail -n 1 | awk '{print $6}')

if [ -n "$CPU_IDLE" ] && [ "$CPU_IDLE" != "idle" ]; then
  # Calculate CPU usage from idle percentage
  CPU_USAGE=$(echo "100 - $CPU_IDLE" | bc -l | cut -d'.' -f1)
  
  # Estimate thermal state based on CPU usage (compact)
  if [ "$CPU_USAGE" -gt 80 ]; then
    COLOR="0xffed8796"  # Red
    ICON="󰸁"
  elif [ "$CPU_USAGE" -gt 60 ]; then
    COLOR="0xfff5a97f"  # Orange
    ICON="󰔏"
  elif [ "$CPU_USAGE" -gt 40 ]; then
    COLOR="0xfff9e2af"  # Yellow
    ICON="󰔏"
  else
    COLOR="0xffa6da95"  # Green
    ICON="󰔏"
  fi
  
  sketchybar --set $NAME label="${CPU_USAGE}%" \
                      label.color=$COLOR \
                      icon="$ICON"
else
  # Simple static display
  sketchybar --set $NAME label="OK" \
                      label.color="0xffa6da95"
fi