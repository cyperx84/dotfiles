-- One-time startup side effects, ported from the sketchybarrc header.
-- Runs at config load (before the event loop starts), so os.execute is fine here.
local settings = require("settings")

-- Install vendored Devicons brand-icon font (agents cluster) if missing. No-op if present.
os.execute(string.format(
  [[[ -f "%s/fonts/devicons.ttf" ] && [ ! -f "$HOME/Library/Fonts/devicons.ttf" ] && ]] ..
  [[cp "%s/fonts/devicons.ttf" "$HOME/Library/Fonts/devicons.ttf" 2>/dev/null; true]],
  settings.config_dir, settings.config_dir))

-- Compile (hash-cached) + (re)start the C event helper `git.felix.helper`.
-- Mirrors compile_helper() + start block from the bash rc.
os.execute(string.format([[
  HELPER_DIR="%s"; HELPER_BIN="$HELPER_DIR/helper"; HASH_FILE="$HELPER_DIR/.source_hash"
  killall helper 2>/dev/null
  if [ -d "$HELPER_DIR" ]; then
    CUR=$(cat "$HELPER_DIR"/*.c "$HELPER_DIR"/*.h "$HELPER_DIR"/makefile 2>/dev/null | shasum -a 256 | cut -d' ' -f1)
    STORED=""; [ -f "$HASH_FILE" ] && STORED=$(cat "$HASH_FILE")
    if [ "$CUR" != "$STORED" ] || [ ! -x "$HELPER_BIN" ]; then
      (cd "$HELPER_DIR" && make clean && make) && echo "$CUR" > "$HASH_FILE"
    fi
    # Export the palette (RED/ORANGE/YELLOW/LABEL_COLOR) into the helper env:
    # cpu.h picks the cpu.percent label colour via getenv(), and without these
    # the colour is invalid so the overall cpu label renders invisible.
    [ -f "$HELPER_DIR/../colors.sh" ] && . "$HELPER_DIR/../colors.sh"
    [ -x "$HELPER_BIN" ] && "$HELPER_BIN" %s >/dev/null 2>&1 &
  fi
  true
]], settings.helper_dir, settings.helper))
