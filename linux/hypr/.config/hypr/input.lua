-- Input overrides on top of Omarchy 4's defaults.
--
-- Upstream already sets repeat_rate 40, numlock_by_default, clickfinger_behavior
-- and the per-terminal scroll_touchpad window rules we used to carry, so only
-- the values we actually disagree on live here.
--   repeat_delay  upstream 250 -> 600 (slower before key repeat kicks in)
--   natural_scroll upstream false -> true
--   scroll_factor upstream 0.4 -> 0.8
hl.config({
  input = {
    repeat_delay = 600,
    touchpad = {
      natural_scroll = true,
      clickfinger_behavior = true,
      scroll_factor = 0.8,
    },
  },
})
