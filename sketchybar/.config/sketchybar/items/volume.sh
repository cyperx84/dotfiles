#!/bin/bash
volume_slider=(
  script="$PLUGIN_DIR/volume.sh"
  updates=on
  label.drawing=off
  icon.drawing=off
  padding_right=3
  slider.highlight_color=$GREEN
  slider.background.height=5
  slider.background.corner_radius=3
  slider.background.color=$BACKGROUND_2
  slider.knob=$SLIDER_KNOB
  slider.knob.drawing=on
  slider.knob.font="$ICON_FONT"
)

volume_icon=(
  click_script="$PLUGIN_DIR/volume_click.sh"
  padding_left=8
  padding_right=4
  icon=$VOLUME_100
  icon.font="$ICON_FONT"
  icon.color=$GREEN
  label.drawing=off
  popup.align=right
)

status_bracket=(
  background.color=$BACKGROUND_1
  background.border_color=$BACKGROUND_2
  padding_left=3
  padding_right=3
)

volume_template=(
  drawing=off
  background.corner_radius=12
  padding_left=7
  padding_right=7
  icon.background.height=2
  icon.background.y_offset=-12
)

sketchybar --add slider volume right \
  --set volume "${volume_slider[@]}" \
  --subscribe volume volume_change \
  mouse.clicked \
  \
  --add item volume_icon right \
  --set volume_icon "${volume_icon[@]}" \
  --subscribe volume_icon mouse.entered \
  mouse.exited \
  mouse.exited.global \
  \
  --add item volume.template popup.volume_icon \
  --set volume.template "${volume_template[@]}"

sketchybar --add bracket status brew github.bell wifi volume_icon \
  --set status "${status_bracket[@]}"
