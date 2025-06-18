#!/bin/bash

# Improved memory monitoring with better reliability
source "$CONFIG_DIR/colors.sh"

# Get memory stats using vm_stat (M1 Mac compatible)
get_memory_usage() {
  local vm_stat_output=$(vm_stat)
  
  # Extract page size dynamically (M1 Macs use 16384 bytes, Intel uses 4096)
  local page_size=$(echo "$vm_stat_output" | head -1 | grep -o '[0-9]\+' | head -1)
  [[ "$page_size" =~ ^[0-9]+$ ]] || page_size=4096  # Fallback to Intel default
  
  # Extract page counts (remove trailing periods and convert to numbers)
  local pages_active=$(echo "$vm_stat_output" | awk '/Pages active/ {print $3}' | tr -d '.')
  local pages_inactive=$(echo "$vm_stat_output" | awk '/Pages inactive/ {print $3}' | tr -d '.')
  local pages_speculative=$(echo "$vm_stat_output" | awk '/Pages speculative/ {print $3}' | tr -d '.')
  local pages_wired=$(echo "$vm_stat_output" | awk '/Pages wired down/ {print $4}' | tr -d '.')
  local pages_compressed=$(echo "$vm_stat_output" | awk '/Pages occupied by compressor/ {print $5}' | tr -d '.')
  
  # Validate we got numeric values
  [[ "$pages_active" =~ ^[0-9]+$ ]] || pages_active=0
  [[ "$pages_inactive" =~ ^[0-9]+$ ]] || pages_inactive=0
  [[ "$pages_speculative" =~ ^[0-9]+$ ]] || pages_speculative=0
  [[ "$pages_wired" =~ ^[0-9]+$ ]] || pages_wired=0
  [[ "$pages_compressed" =~ ^[0-9]+$ ]] || pages_compressed=0
  
  # Calculate used memory percentage directly to avoid precision loss
  local used_pages=$((pages_active + pages_inactive + pages_speculative + pages_wired + pages_compressed))
  local total_memory_bytes=$(sysctl -n hw.memsize 2>/dev/null)
  
  # Calculate percentage: (used_pages * page_size * 100) / total_memory_bytes
  local memory_percent=$(echo "scale=0; ($used_pages * $page_size * 100) / $total_memory_bytes" | bc -l)
  
  echo "$memory_percent"
}

# Get memory usage with error handling
MEMORY_PERCENT=$(get_memory_usage)

# Fallback if calculation failed
if [ -z "$MEMORY_PERCENT" ] || ! [[ "$MEMORY_PERCENT" =~ ^[0-9]+$ ]]; then
  MEMORY_PERCENT=0
fi

# Set color based on usage with improved thresholds
if [ "$MEMORY_PERCENT" -gt 85 ]; then
  COLOR=$RED
elif [ "$MEMORY_PERCENT" -gt 70 ]; then
  COLOR=$ORANGE  
elif [ "$MEMORY_PERCENT" -gt 50 ]; then
  COLOR=$YELLOW
else
  COLOR=$GREEN
fi

# Update the display
sketchybar --set $NAME label="${MEMORY_PERCENT}%" \
                    label.color=$COLOR