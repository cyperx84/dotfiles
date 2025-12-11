#!/bin/bash

# Use df for faster disk usage (much lighter than diskutil apfs list)
# Single awk extraction for used, total, and percent
read USED TOTAL PERCENT < <(
  df -h / 2>/dev/null | awk 'NR==2 {
    used=$3; total=$2; percent=$5;
    # Remove G, Gi, GB, T, Ti, TB suffixes
    gsub(/[GT]i?B?/, "", used);
    gsub(/[GT]i?B?/, "", total);
    gsub(/%/, "", percent);
    print used, total, percent
  }'
)

# Validate we got values
[ -z "$PERCENT" ] && PERCENT=0
[ -z "$USED" ] && USED="0"
[ -z "$TOTAL" ] && TOTAL="0"

# Convert PERCENT to integer for comparison (remove decimal part)
DISK_PERCENT_INT=${PERCENT%.*}

# Set color based on usage
if [ "$DISK_PERCENT_INT" -gt 90 ]; then
  COLOR="0xffed8796"  # Red
elif [ "$DISK_PERCENT_INT" -gt 75 ]; then
  COLOR="0xfff5a97f"  # Orange
else
  COLOR="0xffa6da95"  # Green
fi

sketchybar --set $NAME label="${DISK_PERCENT_INT}%" \
                    label.color=$COLOR
