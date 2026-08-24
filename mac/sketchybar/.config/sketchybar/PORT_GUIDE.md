# SketchyBar SbarLua architecture

The Bash-to-SbarLua migration is complete. Lua defines items and subscriptions;
shell scripts remain only as focused runtime helpers.

## Module layout

- `sketchybarrc` loads SbarLua, adds the config directory to `package.path`, and
  starts the event loop.
- `init.lua` loads the bar, defaults, bootstrap logic, and `items/init.lua`.
- `items/*.lua` define item properties, order, polling, and event subscriptions.
- `plugins/*.sh` perform runtime work that is awkward or inappropriate in Lua.
- `helper/` contains the C system-metrics helper used by CPU items.

## Shared modules

- `require("colors")` provides the color palette.
- `require("icons")` provides icon glyphs.
- `require("settings")` provides fonts, paths, and helper identifiers.
- `require("lib")` provides helpers such as
  `lib.script_on(item, events, script)`, which forwards SketchyBar event data to
  shell helpers.

## Patterns

1. **Polling helper**: set `script` and `update_freq` on the Lua item.
2. **Event helper**: call `lib.script_on(item, { "event" }, script)`.
3. **Polling plus events**: use both patterns on the same item.
4. **Custom event**: register it with `sbar.add("event", name)` before subscribing.
5. **Popup child**: put `position = "popup." .. parent.name` inside its property table.
6. **Bracket**: use `sbar.add("bracket", name, members, properties)`.

## SbarLua caveats

- `mach_helper` is not forwarded by SbarLua. Assign it after item creation with
  `sbar.exec("sketchybar --set <name> mach_helper=" .. settings.helper)`.
- Use `item.name` when a generated or returned item name is required.
- Keep event-driven callbacks lightweight. Workspace refresh is intentionally
  batched through `plugins/refresh_spaces.sh` rather than polling every space.

## Maintenance rules

- New visible items belong in `items/*.lua` and must be loaded from
  `items/init.lua` in the intended display order.
- Add a shell helper only when Lua cannot reasonably perform the runtime work.
- Reuse `colors`, `icons`, `settings`, and `lib`; do not duplicate those values.
- After changes, run `~/.config/sketchybar/test_sketchybar.sh` and reload with
  `sketchybar --reload`.
