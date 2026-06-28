#!/bin/bash

# Monitoring the Data volume (where user files actually live)
# Using -H for Base 10 (Finder-like) values
DISK_INFO=$(df -H /System/Volumes/Data 2>/dev/null | awk 'END {print $5}')

# Remove % sign
PERCENT=${DISK_INFO%\%}

# Validate
if [[ -z "$PERCENT" || ! "$PERCENT" =~ ^[0-9]+$ ]]; then
  PERCENT=0
fi

# Color logic
if [ "$PERCENT" -gt 90 ]; then
  COLOR="0xffed8796"  # Red
elif [ "$PERCENT" -gt 75 ]; then
  COLOR="0xfff5a97f"  # Orange
else
  COLOR="0xffa6da95"  # Green
fi

sketchybar --set $NAME label="${PERCENT}%" \
                    label.color=$COLOR
