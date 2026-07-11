-- Ported from items/apple.sh — Apple logo + popup menu.
local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

local POPUP_OFF = "sketchybar --set apple.logo popup.drawing=off"
local POPUP_TOGGLE = "sketchybar --set $NAME popup.drawing=toggle"

local logo = sbar.add("item", "apple.logo", {
  icon = {
    string = icons.apple,
    font = { family = settings.font, style = "Black", size = 20.0 },
    color = colors.green,
  },
  padding_right = 15,
  label = { drawing = false },
  click_script = POPUP_TOGGLE,
  popup = { height = 35 },
})

local pos = "popup." .. logo.name

sbar.add("item", "apple.prefs", {
  position = pos,
  icon = { string = icons.preferences },
  label = { string = "Preferences" },
  click_script = "open -a 'System Preferences'; " .. POPUP_OFF,
})

sbar.add("item", "apple.activity", {
  position = pos,
  icon = { string = icons.activity },
  label = { string = "Activity" },
  click_script = "open -a 'Activity Monitor'; " .. POPUP_OFF,
})

sbar.add("item", "apple.lock", {
  position = pos,
  icon = { string = icons.lock },
  label = { string = "Lock Screen" },
  click_script = "pmset displaysleepnow; " .. POPUP_OFF,
})

sbar.add("item", "apple.bluetooth", {
  position = pos,
  icon = { string = icons.bluetooth, font = { family = settings.font, style = "Bold", size = 16.0 } },
  label = { string = "BT Restart" },
  click_script = "open btt://execute_assigned_actions_for_trigger/?uuid=A85489BC-14EE-4332-9985-EF0C39F97389; " .. POPUP_OFF,
})

sbar.add("item", "apple.restart", {
  position = pos,
  icon = { string = icons.restart, font = { family = settings.font, style = "Bold", size = 16.0 } },
  label = { string = "Restart" },
  click_script = "~/github/dotfiles-latest/scripts/macos/mac/misc/220-restartConfirm.sh; " .. POPUP_OFF,
})
