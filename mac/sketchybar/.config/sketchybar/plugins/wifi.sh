#!/bin/bash

update() {
  source "$CONFIG_DIR/icons.sh"
  WIFI_IFACE="$(networksetup -listallhardwareports | awk '/Wi-Fi/{getline; print $2}')"
  SSID="$(networksetup -getairportnetwork "$WIFI_IFACE" 2>/dev/null | awk -F': ' '{print $2}')"
  INTERFACE="$(route get default | grep interface | awk '{print $2}')"

  # Determine the hardware type (WiFi or Ethernet) of the active interface
  HARDWARE_TYPE="$(networksetup -listnetworkserviceorder | grep -B 1 "Device: $INTERFACE)" | head -n 1 | awk '{print $2}')"

  # Adjust IP and icon assignment based on the hardware type of the active interface
  IP="$(ipconfig getifaddr "$INTERFACE")"

  if [[ "$HARDWARE_TYPE" == "Wi-Fi" ]]; then
    ICON="$([ -n "$IP" ] && echo "$WIFI_CONNECTED" || echo "$WIFI_DISCONNECTED")"
  else
    ICON="$([ -n "$IP" ] && echo "$ETHERNET_CONNECTED" || echo "$WIFI_DISCONNECTED")"
  fi

  LABEL="$([ -n "$IP" ] && echo "$SSID ($IP)" || echo "Disconnected")"

  sketchybar --set $NAME icon="$ICON" label="$LABEL"
}

click() {
  CURRENT_WIDTH="$(sketchybar --query $NAME | jq -r .label.width)"

  WIDTH=0
  if [ "$CURRENT_WIDTH" -eq "0" ]; then
    WIDTH=dynamic
  fi

  sketchybar --animate sin 20 --set $NAME label.width="$WIDTH"
}

case "$SENDER" in
"wifi_change")
  update
  ;;
"mouse.clicked")
  click
  ;;
esac
