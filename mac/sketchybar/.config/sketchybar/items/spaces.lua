-- Ported from items/spaces.sh — AeroSpace workspace indicators (center).
-- Keeps plugins/aerospace.sh (incl. the shadow fix) and space_window_count.sh.
local colors = require("colors")
local settings = require("settings")
local lib = require("lib")
local space_icons = require("items.space_icons")

-- Custom events the aerospace plugin + WM trigger against.
sbar.add("event", "aerospace_workspace_change")
sbar.add("event", "window_change")

for sid = 1, 9 do
  local icon = space_icons[sid] or "󰯈"
  local script = settings.plugin_dir .. "/aerospace.sh " .. sid

  local space = sbar.add("item", "space." .. sid, {
    position = "center",
    icon = {
      string = sid .. "  " .. icon,
      color = colors.space.window_indicator,
      font = "SF Pro:Semibold:14.0",
      width = 40,
      drawing = true,
      padding_left = 8,
      padding_right = 2,
      highlight_color = colors.space.active_text,
    },
    label = {
      width = 20,
      drawing = true,
      padding_left = 2,
      padding_right = 8,
      color = colors.space.active_text,
      highlight_color = colors.space.active_text,
      font = "sketchybar-app-font:Medium:14.0",
      y_offset = 0,
    },
    padding_left = 1,
    padding_right = 1,
    background = {
      color = colors.space.inactive_bg,
      border_color = colors.space.inactive_border,
      corner_radius = 10,
      height = 20,
      border_width = 1,
      drawing = true,
    },
    script = script,
    update_freq = 2,
  })

  lib.script_on(space,
    { "routine", "aerospace_workspace_change", "window_change", "front_app_switched", "mouse.clicked" },
    script)

  -- Initial window count (same as the bash loop's trailing call).
  sbar.exec(settings.plugin_dir .. "/space_window_count.sh " .. sid)
end
