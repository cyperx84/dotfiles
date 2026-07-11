-- Ported from items/brew.sh — Homebrew outdated count (right).
-- Keeps plugins/brew.sh; polls every 30 min and re-runs on the custom brew_update event.
local colors = require("colors")
local settings = require("settings")
local lib = require("lib")

local script = settings.plugin_dir .. "/brew.sh"

-- Custom event the brew() zsh function triggers via `sketchybar --trigger brew_update`.
sbar.add("event", "brew_update")

local brew = sbar.add("item", "brew", {
  position = "right",
  icon = {
    string = "󰏖",
    font = { family = settings.font, style = "Bold", size = 20.0 },
    color = colors.orange,
  },
  -- Set update frequency to 30 min (30*60=1800)
  update_freq = 1800,
  padding_right = 12,
  label = { padding_left = 2 },
  script = script,
})

-- Event path: re-run the same plugin with full env forwarding.
lib.script_on(brew, { "routine", "brew_update" }, script)
