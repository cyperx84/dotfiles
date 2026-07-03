#!/bin/bash

# AI agent status cluster: Claude Code, Codex, opencode, OpenClaw, Hermes
# Icons come from the vendored Devicons brand-icon font (real logos, monochrome
# so icon.color still tints them for state). sketchybarrc installs the font.
# Clicking an icon jumps to that tool's waiting session (round-robin); the
# Aerospace cmd-shift-enter keybind cycles waiting sessions across all tools.
AGENT_ICON_FONT="Devicons:Regular:18.0"

claude_status=(
  icon=$CLAUDE
  icon.font="$AGENT_ICON_FONT"
  icon.color=$GREY
  label.font="$LABEL_FONT"
  label.color=$WHITE
  padding_left=2
  padding_right=4
  update_freq=5
  updates=on
  script="$PLUGIN_DIR/claude_status.sh"
  click_script="$PLUGIN_DIR/agent_jump.sh claude"
)

codex_status=(
  icon=$CODEX
  icon.font="$AGENT_ICON_FONT"
  icon.color=$GREY
  label.font="$LABEL_FONT"
  label.color=$WHITE
  padding_left=2
  padding_right=4
  update_freq=5
  updates=on
  script="$PLUGIN_DIR/codex_status.sh"
  click_script="$PLUGIN_DIR/agent_jump.sh codex"
)

opencode_status=(
  icon=$OPENCODE
  icon.font="$AGENT_ICON_FONT"
  icon.color=$GREY
  label.font="$LABEL_FONT"
  label.color=$WHITE
  padding_left=2
  padding_right=4
  update_freq=5
  updates=on
  script="$PLUGIN_DIR/opencode_status.sh"
  click_script="$PLUGIN_DIR/agent_jump.sh opencode"
)

openclaw_status=(
  icon=$OPENCLAW
  icon.font="$AGENT_ICON_FONT"
  icon.color=$GREY
  label.font="$LABEL_FONT"
  label.color=$WHITE
  padding_left=2
  padding_right=4
  update_freq=5
  updates=on
  script="$PLUGIN_DIR/openclaw_status.sh"
  click_script="aerospace workspace 4"
)

hermes_status=(
  icon=$HERMES
  icon.font="$AGENT_ICON_FONT"
  icon.color=$GREY
  label.font="$LABEL_FONT"
  label.color=$WHITE
  padding_left=2
  padding_right=4
  update_freq=5
  updates=on
  script="$PLUGIN_DIR/hermes_status.sh"
  click_script="aerospace workspace 4"
)

sketchybar --add item claude_status left \
           --set claude_status "${claude_status[@]}" \
           --add item codex_status left \
           --set codex_status "${codex_status[@]}" \
           --add item opencode_status left \
           --set opencode_status "${opencode_status[@]}" \
           --add item openclaw_status left \
           --set openclaw_status "${openclaw_status[@]}" \
           --add item hermes_status left \
           --set hermes_status "${hermes_status[@]}"

agents_bracket=(
  background.color=$BACKGROUND_1
  background.border_color=$BACKGROUND_2
  padding_left=3
  padding_right=3
)

sketchybar --add bracket agents claude_status codex_status opencode_status openclaw_status hermes_status \
           --set agents "${agents_bracket[@]}"
