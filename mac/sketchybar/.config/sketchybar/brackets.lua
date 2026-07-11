-- Ported from the system_monitor bracket in sketchybarrc.
local colors = require("colors")
local settings = require("settings")

sbar.add("bracket", "system_monitor", {
  "cpu.top", "cpu.percent", "cpu.sys", "cpu.user",
  "memory",
  "temperature", "disk", "network",
}, {
  background = {
    color = colors.background_1,
    border_color = colors.background_2,
  },
  padding_left = 3,
  padding_right = 3,
  click_script = settings.plugin_dir .. "/system_monitor_details.sh",
})
