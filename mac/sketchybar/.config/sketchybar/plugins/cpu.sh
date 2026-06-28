#!/bin/bash

# Smoothing factor (0.0-1.0): lower = smoother, higher = more responsive
# 0.05 = very smooth (95% previous + 5% new), 0.15 = moderate, 0.3 = responsive
ALPHA=0.06
CACHE_FILE="/tmp/sketchybar_cpu_cache"

# Get CPU usage using top command
CPU_INFO=$(top -l 1 -n 0 | grep "CPU usage:")
CPU_USER=$(echo "$CPU_INFO" | awk '{print $3}' | sed 's/%//')
CPU_SYS=$(echo "$CPU_INFO" | awk '{print $5}' | sed 's/%//')

# Load previous smoothed values (or use current as initial)
if [[ -f "$CACHE_FILE" ]]; then
  source "$CACHE_FILE"
else
  SMOOTH_USER=$CPU_USER
  SMOOTH_SYS=$CPU_SYS
fi

# Apply exponential moving average: new = alpha * current + (1-alpha) * previous
SMOOTH_USER=$(awk -v a="$ALPHA" -v cur="$CPU_USER" -v prev="${SMOOTH_USER:-$CPU_USER}" \
  'BEGIN {printf "%.2f", a * cur + (1-a) * prev}')
SMOOTH_SYS=$(awk -v a="$ALPHA" -v cur="$CPU_SYS" -v prev="${SMOOTH_SYS:-$CPU_SYS}" \
  'BEGIN {printf "%.2f", a * cur + (1-a) * prev}')

# Save smoothed values for next iteration
echo "SMOOTH_USER=$SMOOTH_USER" > "$CACHE_FILE"
echo "SMOOTH_SYS=$SMOOTH_SYS" >> "$CACHE_FILE"

# Calculate total from smoothed values
CPU_TOTAL=$(awk -v u="$SMOOTH_USER" -v s="$SMOOTH_SYS" 'BEGIN {printf "%.0f", u + s}')

# Get top process
TOP_PROCESS=$(ps -Aceo pcpu,comm | awk 'NR==2 {print substr($2,1,12)}')

# Normalize to 0.0-1.0 for graphs
USER_NORM=$(awk -v v="$SMOOTH_USER" 'BEGIN {printf "%.2f", v/100}')
SYS_NORM=$(awk -v v="$SMOOTH_SYS" 'BEGIN {printf "%.2f", v/100}')

# Update SketchyBar
sketchybar --set cpu.percent label="${CPU_TOTAL}%" \
           --set cpu.top label="$TOP_PROCESS" \
           --push cpu.user "$USER_NORM" \
           --push cpu.sys "$SYS_NORM"
