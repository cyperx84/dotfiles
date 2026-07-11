-- Ported from items/network.sh — keeps plugins/network.sh (up/down throughput poll).
local colors = require("colors")
local settings = require("settings")
local icons = require("icons")

local script = settings.plugin_dir .. "/network.sh"

sbar.add("item", "network", {
  position = "right",
  icon = {
    string = icons.network_up,             -- $NETWORK_UP
    font = settings.icon_font,             -- MonaspiceKr Nerd Font:Bold:20.0
    color = colors.blue,                   -- $BLUE
  },
  label = {
    font = settings.font .. ":Medium:8.0", -- MonaspiceKr Nerd Font:Medium:8.0
    color = colors.white,                  -- $WHITE
  },
  padding_left = 2,
  padding_right = 4,
  background = { drawing = false },
  update_freq = 10,
  script = script,                         -- native timer path
})
