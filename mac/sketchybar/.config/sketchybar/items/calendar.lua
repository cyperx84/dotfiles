-- Ported from items/calendar.sh — keeps plugins/calendar.sh (date) + zen.sh click.
local colors = require("colors")
local settings = require("settings")
local lib = require("lib")

local script = settings.plugin_dir .. "/calendar.sh"

local calendar = sbar.add("item", "calendar", {
  position = "right",
  icon = {
    string = "cal",
    font = "MonaspiceKr Nerd Font:Medium:12.0",
    color = colors.green,
    padding_right = 0,
  },
  label = {
    width = 5,
    align = "right",
  },
  padding_left = 15,
  update_freq = 60,               -- native timer path
  script = script,
  click_script = settings.plugin_dir .. "/zen.sh",
})

-- Event path: re-run the same plugin with full env forwarding.
-- "routine" fires every update_freq (SbarLua clears native script= on subscribe,
-- so the periodic clock tick must come through the event path).
lib.script_on(calendar, { "routine", "system_woke" }, script)
