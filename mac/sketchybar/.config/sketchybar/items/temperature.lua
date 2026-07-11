-- Ported from items/temperature.sh — polls plugins/temperature.sh (smctemp TH0x).
local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

local script = settings.plugin_dir .. "/temperature.sh"

sbar.add("item", "temperature", {
  position = "right",
  icon = {
    string = icons.temperature,
    font = "MonaspiceKr Nerd Font:Bold:20.0",
    color = colors.yellow,
  },
  label = {
    font = "MonaspiceKr Nerd Font:Medium:8.0",
    color = colors.white,
  },
  padding_left = 2,
  padding_right = 2,
  background = { drawing = false },
  update_freq = 15,
  script = script,
})
