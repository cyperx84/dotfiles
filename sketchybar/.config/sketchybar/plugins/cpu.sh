#!/bin/bash

# Get CPU usage using top command (more reliable for instantaneous values)
CPU_INFO=$(top -l 1 | grep "CPU usage:")
CPU_USER=$(echo "$CPU_INFO" | awk '{print $3}' | sed 's/%//')
CPU_SYS=$(echo "$CPU_INFO" | awk '{print $5}' | sed 's/%//')
CPU_IDLE=$(echo "$CPU_INFO" | awk '{print $7}' | sed 's/%//')

# Calculate total CPU usage
CPU_TOTAL=$(echo "scale=1; $CPU_USER + $CPU_SYS" | bc)

# Get top process using most CPU
TOP_PROCESS=$(ps -Aceo pcpu,comm | sort -k1 -nr | head -2 | tail -1 | awk '{print $2}' | cut -c1-12)

# Update CPU percentage display
sketchybar --set cpu.percent label="${CPU_TOTAL}%"

# Convert to integers for graphs (round to nearest integer)
CPU_USER_INT=$(printf "%.0f" "$CPU_USER")
CPU_SYS_INT=$(printf "%.0f" "$CPU_SYS")

# Push data to graphs
sketchybar --push cpu.user "$CPU_USER_INT"
sketchybar --push cpu.sys "$CPU_SYS_INT"

# Update top process display
sketchybar --set cpu.top label="$TOP_PROCESS"