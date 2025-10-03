#!/bin/bash

# Get CPU usage using top command with 2 samples for accurate current usage
# The first sample from 'top -l 1' shows average since boot, not current usage
# We need the second sample for real-time accuracy (matching btop/htop)
CPU_INFO=$(top -l 2 -n 0 | grep "CPU usage:" | tail -1)
CPU_USER=$(echo "$CPU_INFO" | awk '{print $3}' | sed 's/%//')
CPU_SYS=$(echo "$CPU_INFO" | awk '{print $5}' | sed 's/%//')
CPU_IDLE=$(echo "$CPU_INFO" | awk '{print $7}' | sed 's/%//')

# Calculate total CPU usage
CPU_TOTAL=$(echo "scale=1; $CPU_USER + $CPU_SYS" | bc)

# Get top process using most CPU
TOP_PROCESS=$(ps -Aceo pcpu,comm | sort -k1 -nr | head -2 | tail -1 | awk '{print $2}' | cut -c1-12)

# Update CPU percentage display
sketchybar --set cpu.percent label="${CPU_TOTAL}%"

# Normalize values to 0.0-1.0 range for graph (SketchyBar requirement)
# Graph data points must be between 0 and 1
CPU_USER_NORMALIZED=$(echo "scale=2; $CPU_USER / 100" | bc)
CPU_SYS_NORMALIZED=$(echo "scale=2; $CPU_SYS / 100" | bc)

# Push normalized data to graphs
sketchybar --push cpu.user "$CPU_USER_NORMALIZED"
sketchybar --push cpu.sys "$CPU_SYS_NORMALIZED"

# Update top process display
sketchybar --set cpu.top label="$TOP_PROCESS"