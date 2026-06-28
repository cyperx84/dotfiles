#!/bin/bash

# RAM display - mirrors CPU structure exactly

source "$CONFIG_DIR/colors.sh"

ram_label=(
  label.font="MonaspiceRn Nerd Font:Heavy:10"
  label="RAM"
  label.color=$MAGENTA
  icon.drawing=off
  padding_right=2
  padding_left=0
  background.drawing=off
)

ram_percent=(
  label.font="MonaspiceRn Nerd Font:Heavy:10"
  label="0%"
  padding_right=4
  padding_left=0
  background.drawing=off
  icon.drawing=off
  update_freq=10
  script="$PLUGIN_DIR/memory_graph.sh"
)

ram_graph=(
  width=55
  graph.color=$MAGENTA
  graph.fill_color=0x50a48cf2
  graph.line_width=1.5
  background.height=20
  background.drawing=on
  background.color=0x20000000
  background.border_width=0
  background.corner_radius=3
  label.drawing=off
  icon.drawing=off
  padding_left=0
  padding_right=0
  y_offset=0
)

sketchybar --add item ram.label right             \
           --set ram.label "${ram_label[@]}"      \
                                                  \
           --add item ram.percent right           \
           --set ram.percent "${ram_percent[@]}"  \
                                                  \
           --add graph ram.graph right 100        \
           --set ram.graph "${ram_graph[@]}"
