#!/bin/bash

# btop/bpytop-style memory monitoring with detailed breakdown
source "$CONFIG_DIR/colors.sh"

# Get comprehensive memory stats (btop-style)
get_memory_stats() {
  local vm_stat_output=$(vm_stat)
  
  # Extract page size dynamically (M1 Macs use 16384 bytes, Intel uses 4096)
  local page_size=$(echo "$vm_stat_output" | head -1 | grep -o '[0-9]\+' | head -1)
  [[ "$page_size" =~ ^[0-9]+$ ]] || page_size=4096
  
  # Extract page counts (remove trailing periods)
  local pages_free=$(echo "$vm_stat_output" | awk '/Pages free/ {print $3}' | tr -d '.')
  local pages_active=$(echo "$vm_stat_output" | awk '/Pages active/ {print $3}' | tr -d '.')
  local pages_inactive=$(echo "$vm_stat_output" | awk '/Pages inactive/ {print $3}' | tr -d '.')
  local pages_speculative=$(echo "$vm_stat_output" | awk '/Pages speculative/ {print $3}' | tr -d '.')
  local pages_wired=$(echo "$vm_stat_output" | awk '/Pages wired down/ {print $4}' | tr -d '.')
  local pages_compressed=$(echo "$vm_stat_output" | awk '/Pages occupied by compressor/ {print $5}' | tr -d '.')
  local pages_purgeable=$(echo "$vm_stat_output" | awk '/Pages purgeable/ {print $3}' | tr -d '.')
  
  # Validate numeric values
  [[ "$pages_free" =~ ^[0-9]+$ ]] || pages_free=0
  [[ "$pages_active" =~ ^[0-9]+$ ]] || pages_active=0
  [[ "$pages_inactive" =~ ^[0-9]+$ ]] || pages_inactive=0
  [[ "$pages_speculative" =~ ^[0-9]+$ ]] || pages_speculative=0
  [[ "$pages_wired" =~ ^[0-9]+$ ]] || pages_wired=0
  [[ "$pages_compressed" =~ ^[0-9]+$ ]] || pages_compressed=0
  [[ "$pages_purgeable" =~ ^[0-9]+$ ]] || pages_purgeable=0
  
  # Get total system memory and memory pressure
  local total_memory_bytes=$(sysctl -n hw.memsize 2>/dev/null)
  local memory_pressure=$(memory_pressure 2>/dev/null | grep "System-wide memory free percentage" | awk '{print $5}' | tr -d '%')
  [[ "$memory_pressure" =~ ^[0-9]+$ ]] || memory_pressure=50
  
  # Calculate memory usage matching Activity Monitor (App Memory + Compressed)
  # App Memory = Active + Wired (not including inactive/speculative as they can be freed)
  # Memory Used = App Memory + Compressed
  local app_memory_pages=$((pages_active + pages_wired))
  local app_memory_bytes=$((app_memory_pages * page_size))
  local compressed_bytes=$((pages_compressed * page_size))
  local used_bytes=$((app_memory_bytes + compressed_bytes))

  local total_gb=$(echo "scale=0; $total_memory_bytes / 1024 / 1024 / 1024" | bc -l)
  local used_gb=$(echo "scale=1; $used_bytes / 1024 / 1024 / 1024" | bc -l)
  # Use scale=1 for more precision, then round to nearest integer
  local memory_percent=$(echo "scale=1; ($used_bytes * 100) / $total_memory_bytes" | bc -l)
  memory_percent=$(printf "%.0f" "$memory_percent")
  
  # Calculate individual memory type percentages for detailed view
  local active_gb=$(echo "scale=1; ($pages_active * $page_size) / 1024 / 1024 / 1024" | bc -l)
  local wired_gb=$(echo "scale=1; ($pages_wired * $page_size) / 1024 / 1024 / 1024" | bc -l)
  local compressed_gb=$(echo "scale=1; ($pages_compressed * $page_size) / 1024 / 1024 / 1024" | bc -l)
  local inactive_gb=$(echo "scale=1; ($pages_inactive * $page_size) / 1024 / 1024 / 1024" | bc -l)
  
  # Output format: percent|used_gb|total_gb|memory_pressure|active_gb|wired_gb|compressed_gb|inactive_gb
  echo "${memory_percent}|${used_gb}|${total_gb}|${memory_pressure}|${active_gb}|${wired_gb}|${compressed_gb}|${inactive_gb}"
}

# Get comprehensive memory stats
MEMORY_STATS=$(get_memory_stats)

# Parse the stats (format: percent|used_gb|total_gb|memory_pressure|active_gb|wired_gb|compressed_gb|inactive_gb)
IFS='|' read -r MEMORY_PERCENT USED_GB TOTAL_GB MEMORY_PRESSURE ACTIVE_GB WIRED_GB COMPRESSED_GB INACTIVE_GB <<< "$MEMORY_STATS"

# Fallback values if parsing failed
[[ "$MEMORY_PERCENT" =~ ^[0-9]+$ ]] || MEMORY_PERCENT=0
[[ "$USED_GB" =~ ^[0-9.]+$ ]] || USED_GB=0.0
[[ "$TOTAL_GB" =~ ^[0-9.]+$ ]] || TOTAL_GB=16.0
[[ "$MEMORY_PRESSURE" =~ ^[0-9]+$ ]] || MEMORY_PRESSURE=50

# Advanced color coding based on memory pressure and usage (btop-style)
if [ "$MEMORY_PERCENT" -gt 90 ] || [ "$MEMORY_PRESSURE" -lt 10 ]; then
  COLOR=$RED
  ICON_COLOR=$RED
elif [ "$MEMORY_PERCENT" -gt 80 ] || [ "$MEMORY_PRESSURE" -lt 20 ]; then
  COLOR=$ORANGE
  ICON_COLOR=$ORANGE
elif [ "$MEMORY_PERCENT" -gt 70 ] || [ "$MEMORY_PRESSURE" -lt 30 ]; then
  COLOR=$YELLOW
  ICON_COLOR=$YELLOW
elif [ "$MEMORY_PERCENT" -gt 50 ]; then
  COLOR=$BLUE
  ICON_COLOR=$BLUE
else
  COLOR=$GREEN
  ICON_COLOR=$GREEN
fi

# Create compact single-line format: "11G 34%"
USED_GB_INT=$(printf "%.0f" "$USED_GB")
DISPLAY_TEXT="${USED_GB_INT}G ${MEMORY_PERCENT}%"

# Add memory pressure indicator if critical
if [ "$MEMORY_PRESSURE" -lt 15 ]; then
  DISPLAY_TEXT="⚠️${DISPLAY_TEXT}"
fi

# Update memory item
sketchybar --set $NAME label="$DISPLAY_TEXT" \
                    label.color=$COLOR \
                    icon.color=$ICON_COLOR

# Update popup items if they exist (for detailed breakdown)
if [ "$NAME" = "memory" ] || [ "$SENDER" = "routine" ]; then
  # Calculate free memory
  FREE_GB=$(echo "$TOTAL_GB - $USED_GB" | bc -l)
  FREE_GB=$(printf "%.1f" "$FREE_GB")

  # Calculate percentages for slider bars (0-100 range)
  ACTIVE_PERCENT=$(echo "scale=0; ($ACTIVE_GB * 100) / $TOTAL_GB" | bc -l 2>/dev/null)
  WIRED_PERCENT=$(echo "scale=0; ($WIRED_GB * 100) / $TOTAL_GB" | bc -l 2>/dev/null)
  COMPRESSED_PERCENT=$(echo "scale=0; ($COMPRESSED_GB * 100) / $TOTAL_GB" | bc -l 2>/dev/null)
  FREE_PERCENT=$(echo "scale=0; ($FREE_GB * 100) / $TOTAL_GB" | bc -l 2>/dev/null)

  # Fallback to 0 if calculation fails
  [[ "$ACTIVE_PERCENT" =~ ^[0-9]+$ ]] || ACTIVE_PERCENT=0
  [[ "$WIRED_PERCENT" =~ ^[0-9]+$ ]] || WIRED_PERCENT=0
  [[ "$COMPRESSED_PERCENT" =~ ^[0-9]+$ ]] || COMPRESSED_PERCENT=0
  [[ "$FREE_PERCENT" =~ ^[0-9]+$ ]] || FREE_PERCENT=0

  # Update popup items
  sketchybar --set memory.active label="${ACTIVE_GB}GB" \
                                 slider.percentage=$ACTIVE_PERCENT \
             --set memory.wired label="${WIRED_GB}GB" \
                                slider.percentage=$WIRED_PERCENT \
             --set memory.compressed label="${COMPRESSED_GB}GB" \
                                     slider.percentage=$COMPRESSED_PERCENT \
             --set memory.free label="${FREE_GB}GB" \
                               slider.percentage=$FREE_PERCENT \
             --set memory.pressure label="${MEMORY_PRESSURE}%"
fi