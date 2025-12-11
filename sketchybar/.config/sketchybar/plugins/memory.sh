#!/bin/bash

# btop/bpytop-style memory monitoring with detailed breakdown
source "$CONFIG_DIR/colors.sh"

# Cache total memory (never changes) - global variable
TOTAL_MEMORY_BYTES="${TOTAL_MEMORY_BYTES:-$(sysctl -n hw.memsize 2>/dev/null)}"

# Get comprehensive memory stats (btop-style)
get_memory_stats() {
  local vm_stat_output=$(vm_stat)

  # Extract page size dynamically (M1 Macs use 16384 bytes, Intel uses 4096)
  local page_size=$(echo "$vm_stat_output" | head -1 | grep -o '[0-9]\+' | head -1)
  [[ "$page_size" =~ ^[0-9]+$ ]] || page_size=16384

  # Extract all page counts in single awk pass (remove trailing periods in awk)
  read pages_free pages_active pages_inactive pages_speculative pages_wired pages_compressed pages_purgeable < <(
    echo "$vm_stat_output" | awk '
      /Pages free:/ {free=$3}
      /Pages active:/ {active=$3}
      /Pages inactive:/ {inactive=$3}
      /Pages speculative:/ {spec=$3}
      /Pages wired down:/ {wired=$4}
      /Pages occupied by compressor:/ {comp=$5}
      /Pages purgeable:/ {purg=$3}
      END {
        gsub(/\./, "", free); gsub(/\./, "", active);
        gsub(/\./, "", inactive); gsub(/\./, "", spec);
        gsub(/\./, "", wired); gsub(/\./, "", comp);
        gsub(/\./, "", purg);
        print free, active, inactive, spec, wired, comp, purg
      }
    '
  )

  # Validate numeric values
  [[ "$pages_free" =~ ^[0-9]+$ ]] || pages_free=0
  [[ "$pages_active" =~ ^[0-9]+$ ]] || pages_active=0
  [[ "$pages_inactive" =~ ^[0-9]+$ ]] || pages_inactive=0
  [[ "$pages_speculative" =~ ^[0-9]+$ ]] || pages_speculative=0
  [[ "$pages_wired" =~ ^[0-9]+$ ]] || pages_wired=0
  [[ "$pages_compressed" =~ ^[0-9]+$ ]] || pages_compressed=0
  [[ "$pages_purgeable" =~ ^[0-9]+$ ]] || pages_purgeable=0

  # Get memory pressure
  local memory_pressure=$(memory_pressure 2>/dev/null | grep "System-wide memory free percentage" | awk '{print $5}' | tr -d '%')
  [[ "$memory_pressure" =~ ^[0-9]+$ ]] || memory_pressure=50

  # Calculate memory usage matching Activity Monitor (App Memory + Compressed)
  # App Memory = Active + Wired (not including inactive/speculative as they can be freed)
  # Memory Used = App Memory + Compressed
  local app_memory_pages=$((pages_active + pages_wired))
  local app_memory_bytes=$((app_memory_pages * page_size))
  local compressed_bytes=$((pages_compressed * page_size))
  local used_bytes=$((app_memory_bytes + compressed_bytes))

  # Use bash arithmetic for GB conversion (integer division)
  local total_gb=$(( TOTAL_MEMORY_BYTES / 1073741824 ))

  # For decimal precision, use printf with bash arithmetic
  local used_gb=$(printf "%.1f" $(( used_bytes * 10 / 1073741824 ))e-1)
  local memory_percent=$(( (used_bytes * 100) / TOTAL_MEMORY_BYTES ))

  # Calculate individual memory type GBs with printf
  local active_gb=$(printf "%.1f" $(( pages_active * page_size * 10 / 1073741824 ))e-1)
  local wired_gb=$(printf "%.1f" $(( pages_wired * page_size * 10 / 1073741824 ))e-1)
  local compressed_gb=$(printf "%.1f" $(( pages_compressed * page_size * 10 / 1073741824 ))e-1)
  local inactive_gb=$(printf "%.1f" $(( pages_inactive * page_size * 10 / 1073741824 ))e-1)

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

# Color coding: Green (low) → Purple (medium) → Orange (high) → Red (critical)
if [ "$MEMORY_PERCENT" -gt 80 ] || [ "$MEMORY_PRESSURE" -lt 15 ]; then
  COLOR=$RED
  ICON_COLOR=$RED
elif [ "$MEMORY_PERCENT" -gt 70 ] || [ "$MEMORY_PRESSURE" -lt 25 ]; then
  COLOR=$ORANGE
  ICON_COLOR=$ORANGE
elif [ "$MEMORY_PERCENT" -gt 50 ]; then
  COLOR=$MAGENTA
  ICON_COLOR=$MAGENTA
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
  # Calculate free memory with bash arithmetic
  FREE_GB=$(printf "%.1f" $(( (TOTAL_GB * 10 - ${USED_GB/./}) ))e-1)

  # Calculate percentages for slider bars using bash arithmetic
  ACTIVE_PERCENT=$(( ${ACTIVE_GB/./} * 10 / TOTAL_GB ))
  WIRED_PERCENT=$(( ${WIRED_GB/./} * 10 / TOTAL_GB ))
  COMPRESSED_PERCENT=$(( ${COMPRESSED_GB/./} * 10 / TOTAL_GB ))
  FREE_PERCENT=$(( ${FREE_GB/./} * 10 / TOTAL_GB ))

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
