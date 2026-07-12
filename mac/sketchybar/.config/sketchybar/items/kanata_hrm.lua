-- Home row mods (kanata) on/off indicator.
-- Polls kanata's TCP layer state via plugins/kanata_hrm.sh (native timer path,
-- same pattern as tmux.lua / ssh.lua). No daemon; re-inits on every reload.
local colors = require("colors")
local settings = require("settings")

sbar.add("item", "kanata_hrm", {
  position = "left",
  icon = {
    string = "󰌌",                -- nf-md-keyboard_variant
    font = settings.icon_font,
    color = colors.green,
  },
  label = {
    string = "HRM",
    font = settings.label_font,
    color = colors.green,
  },
  padding_left = 2,
  padding_right = 4,
  update_freq = 3,               -- 3s poll; layer state on TCP connect
  updates = "on",
  script = settings.plugin_dir .. "/kanata_hrm.sh",
})
