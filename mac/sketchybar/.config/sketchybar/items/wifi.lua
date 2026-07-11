-- Ported from items/wifi.sh — WiFi/network name (right), event-driven.
-- Keeps plugins/wifi.sh (update on wifi_change, width toggle on mouse.clicked).
local colors = require("colors")
local icons = require("icons")
local settings = require("settings")
local lib = require("lib")

local script = settings.plugin_dir .. "/wifi.sh"

local wifi = sbar.add("item", "wifi", {
  position = "right",
  padding_right = 6,
  padding_left = 0,
  label = {
    width = 0,
    max_chars = 0,
    padding_right = 4,
  },
  icon = {
    string = icons.wifi_disconnected,
    font = "MonaspiceKr Nerd Font:Bold:20.0",
    color = colors.blue,
  },
  script = script,
})

-- Event path: re-run the plugin with full env forwarding (NAME, SENDER, INFO).
lib.script_on(wifi, { "wifi_change", "mouse.clicked" }, script)
