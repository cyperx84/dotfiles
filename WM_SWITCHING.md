# Window Manager Switching Guide

## Current Setup

**Default (Auto-start):** Aerospace
**Alternative (Manual):** Yabai + SKHD

## Configurations

### Aerospace
- **Config:** `~/.config/aerospace/aerospace.toml` (187 lines, complete)
- **Keybindings:** All native in aerospace.toml
- **SketchyBar:** Full integration via `exec-on-workspace-change` callback
- **Auto-start:** Enabled (`start-at-login = true`)

### Yabai + SKHD
- **Yabai Config:** `~/.config/yabai/yabairc`
- **SKHD Config:** `~/.config/skhd/skhdrc` (restored original)
- **SketchyBar:** Uses Yabai signals (needs manual configuration)
- **Auto-start:** Disabled

## Switching Between Window Managers

### Currently Running: Aerospace
```bash
# Switch to Yabai + SKHD
killall AeroSpace
brew services start yabai
skhd &
```

### Currently Running: Yabai + SKHD
```bash
# Switch to Aerospace
brew services stop yabai
killall skhd
open -a AeroSpace
```

## Quick Status Check

```bash
# Check what's running
pgrep -l "AeroSpace|yabai|skhd"

# Aerospace running: Shows AeroSpace process
# Yabai running: Shows yabai and skhd processes
```

## Features Comparison

| Feature | Aerospace | Yabai + SKHD |
|---------|-----------|--------------|
| **Keybindings** | Native (in config) | SKHD managed |
| **SketchyBar** | Auto-updates | Needs setup |
| **Performance** | Faster (direct) | IPC overhead |
| **Complexity** | Single config | Two configs |
| **Maturity** | Newer | Battle-tested |

## Recommendation

**Stick with Aerospace** for daily use:
- Simpler setup
- Better SketchyBar integration
- Faster performance
- Clean single config

**Use Yabai** only if you need specific features Aerospace doesn't have.
