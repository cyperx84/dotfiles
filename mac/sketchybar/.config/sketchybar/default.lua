local settings = require("settings")
local colors = require("colors")

-- Equivalent to the --default domain (ported from sketchybarrc `defaults=`)
sbar.default({
  updates = "when_shown",
  icon = {
    font = { family = settings.font, style = "Bold", size = 20.0 }, -- ICON_FONT
    color = colors.icon_color,
    padding_left = settings.paddings,
    padding_right = settings.paddings,
  },
  label = {
    font = { family = settings.font, style = "Medium", size = 10.0 }, -- SMALL_LABEL_FONT
    color = colors.label_color,
    padding_left = settings.paddings,
    padding_right = settings.paddings,
  },
  padding_left = settings.paddings,
  padding_right = settings.paddings,
  background = {
    height = 26,
    corner_radius = 16,
    border_width = 2,
  },
  popup = {
    background = {
      border_width = 2,
      corner_radius = 9,
      border_color = colors.popup.border,
      color = colors.popup.bg,
      shadow = { drawing = true },
    },
    blur_radius = 50,
  },
  scroll_texts = true,
})
