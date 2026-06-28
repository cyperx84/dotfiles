#!/bin/bash

# System Monitor Details Plugin
# Shows detailed system information when the system monitor bracket is clicked

source "$CONFIG_DIR/colors.sh"
source "$CONFIG_DIR/icons.sh"

# Get detailed system information
get_system_details() {
  # CPU Information
  local cpu_usage=$(top -l 1 | grep "CPU usage" | awk '{print $3}' | sed 's/%//')
  local cpu_model=$(sysctl -n machdep.cpu.brand_string)
  local cpu_cores=$(sysctl -n hw.physicalcpu)
  local cpu_threads=$(sysctl -n hw.logicalcpu)
  
  # Memory Information
  local memory_info=$(vm_stat | head -n 18)
  local memory_total=$(echo "$memory_info" | grep "Pages free" | awk '{print $3}' | sed 's/\.//')
  local memory_wired=$(echo "$memory_info" | grep "Pages wired down" | awk '{print $4}' | sed 's/\.//')
  local memory_active=$(echo "$memory_info" | grep "Pages active" | awk '{print $3}' | sed 's/\.//')
  local memory_inactive=$(echo "$memory_info" | grep "Pages inactive" | awk '{print $3}' | sed 's/\.//')
  local memory_compressed=$(echo "$memory_info" | grep "Pages stored in compressor" | awk '{print $5}' | sed 's/\.//')
  
  # Calculate memory usage in GB
  local page_size=4096
  local total_ram=$(sysctl -n hw.memsize)
  local total_gb=$((total_ram / 1024 / 1024 / 1024))
  local used_pages=$((memory_wired + memory_active + memory_inactive + memory_compressed))
  local used_gb=$(((used_pages * page_size) / 1024 / 1024 / 1024))
  local free_gb=$((total_gb - used_gb))
  
  # Disk Information
  local disk_info=$(df -h / | tail -1)
  local disk_total=$(echo "$disk_info" | awk '{print $2}')
  local disk_used=$(echo "$disk_info" | awk '{print $3}')
  local disk_available=$(echo "$disk_info" | awk '{print $4}')
  local disk_percent=$(echo "$disk_info" | awk '{print $5}')
  
  # Temperature Information
  local temp=""
  if command -v osx-cpu-temp &> /dev/null; then
    temp=$(osx-cpu-temp)
  else
    temp="N/A"
  fi
  
  # Network Information
  local interface=$(route get default | grep interface | awk '{print $2}' | head -n1)
  local ip=$(ipconfig getifaddr "$interface" 2>/dev/null || echo "N/A")
  local ssid=""
  if [[ "$interface" == en* ]]; then
    ssid=$(/System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -I | awk -F ' SSID: ' '/ SSID: / {print $2}')
  fi
  
  # Create detailed popup content
  echo "CPU: $cpu_model"
  echo "Cores: $cpu_cores physical, $cpu_threads logical"
  echo "Usage: ${cpu_usage:-N/A}%"
  echo ""
  echo "Memory: ${used_gb}GB used / ${total_gb}GB total"
  echo "Available: ${free_gb}GB free"
  echo ""
  echo "Disk: $disk_used used / $disk_total total"
  echo "Available: $disk_available ($disk_percent used)"
  echo ""
  echo "Temperature: $temp"
  echo ""
  if [ -n "$ssid" ]; then
    echo "Network: $ssid ($ip)"
  else
    echo "Network: $interface ($ip)"
  fi
}

# Main execution
case "$SENDER" in
"mouse.clicked")
  # Toggle detailed system information display
  # For now, just trigger a notification with system details
  system_details=$(get_system_details)
  
  # Use osascript to show a detailed notification
  osascript -e "display notification \"$system_details\" with title \"System Monitor Details\" sound name \"Glass\""
  ;;
*)
  # Default case - do nothing
  ;;
esac