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
