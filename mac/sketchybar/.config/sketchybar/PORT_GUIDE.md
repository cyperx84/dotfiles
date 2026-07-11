# SketchyBar bash → Lua (SbarLua) port guide

Phase A: port item **definitions** to Lua. **Keep every shell plugin, the C helper,
icon_map.sh, agents_lib.sh, timer.py verbatim** — Lua only defines the items and
points them at the existing scripts. Goal = behavior parity, not a logic rewrite.

## Modules (already built — require them, don't redefine)
- `require("colors")`  → table. e.g. `colors.green`, `colors.yellow`, `colors.red`,
  `colors.background_1`, `colors.background_2`, `colors.bar.color`, `colors.icon_color`,
  `colors.label_color`, `colors.space.*`, `colors.transparent`. Raw hex `0xAARRGGBB` also fine.
- `require("icons")`   → table keyed by **lowercased** shell var name, exact glyph bytes.
  e.g. `icons.wifi_connected`, `icons.memory`, `icons.disk`, `icons.temperature`,
  `icons.volume_100`, `icons.ssh`, `icons.tmux`, `icons.docker`, `icons.claude`, etc.
- `require("settings")` → `settings.font` ("MonaspiceKr Nerd Font"), `settings.paddings` (1),
  `settings.helper` ("git.felix.helper"), `settings.plugin_dir`, `settings.item_dir`,
  `settings.config_dir`, and font specs `settings.icon_font` / `small_label_font` / etc.
- `require("lib")` → `lib.script_on(item, events, script)` subscribes an item so its plugin
  `script` runs on those events with **full env forwarding** (NAME, SENDER, INFO, custom
  trigger vars). Use for every event-driven shell item.

## The parity pattern (match the source .sh EXACTLY)
Shell dotted props → nested Lua tables: `icon.color=X label.font=Y` becomes
`icon = { color = X }, label = { font = Y }`. Font `"Family:Style:Size"` may stay a string,
or become `{ family=, style=, size= }` — both work.

1. **Poll item** (`--set X script=... update_freq=N`): keep `script = settings.plugin_dir.."/X.sh"`
   and `update_freq = N` in the table. The native timer runs the script (NAME set by sketchybar).
2. **Event item** (`--subscribe X ev1 ev2`): after `sbar.add`, call
   `lib.script_on(item, {"ev1","ev2"}, script)`. If the item ALSO polls, keep BOTH
   `script=`/`update_freq` (timer) and `lib.script_on` (events) — no double-fire, the timer
   is not an event.
3. **click_script**: keep the shell string verbatim (may contain `$NAME`). sketchybar expands it.
4. **Bracket**: `sbar.add("bracket", "name", {"member1","member2"}, { props })`.
5. **Custom events**: `sbar.add("event", "my_event")` before items that subscribe to it.

## ⚠ SbarLua gotchas (verified live — DO THIS)
- **`mach_helper` is NOT forwarded** by SbarLua. If the source sets `mach_helper=$HELPER`,
  do NOT put it in the table. Instead, after `sbar.add`, do:
  `sbar.exec("sketchybar --set <name> mach_helper=" .. settings.helper)`
- **Popup children position must be IN the table**, not a positional arg:
  `sbar.add("item", "child", { position = "popup." .. parent.name, ... })`.
  (Bar positions "left"/"right"/"center" DO work as a 3rd positional string — but in-table
  `position = "right"` is equally fine and preferred for consistency.)
- `sbar.add` returns a handle; use `item.name` for the generated/explicit name.

## Reference examples (already ported + live-verified — copy their shape)
- `items/battery.lua` — poll + event, keeps plugin, hides on desktop.
- `items/cpu.lua`     — C-helper (mach_helper via sbar.exec) + two graphs.
- `items/spaces.lua`  — loop, custom events, keeps aerospace.sh plugin.
- `items/apple.lua`   — popup parent + children (position-in-table).

## Rules
- One `items/<name>.lua` per source `items/<name>.sh`. Same item names, same positions,
  same order of `--add` calls, same every property value.
- Do NOT modify plugins/, helper/, icon_map.sh, agents_lib.sh, colors.sh, icons.sh.
- If the source item sources colors/icons for values, map them to the Lua `colors`/`icons` modules.
- Preserve exact numeric values (paddings, offsets, widths, freqs) and exact colors.
