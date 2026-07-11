-- Ported from items/audio_output.sh — poll + event, keeps plugins/audio_output.sh + volume_click.sh.
local colors = require("colors")
local settings = require("settings")
local lib = require("lib")

local script = settings.plugin_dir .. "/audio_output.sh"

local audio_output = sbar.add("item", "audio_output", {
  position = "right",
  script = script,               -- native timer path (update_freq)
  update_freq = 10,
  updates = "on",
  padding_left = 2,
  padding_right = 2,
  icon = {
    font = settings.icon_font,    -- ICON_FONT
    color = colors.green,         -- GREEN
  },
  label = {
    font = settings.small_label_font, -- SMALL_LABEL_FONT
    color = colors.green,             -- GREEN
    padding_left = 2,
    padding_right = 2,
  },
  click_script = settings.plugin_dir .. "/volume_click.sh",
})

-- Event path: re-run the same plugin with full env forwarding.
lib.script_on(audio_output, { "routine", "volume_change", "mouse.clicked" }, script)
