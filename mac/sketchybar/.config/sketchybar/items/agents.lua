-- Ported from items/agents.sh
-- AI agent status cluster: Claude Code, Codex, opencode, OpenClaw, Hermes.
-- Poll-only (update_freq=5, updates=on); each item keeps its shell plugin.
-- Icons come from the vendored Devicons brand-icon font (monochrome logos so
-- icon.color still tints them for state). Clicking jumps to that tool's waiting
-- session via agent_jump.sh (round-robin); openclaw/hermes go to workspace 4.
local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

-- Devicons brand-icon font (sketchybarrc installs it). Keep verbatim.
local AGENT_ICON_FONT = "Devicons:Regular:18.0"

sbar.add("item", "claude_status", {
  position = "left",
  icon = {
    string = icons.claude,
    font = AGENT_ICON_FONT,
    color = colors.grey,
  },
  label = {
    font = settings.label_font,
    color = colors.white,
  },
  padding_left = 2,
  padding_right = 4,
  update_freq = 5,
  updates = "on",
  script = settings.plugin_dir .. "/claude_status.sh",
  click_script = settings.plugin_dir .. "/agent_jump.sh claude",
})

sbar.add("item", "codex_status", {
  position = "left",
  icon = {
    string = icons.codex,
    font = AGENT_ICON_FONT,
    color = colors.grey,
  },
  label = {
    font = settings.label_font,
    color = colors.white,
  },
  padding_left = 2,
  padding_right = 4,
  update_freq = 5,
  updates = "on",
  script = settings.plugin_dir .. "/codex_status.sh",
  click_script = settings.plugin_dir .. "/agent_jump.sh codex",
})

sbar.add("item", "opencode_status", {
  position = "left",
  icon = {
    string = icons.opencode,
    font = AGENT_ICON_FONT,
    color = colors.grey,
  },
  label = {
    font = settings.label_font,
    color = colors.white,
  },
  padding_left = 2,
  padding_right = 4,
  update_freq = 5,
  updates = "on",
  script = settings.plugin_dir .. "/opencode_status.sh",
  click_script = settings.plugin_dir .. "/agent_jump.sh opencode",
})

sbar.add("item", "openclaw_status", {
  position = "left",
  icon = {
    string = icons.openclaw,
    font = AGENT_ICON_FONT,
    color = colors.grey,
  },
  label = {
    font = settings.label_font,
    color = colors.white,
  },
  padding_left = 2,
  padding_right = 4,
  update_freq = 5,
  updates = "on",
  script = settings.plugin_dir .. "/openclaw_status.sh",
  click_script = "aerospace workspace 4",
})

sbar.add("item", "hermes_status", {
  position = "left",
  icon = {
    string = icons.hermes,
    font = AGENT_ICON_FONT,
    color = colors.grey,
  },
  label = {
    font = settings.label_font,
    color = colors.white,
  },
  padding_left = 2,
  padding_right = 4,
  update_freq = 5,
  updates = "on",
  script = settings.plugin_dir .. "/hermes_status.sh",
  click_script = "aerospace workspace 4",
})

sbar.add("bracket", "agents", {
  "claude_status",
  "codex_status",
  "opencode_status",
  "openclaw_status",
  "hermes_status",
}, {
  background = {
    color = colors.background_1,
    border_color = colors.background_2,
  },
  padding_left = 3,
  padding_right = 3,
})
