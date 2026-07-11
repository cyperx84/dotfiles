-- Ported from colors.sh — Eldritch Dark theme (active)
-- Author: cyperx (https://github.com/cyperx84)
-- Hex is 0xAARRGGBB (alpha-first), same values SketchyBar shell used.

local base = {
  black       = 0xff000000,
  white       = 0xffffffff,
  red         = 0xffff001f,
  green       = 0xff80ff00,
  blue        = 0xff002aff,
  yellow      = 0xfff1fc79,
  orange      = 0xffff6b00,
  magenta     = 0xffa48cf2,
  grey        = 0xff323449,
  transparent = 0x00000000,

  bg0   = 0xff1e1e2e,
  bg0o50 = 0x801e1e2e,
  bg0o60 = 0x991e1e2e,
  bg0o70 = 0xB21e1e2e,
  bg0o80 = 0xCC1e1e2e,
  bg0o85 = 0xCF0D1116, -- Active: Eldritch Dark
  bg1   = 0x603c3e4f,
  bg2   = 0x60494d64,
}

return {
  -- palette
  black = base.black, white = base.white, red = base.red, green = base.green,
  blue = base.blue, yellow = base.yellow, orange = base.orange,
  magenta = base.magenta, grey = base.grey, transparent = base.transparent,
  bg0 = base.bg0, bg1 = base.bg1, bg2 = base.bg2,

  -- bar
  bar = {
    color  = base.bg0o85, -- BAR_COLOR
    border = base.bg2,    -- BAR_BORDER_COLOR
  },
  background_1 = base.bg1, -- BACKGROUND_1
  background_2 = base.bg2, -- BACKGROUND_2

  icon_color  = base.green, -- ICON_COLOR
  label_color = base.green, -- LABEL_COLOR
  shadow      = base.orange, -- SHADOW_COLOR

  popup = {
    bg     = base.bg0o85, -- POPUP_BACKGROUND_COLOR (= BAR_COLOR)
    border = base.green,  -- POPUP_BORDER_COLOR
  },

  -- aerospace spaces
  space = {
    active_bg      = base.transparent,
    active_border  = base.green,
    active_text    = base.green,
    inactive_bg    = base.bg1,
    inactive_border = base.bg2,
    inactive_text  = base.green,
    empty_text     = base.grey,
    window_indicator = base.orange,
  },
}
