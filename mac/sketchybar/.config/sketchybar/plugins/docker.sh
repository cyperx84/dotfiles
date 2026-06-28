#!/bin/bash

# Docker plugin with resource monitoring
# Displays: container count, CPU%, and Memory usage
# Format: "3 12%/1.2G" (3 containers, 12% CPU, 1.2GB RAM)

# Check if NAME variable is set
if [ -z "$NAME" ]; then
  echo "Error: NAME variable not set" >&2
  exit 1
fi

# Check if Docker is available
if ! command -v docker &> /dev/null; then
  sketchybar --set $NAME drawing=off 2>/dev/null
  exit 0
fi

# Check if Docker daemon is running - hide if not running
if ! docker info &>/dev/null 2>&1; then
  sketchybar --set $NAME drawing=off 2>/dev/null
  exit 0
fi

# Docker is running - make sure we're visible
sketchybar --set $NAME drawing=on 2>/dev/null

# Get running container count
CONTAINER_COUNT=$(docker ps -q 2>/dev/null | wc -l | xargs)

# Colors from colors.sh
GREY="0xff6e6a86"
GREEN="0xffa6da95"
LIME="0xff80ff00"
ORANGE="0xfff5a97f"
RED="0xffed8796"

# No containers running
if [ "$CONTAINER_COUNT" -eq 0 ]; then
  sketchybar --set $NAME \
    icon.color="$GREY" \
    label="0" \
    label.color="$GREY"
  exit 0
fi

# Get aggregate resource usage
# CPU: Sum all percentages
TOTAL_CPU=$(docker stats --no-stream --format "{{.CPUPerc}}" 2>/dev/null | \
  tr -d '%' | paste -sd+ 2>/dev/null | bc 2>/dev/null)
TOTAL_CPU=$(printf "%.0f" "${TOTAL_CPU:-0}" 2>/dev/null)
TOTAL_CPU=${TOTAL_CPU:-0}

# Memory: Sum all container memory usage
TOTAL_MEM=$(docker stats --no-stream --format "{{.MemUsage}}" 2>/dev/null | \
  cut -d'/' -f1 | awk '{
    val=$1
    gsub(/[^0-9.]/,"",val)
    if ($1 ~ /GiB/) val=val*1024
    if ($1 ~ /KiB/) val=val/1024
    sum+=val
  } END {
    if (sum>=1024) printf "%.1fG", sum/1024
    else printf "%.0fM", sum
  }')
TOTAL_MEM=${TOTAL_MEM:-0M}

# Determine color based on container count AND resource usage
if [ "$TOTAL_CPU" -gt 80 ]; then
  COLOR="$RED"      # Critical - high CPU
elif [ "$CONTAINER_COUNT" -gt 5 ] || [ "$TOTAL_CPU" -gt 50 ]; then
  COLOR="$ORANGE"   # High load
elif [ "$CONTAINER_COUNT" -gt 2 ] || [ "$TOTAL_CPU" -gt 25 ]; then
  COLOR="$LIME"     # Medium load
else
  COLOR="$GREEN"    # Low load
fi

# Update sketchybar with formatted label: "3 12%/1.2G"
sketchybar --set $NAME \
  icon.color="$COLOR" \
  label="${CONTAINER_COUNT} ${TOTAL_CPU}%/${TOTAL_MEM}" \
  label.color="$COLOR"
