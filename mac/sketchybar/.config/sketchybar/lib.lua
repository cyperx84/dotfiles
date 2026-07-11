-- Parity primitive for the Lua port.
-- Phase A keeps the existing shell plugins verbatim. For EVENT-driven items we
-- register a Lua callback that re-invokes the plugin exactly as sketchybar would:
-- forwarding every env var (NAME, SENDER, INFO, and any custom trigger vars like
-- FOCUSED_WORKSPACE) so the script sees an identical environment. Polling items
-- keep their `script=` property + update_freq, so the timer path stays native and
-- there is no double-fire (timer is not an event).
local M = {}

local function shq(v)
  -- single-quote shell-escape
  return "'" .. tostring(v):gsub("'", "'\\''") .. "'"
end

-- Build "K1=v1 K2=v2 ... <script>" and run async off the event thread.
function M.run(script, env)
  local pre = ""
  if env then
    for k, v in pairs(env) do
      pre = pre .. k .. "=" .. shq(v) .. " "
    end
  end
  sbar.exec(pre .. script)
end

-- Subscribe an item to events so that its plugin `script` runs on each, with full
-- env forwarding. `script` may include arguments (e.g. "aerospace.sh 3").
function M.script_on(item, events, script)
  item:subscribe(events, function(env)
    M.run(script, env)
  end)
end

return M
