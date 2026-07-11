-- Ported from items/tmux.sh — keeps plugins/tmux.sh (tmux session indicator, polling).
local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

sbar.add("item", "tmux_status", {
  position = "left",
  icon = {
    string = icons.tmux,
    font = settings.icon_font,   -- ICON_FONT
    color = colors.green,        -- GREEN
  },
  label = {
    font = settings.label_font,  -- LABEL_FONT
    color = colors.white,        -- WHITE
  },
  padding_left = 2,
  padding_right = 4,
  update_freq = 5,
  updates = "on",
  script = settings.plugin_dir .. "/tmux.sh",  -- native timer path
  -- click_script left commented out in source; omitted here to match.
})
