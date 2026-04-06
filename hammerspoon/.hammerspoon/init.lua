-- Focus follows mouse via Accessibility API
local lastWinKey = nil

local function focusCheck()
  pcall(function()
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
