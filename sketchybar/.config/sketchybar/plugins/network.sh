#!/bin/bash

# Get network interface (prefer WiFi, fallback to first active interface)
INTERFACE=$(route get default | grep interface | awk '{print $2}' | head -n1)

if [ -z "$INTERFACE" ]; then
  sketchybar --set $NAME label="No Connection" icon.color=0xffed8796
  exit
fi

# File to store previous values
CACHE_FILE="/tmp/sketchybar_network_$INTERFACE"

# Get current network stats
CURRENT_STATS=$(netstat -ib | grep "^$INTERFACE" | head -n1)
CURRENT_RX=$(echo $CURRENT_STATS | awk '{print $7}')
CURRENT_TX=$(echo $CURRENT_STATS | awk '{print $10}')
CURRENT_TIME=$(date +%s)

# Read previous values
if [ -f "$CACHE_FILE" ]; then
  PREV_DATA=$(cat "$CACHE_FILE")
  PREV_RX=$(echo $PREV_DATA | awk '{print $1}')
  PREV_TX=$(echo $PREV_DATA | awk '{print $2}')
  PREV_TIME=$(echo $PREV_DATA | awk '{print $3}')
  
  # Calculate time difference
  TIME_DIFF=$((CURRENT_TIME - PREV_TIME))
  
  if [ "$TIME_DIFF" -gt 0 ]; then
    # Calculate speeds (bytes per second)
    RX_SPEED=$(((CURRENT_RX - PREV_RX) / TIME_DIFF))
    TX_SPEED=$(((CURRENT_TX - PREV_TX) / TIME_DIFF))
    
    # Convert to human readable format (compact)
    format_speed() {
      local speed=$1
      if [ "$speed" -gt 1048576 ]; then
        echo "$(($speed / 1048576))M"
      elif [ "$speed" -gt 1024 ]; then
        echo "$(($speed / 1024))K"
      else
        echo "0"
      fi
    }
    
    RX_FORMATTED=$(format_speed $RX_SPEED)
    TX_FORMATTED=$(format_speed $TX_SPEED)
    
    # Set icon based on activity and show only significant speeds
    if [ "$TX_SPEED" -gt "$RX_SPEED" ] && [ "$TX_SPEED" -gt 10240 ]; then
      sketchybar --set $NAME label="↑${TX_FORMATTED}" icon="󰕒"
    elif [ "$RX_SPEED" -gt 10240 ]; then
      sketchybar --set $NAME label="↓${RX_FORMATTED}" icon="󰇚"
    else
      sketchybar --set $NAME label="—" icon="󰕒"
    fi
  else
    sketchybar --set $NAME label="Calculating..." 
  fi
else
  sketchybar --set $NAME label="Initializing..."
fi

# Store current values for next iteration
echo "$CURRENT_RX $CURRENT_TX $CURRENT_TIME" > "$CACHE_FILE"