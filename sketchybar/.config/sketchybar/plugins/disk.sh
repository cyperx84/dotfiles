#!/bin/bash

# Get APFS container info for accurate disk usage
# This queries the container level to get total space including all volumes
CONTAINER_INFO=$(diskutil info / | grep "APFS Container:" | awk '{print $3}')

if [ -n "$CONTAINER_INFO" ]; then
  # Get container statistics from diskutil apfs list
  APFS_INFO=$(diskutil apfs list | grep -A 20 "Container $CONTAINER_INFO")

  # Extract capacity in use and total size (in bytes)
  # Format: "Capacity In Use By Volumes:   196924870656 B (196.9 GB) (39.4% used)"
  CAPACITY_USED=$(echo "$APFS_INFO" | grep "Capacity In Use By Volumes:" | awk '{print $6}')
  # Format: "Size (Capacity Ceiling):      499963174912 B (500.0 GB)"
  TOTAL_SIZE=$(echo "$APFS_INFO" | grep "Size (Capacity Ceiling):" | awk '{print $4}')

  # Calculate percentage if we have valid data
  if [ -n "$CAPACITY_USED" ] && [ -n "$TOTAL_SIZE" ]; then
    DISK_PERCENT=$(echo "scale=0; $CAPACITY_USED * 100 / $TOTAL_SIZE" | bc)
    DISK_USED_GB=$(echo "scale=1; $CAPACITY_USED / 1024 / 1024 / 1024" | bc)
    DISK_TOTAL_GB=$(echo "scale=0; $TOTAL_SIZE / 1024 / 1024 / 1024" | bc)
  else
    # Fallback to df if diskutil parsing fails
    DISK_INFO=$(df -h / | tail -1)
    DISK_PERCENT=$(echo $DISK_INFO | awk '{print $5}' | tr -d '%')
  fi
else
  # Fallback for non-APFS filesystems
  DISK_INFO=$(df -h / | tail -1)
  DISK_PERCENT=$(echo $DISK_INFO | awk '{print $5}' | tr -d '%')
fi

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