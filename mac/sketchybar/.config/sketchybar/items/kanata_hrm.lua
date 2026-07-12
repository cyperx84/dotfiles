-- Home row mods (kanata) on/off indicator.
-- Instant updates come from a persistent TCP listener (kanata_hrm_listen.sh)
-- that streams kanata's LayerChange events; the update_freq=3 poll below
-- (plugins/kanata_hrm.sh) stays as a reconciler if the listener dies/misses.
local colors = require("colors")
local settings = require("settings")

-- Launch the instant listener. It self-dedupes (kills prior instances), so
-- re-running this on every --reload is idempotent — no stacked listeners.
sbar.exec("nohup " .. settings.plugin_dir .. "/kanata_hrm_listen.sh >/dev/null 2>&1 &")

sbar.add("item", "kanata_hrm", {
  position = "left",
  icon = {
    string = "󰌌",                -- nf-md-keyboard_variant
    font = settings.icon_font,
    color = colors.green,
  },
  label = {
    string = "HRM",
    font = settings.label_font,
    color = colors.green,
  },
  padding_left = 2,
  padding_right = 4,
  update_freq = 3,               -- 3s poll; layer state on TCP connect
  updates = "on",
  script = settings.plugin_dir .. "/kanata_hrm.sh",
})
