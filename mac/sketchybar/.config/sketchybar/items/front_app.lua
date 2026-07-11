-- Ported from items/front_app.sh — focused app name/icon (left), event-driven.
-- Keeps plugins/front_app.sh (sets label + app icon on front_app_switched).
local settings = require("settings")
local lib = require("lib")

local script = settings.plugin_dir .. "/front_app.sh"

local front_app = sbar.add("item", "front_app", {
  position = "left",
  label = {
    padding_left = 4,
    padding_right = 10,
    -- Using "MonaspiceRn Nerd Font" (Bold 20) — distinct family from settings.font.
    font = "MonaspiceRn Nerd Font:Bold:20.0",
  },
  icon = { background = { drawing = true } },
  display = "active",
  script = script,
  click_script = "open -a 'Mission Control'",
})

-- Event path: re-run the plugin with full env forwarding (NAME, SENDER, INFO).
lib.script_on(front_app, { "front_app_switched" }, script)
