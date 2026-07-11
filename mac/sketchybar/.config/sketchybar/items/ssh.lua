-- Ported from items/ssh.sh — SSH session indicator; keeps plugins/ssh.sh (poll every 5s).
local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

local script = settings.plugin_dir .. "/ssh.sh"

sbar.add("item", "ssh_status", {
  position = "left",
  icon = {
    string = icons.ssh,
    font = settings.icon_font,
    color = colors.blue,
  },
  label = {
    font = settings.label_font,
    color = colors.white,
  },
  padding_left = 2,
  padding_right = 4,
  update_freq = 5,
  updates = "on",
  script = script,             -- native timer path (update_freq)
  -- click_script commented out in source ssh.sh; preserved as disabled.
})
