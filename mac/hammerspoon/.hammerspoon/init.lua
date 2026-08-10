-- Focus follows mouse via Accessibility API
local lastWinKey = nil

local EMOJI_PICKER_BUNDLE_IDS = {
  "com.apple.CharacterPaletteIM",
}

local function emojiPickerOpen()
  for _, bid in ipairs(EMOJI_PICKER_BUNDLE_IDS) do
    if hs.application.find(bid) then return true end
  end
  return false
end

local function frontmostIsDialog()
  local app = hs.application.frontmostApplication()
  if not app then return false end
  if app:name() == "System Settings" then return true end
  local axApp = hs.axuielement.applicationElement(app)
  if not axApp then return false end
  local focused = axApp:attributeValue("AXFocusedWindow")
  if not focused then return false end
  local subrole = focused:attributeValue("AXSubrole") or ""
  local modal = focused:attributeValue("AXModal")
  if modal == true then return true end
  if subrole == "AXDialog" or subrole == "AXSystemDialog"
     or subrole == "AXSheet" or subrole == "AXSystemFloatingWindow" then
    return true
  end
  return false
end

local function focusCheck()
  pcall(function()
    if frontmostIsDialog() or emojiPickerOpen() then
      hs.timer.doAfter(0.05, focusCheck)
      return
    end

    local mousePos = hs.mouse.absolutePosition()
    local element = hs.axuielement.systemWideElement():elementAtPosition(mousePos)

    if element then
      local current = element
      while current do
        local role = current:attributeValue("AXRole")
        if role == "AXWindow" then
          local pid = current:pid()
          local title = current:attributeValue("AXTitle") or ""
          local winKey = tostring(pid) .. ":" .. title

          if winKey ~= lastWinKey then
            lastWinKey = winKey
            local app = hs.application.applicationForPID(pid)
            if app then
              current:performAction("AXRaise")
              app:activate(false)
            end
          end
          break
        end
        current = current:attributeValue("AXParent")
      end
    end
  end)

  hs.timer.doAfter(0.05, focusCheck)
end

focusCheck()

-- ── herdr summon ────────────────────────────────────────────────────────────
-- alt+e anywhere: focus (or launch) the Ghostty window running herdr, then
-- open the sesh-bro picker by posting the alt+e chord (bound to the
-- sesh-bro.open plugin action in mac/herdr/.config/herdr/config.toml)
-- straight at the app.
--
-- Hammerspoon owns this rather than aerospace + osascript: AppleScript
-- keystrokes spawned from aerospace never reached Ghostty (verified — nothing
-- landed in the pane), while hs.eventtap posts events to the app directly.
-- But window *focus* across aerospace workspaces needs the aerospace CLI: a
-- bare hs.window:focus() silently no-ops when the window lives on another
-- workspace (e.g. an empty space), so we switch workspaces explicitly first.
require("hs.ipc")

local HERDR_PICKER = os.getenv("HOME") .. "/dotfiles/mac/scripts/herdr-picker.sh"
local AEROSPACE = "/opt/homebrew/bin/aerospace"

local function herdrWindow()
  local app = hs.application.get("Ghostty")
  if not app then return nil end
  for _, w in ipairs(app:allWindows()) do
    local title = w:title() or ""
    if title == "herdr" or title:match("^herdr%s") then return w end
  end
  return nil
end

-- Find which aerospace workspace holds the window, then switch to it.
-- Returns true on success (window exists and we switched/focused).
local function focusHerdrWorkspace(win)
  if not win then return false end
  local app = win:application()
  local pid = app and app:pid()
  if not pid then return false end

  local ok, out = pcall(hs.execute, AEROSPACE .. " list-windows --all --format '%{app-pid} %{workspace}'")
  if not ok or not out then return false end
  for line in out:gmatch("[^\n]+") do
    local wpid, ws = line:match("^(%d+)%s+(%S+)$")
    if wpid and tonumber(wpid) == pid then
      hs.execute(AEROSPACE .. " workspace " .. ws)
      win:focus()
      return true
    end
  end
  return false
end

-- keys.command alt+e = sesh-bro.open (see mac/herdr/.config/herdr/config.toml).
-- Rebind there and this must follow. Both keys go in one sequence — sending
-- the second from a timer callback left herdr stuck waiting for the chord.
local function sendPickerChord()
  local app = hs.application.get("Ghostty")
  if not app then return end
  hs.eventtap.keyStroke({ "alt" }, "e", 100000, app)
end

local function summonHerdr()
  local win = herdrWindow()
  if win then
    if focusHerdrWorkspace(win) then
      hs.timer.doAfter(0.15, sendPickerChord)
    end
    return
  end

  hs.execute(string.format("open -na Ghostty --args --title=herdr -e %q", HERDR_PICKER))

  local tries = 0
  local poll
  poll = hs.timer.doEvery(0.2, function()
    tries = tries + 1
    local w = herdrWindow()
    if w then
      poll:stop()
      if focusHerdrWorkspace(w) then
        hs.timer.doAfter(0.6, sendPickerChord) -- let the TUI paint first
      end
    elseif tries > 30 then
      poll:stop()
    end
  end)
end

hs.hotkey.bind({ "alt" }, "e", summonHerdr)
