#!/bin/bash

# Get CPU usage using top command with 1 sample for faster execution
# Single sample is sufficient for periodic monitoring
CPU_INFO=$(top -l 1 -n 0 | grep "CPU usage:")
CPU_USER=$(echo "$CPU_INFO" | awk '{print $3}' | sed 's/%//')
CPU_SYS=$(echo "$CPU_INFO" | awk '{print $5}' | sed 's/%//')

# Handle decimal values properly for Apple Silicon
# Use printf for proper decimal math
CPU_TOTAL=$(printf "%.0f" $(echo "$CPU_USER + $CPU_SYS" | awk '{print $1 + $2}'))

# Get top process using most CPU (optimized with single awk)
TOP_PROCESS=$(ps -Aceo pcpu,comm | awk 'NR==2 {print substr($2,1,12)}')

# Update CPU percentage display
sketchybar --set cpu.percent label="${CPU_TOTAL}%"

# Normalize values to 0.0-1.0 range for graph using awk for decimal math
CPU_USER_NORMALIZED=$(echo "$CPU_USER" | awk '{printf "%.2f", $1/100}')
CPU_SYS_NORMALIZED=$(echo "$CPU_SYS" | awk '{printf "%.2f", $1/100}')

# Push normalized data to graphs
sketchybar --push cpu.user "$CPU_USER_NORMALIZED"
sketchybar --push cpu.sys "$CPU_SYS_NORMALIZED"

# Update top process display
sketchybar --set cpu.top label="$TOP_PROCESS"
