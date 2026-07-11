local colors = require("colors")

-- Equivalent to the --bar domain (ported from sketchybarrc `bar=`)
sbar.bar({
  height        = 35,
  color         = colors.bar.color,
  border_width  = 2,
  border_color  = colors.bar.border,
  shadow        = true,
  position      = "top",
  sticky        = true,
  padding_right = 10,
  padding_left  = 10,
  y_offset      = -5,
  margin        = -2,
  topmost       = "window",
})
