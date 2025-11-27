#!/bin/bash

# WiFi Monitor - Background process to detect WiFi state changes
# Triggers SketchyBar wifi_change event when WiFi connects/disconnects or SSID changes

# Configuration
MONITOR_INTERVAL=1  # Check every 1 second (low overhead with scutil)
DEBOUNCE_TIME=2     # Wait 2 seconds before retriggering
CACHE_FILE="/tmp/sketchybar_wifi_state"
PID_FILE="/tmp/sketchybar_wifi_monitor.pid"

# Store PID for cleanup
echo $$ > "$PID_FILE"

# Function to get current WiFi state (SSID + interface + IP)
get_wifi_state() {
  INTERFACE=$(route get default 2>/dev/null | grep interface | awk '{print $2}' | head -n1)
  IP=$(ipconfig getifaddr "$INTERFACE" 2>/dev/null)
  SSID=$(networksetup -getairportnetwork "$INTERFACE" 2>/dev/null | cut -d' ' -f4-)
  echo "${INTERFACE}|${IP}|${SSID}"
}

# Initialize previous state
PREV_STATE=$(get_wifi_state)
echo "$PREV_STATE" > "$CACHE_FILE"

# Monitor loop using scutil watch on network state
while true; do
  # Use scutil to watch for network state changes (blocks until change)
  scutil -w State:/Network/Global/IPv4 -t $MONITOR_INTERVAL >/dev/null 2>&1

  # Get current state after change detected
  CURRENT_STATE=$(get_wifi_state)

  # Check if state actually changed (debounce)
  if [ "$CURRENT_STATE" != "$PREV_STATE" ]; then
    # Wait debounce period
    sleep $DEBOUNCE_TIME

    # Re-check state (in case of rapid fluctuations)
    CURRENT_STATE=$(get_wifi_state)

    if [ "$CURRENT_STATE" != "$PREV_STATE" ]; then
      # State changed, trigger SketchyBar event
      sketchybar --trigger wifi_change

      # Update stored state
      PREV_STATE="$CURRENT_STATE"
      echo "$CURRENT_STATE" > "$CACHE_FILE"
    fi
  fi
done
