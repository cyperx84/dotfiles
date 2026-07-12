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

  machine_blue = 0xff0400ff, -- M1 accent; matches shell skull + ghostty cursor (#0400FF)
}

-- Per-machine accent color. This REPLACES the theme green everywhere green was
-- the accent (icons, labels, app name, workspace outline, time/date, popup
-- border), so the whole bar signals which machine at a glance — mirrors the
-- shell prompt skull + ghostty cursor. M1 = blue #0400FF; every other host keeps
-- the bar's green (#80FF00), so M4 is unchanged. Add a machine = add a branch.
-- Agent-status greens are a different hex set in their own plugins, untouched.
local function machine_color()
  local h = io.popen("hostname -s")
  local name = h and h:read("*a") or ""
  if h then h:close() end
  name = name:gsub("%s+", "")
  if name:match("^m1") then return base.machine_blue end
  return base.green
end
local accent = machine_color()

return {
  -- per-machine accent (also exported for explicit use, e.g. apple.logo)
  machine = accent,

  -- palette (green is the theme accent → resolves to the machine accent)
  black = base.black, white = base.white, red = base.red, green = accent,
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

  icon_color  = accent, -- ICON_COLOR (machine accent)
  label_color = accent, -- LABEL_COLOR (machine accent → app name)
  shadow      = base.orange, -- SHADOW_COLOR

  popup = {
    bg     = base.bg0o85, -- POPUP_BACKGROUND_COLOR (= BAR_COLOR)
    border = accent,  -- POPUP_BORDER_COLOR (machine accent)
  },

  -- aerospace spaces (active outline + text = machine accent)
  space = {
    active_bg      = base.transparent,
    active_border  = accent,
    active_text    = accent,
    inactive_bg    = base.bg1,
    inactive_border = base.bg2,
    inactive_text  = accent,
    empty_text     = base.grey,
    window_indicator = base.orange,
  },
}
