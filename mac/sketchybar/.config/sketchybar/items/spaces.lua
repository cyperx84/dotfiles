-- AeroSpace workspace indicators (center), with storm-proof hide-empty.
--
-- Design: the 9 space items only render + handle click-to-focus. All state
-- (highlight, window-count label, hide-empty visibility) is driven by the single
-- batched, lock-guarded plugins/refresh_spaces.sh — never per-space polling.
-- Two triggers feed it, both lock-guarded so they can never stack:
--   * spaces_sync : event-driven (workspace switch / front app switch) -> instant
--   * spaces_poll : a low-frequency native timer -> catch-all for background
--                   window moves that fire no workspace-change event
local colors = require("colors")
local settings = require("settings")
local lib = require("lib")
local space_icons = require("items.space_icons")

local refresh = settings.plugin_dir .. "/refresh_spaces.sh"

-- Custom events the WM triggers against (kept for compatibility with the
-- aerospace.toml exec-on-workspace-change trigger).
sbar.add("event", "aerospace_workspace_change")

for sid = 1, 9 do
  local icon = space_icons[sid] or "󰯈"

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
  })

  -- Click a space to focus that workspace (aerospace.sh mouse.clicked -> space.sh).
  -- Rare event, no polling.
  lib.script_on(space, { "mouse.clicked" }, settings.plugin_dir .. "/aerospace.sh " .. sid)
end

-- Event-driven refresh: instant on workspace switch AND on front-app switch
-- (catches most window moves). Lock-guarded + batched, so frequent fires are safe.
local sync = sbar.add("item", "spaces_sync", {
  position = "center",
  drawing = false,
  width = 0,
  icon = { drawing = false },
  label = { drawing = false },
})
lib.script_on(sync, { "aerospace_workspace_change", "front_app_switched" }, refresh)

-- Catch-all native poll for background window moves that emit no event.
-- Visible-but-empty (drawing=on, zero content) so the update_freq timer reliably
-- fires even though it renders nothing. Non-subscribed => native script timer.
sbar.add("item", "spaces_poll", {
  position = "center",
  drawing = true,
  width = 0,
  icon = { drawing = false },
  label = { drawing = false },
  background = { drawing = false },
  script = refresh,
  update_freq = 5,
})

-- Initial paint.
sbar.exec(refresh)
