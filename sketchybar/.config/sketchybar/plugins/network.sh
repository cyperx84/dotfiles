#!/bin/bash

# Get network interface (prefer WiFi, fallback to first active interface)
INTERFACE=$(route get default 2>/dev/null | grep interface | awk '{print $2}' | head -n1)

if [ -z "$INTERFACE" ]; then
  sketchybar --set $NAME label="No Connection" icon.color=0xffed8796
  exit
fi

# File to store previous values
CACHE_FILE="/tmp/sketchybar_network_$INTERFACE"

# Get current network stats and time
CURRENT_TIME=$(date +%s)

# Single awk extraction for both RX and TX (optimized)
read CURRENT_RX CURRENT_TX < <(
  netstat -ib 2>/dev/null | awk -v iface="$INTERFACE" '
    $1 == iface {print $7, $10; exit}
  '
)

# Validate we got values
[ -z "$CURRENT_RX" ] && CURRENT_RX=0
[ -z "$CURRENT_TX" ] && CURRENT_TX=0

# Read previous values
if [ -f "$CACHE_FILE" ]; then
  read PREV_RX PREV_TX PREV_TIME < "$CACHE_FILE"

  # Calculate time difference
  TIME_DIFF=$((CURRENT_TIME - PREV_TIME))

  if [ "$TIME_DIFF" -gt 0 ]; then
    # Calculate speeds (bytes per second) with bash arithmetic
    RX_SPEED=$(((CURRENT_RX - PREV_RX) / TIME_DIFF))
    TX_SPEED=$(((CURRENT_TX - PREV_TX) / TIME_DIFF))

    # Convert to human readable format (compact) using bash
    format_speed() {
      local speed=$1
      if [ "$speed" -gt 1048576 ]; then
        echo "$((speed / 1048576))M"
      elif [ "$speed" -gt 1024 ]; then
        echo "$((speed / 1024))K"
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

# Debounced cache write (only write if values changed by >1KB or time diff >30s)
CHANGE_AMOUNT=$(( (CURRENT_RX - ${PREV_RX:-0}) + (CURRENT_TX - ${PREV_TX:-0}) ))
TIME_SINCE_LAST=$(( CURRENT_TIME - ${PREV_TIME:-0} ))

if [ "$CHANGE_AMOUNT" -gt 1024 ] || [ "$TIME_SINCE_LAST" -gt 30 ]; then
  echo "$CURRENT_RX $CURRENT_TX $CURRENT_TIME" > "$CACHE_FILE"
fi
