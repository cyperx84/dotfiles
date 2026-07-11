-- Ported from items/memory.sh — keeps plugins/memory.sh (macmon RAM usage/total).
-- Single item, no popup: icon + compact "21G 64%" label. Poll-only (update_freq).
local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

sbar.add("item", "memory", {
  position = "right",
  icon = {
    string = icons.memory,
    font = "MonaspiceKr Nerd Font:Bold:20.0",
    color = colors.magenta,
  },
  label = {
    font = "MonaspiceRn Nerd Font:Heavy:10",
    color = colors.white,
  },
  padding_left = 2,
  padding_right = 2,
  background = { drawing = false },
  update_freq = 10,
  script = settings.plugin_dir .. "/memory.sh",
})
