-- Ported from sketchybarrc header vars.
local home = os.getenv("HOME")
local config_dir = home .. "/.config/sketchybar"

return {
  font            = "MonaspiceKr Nerd Font",
  paddings        = 1,          -- PADDINGS
  helper          = "git.felix.helper", -- HELPER (mach event server bootstrap name)

  config_dir      = config_dir,
  item_dir        = config_dir .. "/items",
  plugin_dir      = config_dir .. "/plugins",
  helper_dir      = config_dir .. "/helper",

  -- Named font specs used across items (family:style:size)
  icon_font       = "MonaspiceKr Nerd Font:Bold:20.0",       -- ICON_FONT
  label_font      = "MonaspiceKr Nerd Font:Medium:12.0",     -- LABEL_FONT
  large_icon_font = "MonaspiceKr Nerd Font:Bold:24.0",       -- LARGE_ICON_FONT
  small_label_font = "MonaspiceKr Nerd Font:Medium:10.0",    -- SMALL_LABEL_FONT
}
