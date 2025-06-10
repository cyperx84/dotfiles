#!/bin/bash

# Get memory information
MEMORY_PRESSURE=$(memory_pressure | grep "System-wide memory free percentage" | awk '{print $5}' | tr -d '%')
MEMORY_USED_GB=$(vm_stat | awk '
/Pages active/ { active = $3 }
/Pages inactive/ { inactive = $3 }
/Pages speculative/ { speculative = $3 }
/Pages wired down/ { wired = $4 }
/Pages occupied by compressor/ { compressed = $5 }
END {
  page_size = 4096
  used_pages = active + inactive + speculative + wired + compressed
  used_gb = (used_pages * page_size) / (1024^3)
  printf "%.1f", used_gb
}')

# Get total memory
TOTAL_MEMORY_GB=$(sysctl -n hw.memsize | awk '{printf "%.0f", $1/(1024^3)}')

# Calculate usage percentage
MEMORY_PERCENT=$(echo "$MEMORY_USED_GB $TOTAL_MEMORY_GB" | awk '{printf "%.0f", ($1/$2)*100}')

# Set color based on usage
if [ "$MEMORY_PERCENT" -gt 80 ]; then
  COLOR="0xffed8796"  # Red
elif [ "$MEMORY_PERCENT" -gt 60 ]; then
  COLOR="0xfff5a97f"  # Orange
else
  COLOR="0xffa6da95"  # Green
fi

sketchybar --set $NAME label="${MEMORY_PERCENT}%" \
                    label.color=$COLOR