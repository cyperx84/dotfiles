-- Ported from items/docker.sh — keeps plugins/docker.sh (docker status + resource poll).
local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

local script = settings.plugin_dir .. "/docker.sh"

sbar.add("item", "docker_status", {
  position = "left",
  icon = {
    string = icons.docker,
    font = settings.icon_font,
    color = colors.blue,
  },
  label = {
    font = settings.label_font,
    color = colors.white,
  },
  padding_left = 2,
  padding_right = 4,
  update_freq = 15,
  updates = "on",
  script = script,             -- native timer path (update_freq)
  -- click_script = "open -a 'Docker Desktop'"  -- disabled in source
})
