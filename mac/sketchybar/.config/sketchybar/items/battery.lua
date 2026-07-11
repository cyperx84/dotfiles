-- Ported from items/battery.sh — keeps plugins/battery.sh (pmset + macmon watts).
local colors = require("colors")
local settings = require("settings")
local lib = require("lib")

local script = settings.plugin_dir .. "/battery.sh"

local battery = sbar.add("item", "battery", {
  position = "right",
  script = script,             -- native timer path (update_freq)
  update_freq = 120,
  updates = "on",
  icon = {
    font = { family = settings.font, style = "Regular", size = 24.0 },
    color = colors.yellow,
  },
  label = { drawing = true },
  padding_right = 3,
  padding_left = 0,
})

-- Event path: re-run the same plugin with full env forwarding.
lib.script_on(battery, { "routine", "power_source_change", "system_woke" }, script)
