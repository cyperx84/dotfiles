#!/bin/bash

# Popup click script
POPUP_CLICK_SCRIPT="sketchybar --set memory popup.drawing=toggle"

# Single memory item (icon + compact label showing GB and %)
memory=(
  icon=$MEMORY
  icon.font="MonaspiceKr Nerd Font:Bold:20.0"
  icon.color=$MAGENTA
  label.font="MonaspiceRn Nerd Font:Heavy:10"
  label.color=$WHITE
  padding_left=2
  padding_right=2
  background.drawing=off
  update_freq=10
  script="$PLUGIN_DIR/memory.sh"
  click_script="$POPUP_CLICK_SCRIPT"
  popup.horizontal=off
  popup.align=right
  popup.height=200
)

# Popup title
memory_title=(
  icon.drawing=off
  label="Memory Breakdown"
  label.font="MonaspiceKr Nerd Font:Heavy:14.0"
  label.color=$WHITE
  padding_left=8
  padding_right=8
  y_offset=10
  background.drawing=off
)

# Popup item for Active memory
memory_active=(
  icon="Active:"
  icon.font="MonaspiceKr Nerd Font:Medium:11.0"
  icon.color=$BLUE
  icon.width=90
  label.font="MonaspiceKr Nerd Font:Medium:11.0"
  label.color=$WHITE
  padding_left=8
  padding_right=8
  y_offset=-10
  background.drawing=off
  script="$PLUGIN_DIR/memory.sh"
  slider.background.height=6
  slider.background.corner_radius=3
  slider.background.color=0x30ffffff
  slider.highlight_color=$BLUE
  slider.width=120
)

# Popup item for Wired memory
memory_wired=(
  icon="Wired:"
  icon.font="MonaspiceKr Nerd Font:Medium:11.0"
  icon.color=$MAGENTA
  icon.width=90
  label.font="MonaspiceKr Nerd Font:Medium:11.0"
  label.color=$WHITE
  padding_left=8
  padding_right=8
  y_offset=-35
  background.drawing=off
  script="$PLUGIN_DIR/memory.sh"
  slider.background.height=6
  slider.background.corner_radius=3
  slider.background.color=0x30ffffff
  slider.highlight_color=$MAGENTA
  slider.width=120
)

# Popup item for Compressed memory
memory_compressed=(
  icon="Compressed:"
  icon.font="MonaspiceKr Nerd Font:Medium:11.0"
  icon.color=$YELLOW
  icon.width=90
  label.font="MonaspiceKr Nerd Font:Medium:11.0"
  label.color=$WHITE
  padding_left=8
  padding_right=8
  y_offset=-60
  background.drawing=off
  script="$PLUGIN_DIR/memory.sh"
  slider.background.height=6
  slider.background.corner_radius=3
  slider.background.color=0x30ffffff
  slider.highlight_color=$YELLOW
  slider.width=120
)

# Popup item for Free memory
memory_free=(
  icon="Free:"
  icon.font="MonaspiceKr Nerd Font:Medium:11.0"
  icon.color=$GREEN
  icon.width=90
  label.font="MonaspiceKr Nerd Font:Medium:11.0"
  label.color=$WHITE
  padding_left=8
  padding_right=8
  y_offset=-85
  background.drawing=off
  script="$PLUGIN_DIR/memory.sh"
  slider.background.height=6
  slider.background.corner_radius=3
  slider.background.color=0x30ffffff
  slider.highlight_color=$GREEN
  slider.width=120
)

# Popup item for Memory Pressure
memory_pressure=(
  icon="Pressure:"
  icon.font="MonaspiceKr Nerd Font:Medium:11.0"
  icon.color=$ORANGE
  icon.width=90
  label.font="MonaspiceKr Nerd Font:Medium:11.0"
  label.color=$WHITE
  padding_left=8
  padding_right=8
  y_offset=-110
  background.drawing=off
  script="$PLUGIN_DIR/memory.sh"
)

# Create single compact memory item with popup
sketchybar --add item memory right \
           --set memory "${memory[@]}" \
           --subscribe memory mouse.clicked \
           \
           --add item memory.title popup.memory \
           --set memory.title "${memory_title[@]}" \
           \
           --add slider memory.active popup.memory \
           --set memory.active "${memory_active[@]}" \
           \
           --add slider memory.wired popup.memory \
           --set memory.wired "${memory_wired[@]}" \
           \
           --add slider memory.compressed popup.memory \
           --set memory.compressed "${memory_compressed[@]}" \
           \
           --add slider memory.free popup.memory \
           --set memory.free "${memory_free[@]}" \
           \
           --add item memory.pressure popup.memory \
           --set memory.pressure "${memory_pressure[@]}"
