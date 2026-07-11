-- Ported from items/cpu.sh — C-helper driven (mach_helper) + two overlaid graphs.
-- No shell plugin: the git.felix.helper binary pushes cpu.percent + graph data.
local colors = require("colors")
local settings = require("settings")

local mono = "MonaspiceRn Nerd Font"

sbar.add("item", "cpu.top", {
  position = "right",
  label = { font = mono .. ":Semibold:8", string = "CPU" },
  icon = { drawing = false },
  width = 0,
  padding_right = 4,
  padding_left = 2,
  background = { drawing = false },
  y_offset = 6,
})

sbar.add("item", "cpu.percent", {
  position = "right",
  label = { font = mono .. ":Heavy:10", string = "CPU" },
  y_offset = -4,
  padding_right = 4,
  padding_left = 0,
  width = 55,
  background = { drawing = false },
  icon = { drawing = false },
  update_freq = 2,
})
-- SbarLua does not forward the `mach_helper` property, so wire the C event helper
-- via raw CLI (this is what makes the helper push cpu.percent + graph data).
sbar.exec("sketchybar --set cpu.percent mach_helper=" .. settings.helper)

sbar.add("graph", "cpu.user", 100, {
  position = "right",
  width = 55,
  graph = { color = colors.blue, fill_color = 0x50002aff, line_width = 1.5 },
  background = { height = 20, drawing = false, color = colors.transparent, border_width = 0, corner_radius = 3 },
  label = { drawing = false },
  icon = { drawing = false },
  padding_left = 140,
  padding_right = 0,
  y_offset = 0,
})

sbar.add("graph", "cpu.sys", 100, {
  position = "right",
  width = 55,
  graph = { color = colors.red, fill_color = 0x50ff001f, line_width = 1.5 },
  background = { height = 20, drawing = true, color = 0x20000000, border_width = 0, corner_radius = 3 },
  label = { drawing = false },
  icon = { drawing = false },
  padding_left = 140,
  padding_right = -58,
  y_offset = 0,
})
