-- Ported from items/volume.sh — volume slider + icon + popup template + `status` bracket.
-- Keeps plugins/volume.sh (slider animate) and plugins/volume_click.sh.
local colors = require("colors")
local icons = require("icons")
local settings = require("settings")
local lib = require("lib")

local script = settings.plugin_dir .. "/volume.sh"

-- Slider (width 0 by default; the plugin animates it open on volume_change).
local volume = sbar.add("slider", "volume", 0, {
  position = "right",
  updates = "on",
  label = { drawing = false },
  icon = { drawing = false },
  padding_right = 3,
  slider = {
    highlight_color = colors.green,
    background = { height = 5, corner_radius = 3, color = colors.background_2 },
    knob = { string = icons.slider_knob, drawing = true, font = settings.icon_font },
  },
})
-- Event-only (no update_freq) → no "routine". SENDER branches volume_change/mouse.clicked.
lib.script_on(volume, { "volume_change", "mouse.clicked" }, script)

-- Volume icon (click toggles mute/opens; popup right-aligned).
sbar.add("item", "volume_icon", {
  position = "right",
  click_script = settings.plugin_dir .. "/volume_click.sh",
  padding_left = 8,
  padding_right = 4,
  icon = { string = icons.volume_100, font = settings.icon_font, color = colors.green },
  label = { drawing = false },
  popup = { align = "right" },
})
-- NOTE: the source subscribes volume_icon to mouse.entered/exited/exited.global, but
-- volume_icon has no `script`, so those were no-ops in the bash config — omitted here.

-- Popup template item under volume_icon.
sbar.add("item", "volume.template", {
  position = "popup.volume_icon",
  drawing = false,
  background = { corner_radius = 12 },
  padding_left = 7,
  padding_right = 7,
  icon = { background = { height = 2, y_offset = -12 } },
})

-- `status` bracket (github.bell is disabled/absent, so it is not a member — matches live bar).
sbar.add("bracket", "status", { "brew", "wifi", "audio_output", "volume_icon" }, {
  background = { color = colors.background_1, border_color = colors.background_2 },
  padding_left = 3,
  padding_right = 3,
})
