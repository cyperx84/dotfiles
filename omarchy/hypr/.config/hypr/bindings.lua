-- Personal Hyprland bindings, layered on Omarchy 4's defaults.
--
-- Ported from linux/hypr, minus the CTRL + SHIFT bindings that shadow app
-- shortcuts (terminal paste, VS Code palette, incognito windows...). Only the
-- CTRL + SHIFT (+ ALT) + hjkl focus/swap set is kept.
--
-- API: o.bind(keys, description, dispatcher) / hl.unbind(keys) / hl.dsp.*
-- Reference: /usr/share/hypr/stubs/hl.meta.lua

-- ── Workspaces on the home row ──────────────────────────────────────────────
-- SUPER + J/K/L/U/I/O reaches workspaces 1-6 without leaving home position.
-- Upstream binds four of those letters to window actions, so unbind first and
-- move the ones worth keeping onto SUPER + ALT.
hl.unbind("SUPER + J") -- was: Toggle window split
hl.unbind("SUPER + K") -- was: Show key bindings
hl.unbind("SUPER + L") -- was: Toggle workspace layout
hl.unbind("SUPER + O") -- was: Pop window out
hl.unbind("SUPER + ALT + K") -- was: Tmux keybindings
-- ALT + SHIFT + L also triggers Chromium's Copy URL extension; this bind wins.

o.bind("SUPER + ALT + J", "Toggle window split", hl.dsp.layout("togglesplit"))
o.bind("SUPER + ALT + K", "Show key bindings", "omarchy-menu-keybindings")
o.bind("SUPER + ALT + L", "Toggle workspace layout", "omarchy-hyprland-workspace-layout-toggle")
o.bind("SUPER + ALT + O", "Pop window out (float & pin)", "omarchy-hyprland-window-pop")

local workspace_keys = {
  { "J", 1 }, { "K", 2 }, { "L", 3 },
  { "U", 4 }, { "I", 5 }, { "O", 6 },
}

for _, entry in ipairs(workspace_keys) do
  local key, workspace = entry[1], tostring(entry[2])
  o.bind("SUPER + " .. key, "Switch to workspace " .. workspace, hl.dsp.focus({ workspace = workspace }))
  o.bind("ALT + SHIFT + " .. key, "Move window to workspace " .. workspace, hl.dsp.window.move({ workspace = workspace }))
end

o.bind("ALT + SHIFT + N", "Move window to next workspace", hl.dsp.window.move({ workspace = "e+1" }))
o.bind("ALT + SHIFT + P", "Move window to previous workspace", hl.dsp.window.move({ workspace = "e-1" }))

-- ── Windows ─────────────────────────────────────────────────────────────────
-- Vim-style focus. The one CTRL + SHIFT set kept on purpose (shadows e.g.
-- Chromium's Ctrl+Shift+J devtools).
local directions = { { "H", "l", "left" }, { "J", "d", "down" }, { "K", "u", "up" }, { "L", "r", "right" } }

for _, entry in ipairs(directions) do
  local key, direction, label = entry[1], entry[2], entry[3]
  o.bind("SHIFT + CTRL + " .. key, "Focus " .. label, hl.dsp.focus({ direction = direction }))
  o.bind("SHIFT + CTRL + ALT + " .. key, "Move window " .. label, hl.dsp.window.swap({ direction = direction }))
end

-- Resize the active window, 50px a step.
o.bind("CTRL + ALT + SUPER + H", "Shrink window left", hl.dsp.window.resize({ x = -50, y = 0, relative = true }))
o.bind("CTRL + ALT + SUPER + L", "Expand window right", hl.dsp.window.resize({ x = 50, y = 0, relative = true }))
o.bind("CTRL + ALT + SUPER + J", "Expand window down", hl.dsp.window.resize({ x = 0, y = 50, relative = true }))
o.bind("CTRL + ALT + SUPER + K", "Shrink window up", hl.dsp.window.resize({ x = 0, y = -50, relative = true }))

o.bind("SHIFT + ALT + S", "Move window to previous monitor", hl.dsp.window.move({ monitor = "-1" }))
o.bind("SHIFT + ALT + G", "Move window to next monitor", hl.dsp.window.move({ monitor = "+1" }))

-- ── Apps ────────────────────────────────────────────────────────────────────
o.bind("SUPER + SHIFT + T", "Activity", "omarchy-launch-tui btop")
