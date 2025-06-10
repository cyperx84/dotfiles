#!/bin/bash

# Get disk usage for root filesystem
DISK_INFO=$(df -h / | tail -1)
DISK_USED=$(echo $DISK_INFO | awk '{print $3}')
DISK_TOTAL=$(echo $DISK_INFO | awk '{print $2}')
DISK_PERCENT=$(echo $DISK_INFO | awk '{print $5}' | tr -d '%')

# Set color based on usage
if [ "$DISK_PERCENT" -gt 90 ]; then
  COLOR="0xffed8796"  # Red
elif [ "$DISK_PERCENT" -gt 75 ]; then
  COLOR="0xfff5a97f"  # Orange
else
  COLOR="0xffa6da95"  # Green
fi

sketchybar --set $NAME label="${DISK_PERCENT}%" \
                    label.color=$COLOR