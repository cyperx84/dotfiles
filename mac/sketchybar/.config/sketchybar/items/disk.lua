-- Ported from items/disk.sh — poll-only, keeps plugins/disk.sh (df on Data volume).
local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

local script = settings.plugin_dir .. "/disk.sh"

sbar.add("item", "disk", {
  position = "right",
  icon = {
    string = icons.disk,
    font = "MonaspiceKr Nerd Font:Bold:20.0",
    color = colors.orange,
  },
  label = {
    font = "MonaspiceKr Nerd Font:Medium:8.0",
    color = colors.white,
  },
  padding_left = 2,
  padding_right = 2,
  background = { drawing = false },
  update_freq = 30,
  script = script,             -- native timer path (update_freq)
})
