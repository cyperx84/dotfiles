#!/bin/bash

source "$HOME/.config/sketchybar/colors.sh"

# Get current output device
CURRENT_OUTPUT=$(SwitchAudioSource -t output -c 2>/dev/null)

# Shorten device name for display
case "$CURRENT_OUTPUT" in
  "Mac mini Speakers") LABEL="Spkr" ;;
  "LG ULTRAGEAR+") LABEL="Mon" ;;
  "Scarlett 2i2 USB") LABEL="Scrl" ;;
  "BlackHole 16ch") LABEL="BH" ;;
  "Multi-Output Device") LABEL="Multi" ;;
  "Mod") LABEL="Mod" ;;
  *) LABEL=$(echo "$CURRENT_OUTPUT" | cut -c1-6) ;;
esac

# Icon based on device type
case "$CURRENT_OUTPUT" in
  *Speakers*|*Mac*) ICON=""; COLOR=$GREEN ;;
  *ULTRAGEAR*|*Monitor*|*LG*) ICON=""; COLOR=$BLUE ;;
  *Scarlett*) ICON=""; COLOR=$ORANGE ;;
  *BlackHole*) ICON=""; COLOR=$MAGENTA ;;
  *Multi-Output*) ICON=""; COLOR=$YELLOW ;;
  *Mod*) ICON=""; COLOR=$GREEN ;;
  *) ICON=""; COLOR=$WHITE ;;
esac

sketchybar --set audio_output label="$LABEL" icon="$ICON" icon.color=$COLOR label.color=$COLOR
