#!/bin/bash

cpu_top=(
  label.font="MonaspiceRn Nerd Font:Semibold:8"
  label=CPU
  icon.drawing=off
  width=0
  padding_right=4
  padding_left=2
  background.drawing=off
  y_offset=6
)

cpu_percent=(
  label.font="MonaspiceRn Nerd Font:Heavy:10"
  label=CPU
  y_offset=-4
  padding_right=4
  padding_left=0
  width=55
  background.drawing=off
  icon.drawing=off
  update_freq=4
  script="$PLUGIN_DIR/cpu.sh"
  mach_helper="$HELPER"
)

cpu_sys=(
  width=55
  graph.color=$RED
  graph.fill_color=0x30ff001f
  graph.line_width=1.0
  background.height=20
  background.drawing=on
  background.color=0x20000000
  background.border_width=0
  background.corner_radius=3
  label.drawing=off
  icon.drawing=off
  padding_left=140
  padding_right=-58
  y_offset=0
)

cpu_user=(
  width=55
  graph.color=$BLUE
  graph.fill_color=0x30002aff
  graph.line_width=1.0
  background.height=20
  background.drawing=off
  background.color=$TRANSPARENT
  label.drawing=off
  icon.drawing=off
  padding_left=140
  padding_right=0
  y_offset=0
)

sketchybar --add item cpu.top right              \
           --set cpu.top "${cpu_top[@]}"         \
                                                 \
           --add item cpu.percent right          \
           --set cpu.percent "${cpu_percent[@]}" \
                                                 \
           --add graph cpu.user right 100         \
           --set cpu.user "${cpu_user[@]}"       \
                                                 \
           --add graph cpu.sys right 100          \
           --set cpu.sys "${cpu_sys[@]}"
