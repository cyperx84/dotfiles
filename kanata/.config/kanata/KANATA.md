# Kanata Configuration for macOS

> **Version:** 1.2 | **Last Updated:** February 2026 | **macOS:** Sequoia 15.x | **Kanata:** 1.7.0+

A comprehensive guide for Kanata keyboard remapping on macOS, including setup, layer configuration, and troubleshooting.

---

## Table of Contents

1. [Overview](#overview)
2. [Architecture](#architecture)
3. [Installation](#installation)
4. [LaunchDaemon Setup](#launchdaemon-setup)
5. [Layer Reference](#layer-reference)
6. [Quick Reference](#quick-reference)
7. [Troubleshooting](#troubleshooting)
8. [Maintenance](#maintenance)

---

## Overview

Kanata is a cross-platform keyboard remapping tool that provides:
- Low-level key interception (before applications receive input)
- Sophisticated features: layers, tap-hold, chords, macros
- Shell command execution from key presses
- Minimal resource usage as a system daemon

### This Configuration

| Feature | Implementation |
|---------|----------------|
| Home Row Mods | ASDF/JKL; become modifiers when held |
| Symbol Layer | Space-hold activates programming symbols |
| Number Layer | Apostrophe-hold activates numpad |
| Vim-friendly Caps | Escape on tap, Control on hold |
| Hyper Key | Tab-hold becomes Cmd+Alt+Shift+Ctrl |
| Layer Toggle | Fn+F1 switches between HRM and vanilla modes |

### File Locations

```
Configuration:
  ~/.config/kanata/kanata.kbd           # Main configuration file

LaunchDaemons:
  /Library/LaunchDaemons/
    com.example.kanata.plist            # Kanata service
    com.example.karabiner-vhid*.plist   # VirtualHID services

Logs:
  /tmp/kanata.out.log                   # Info/debug output
  /tmp/kanata.err.log                   # Errors and panics

Binaries:
  /opt/homebrew/bin/kanata              # Kanata executable (Homebrew symlink)

Drivers:
  /Library/Application Support/org.pqrs/Karabiner-DriverKit-VirtualHIDDevice/
  /Applications/.Karabiner-VirtualHIDDevice-Manager.app
```

---

## Architecture

### Component Stack

```
┌─────────────────────────────────────────────────────┐
│                   macOS System                       │
├─────────────────────────────────────────────────────┤
│  Karabiner-DriverKit-VirtualHIDDevice               │
│  ├── Virtual HID Device Driver (DriverKit)          │
│  ├── VirtualHIDDevice-Daemon (LaunchDaemon)         │
│  └── VirtualHIDDevice-Manager (LaunchDaemon)        │
├─────────────────────────────────────────────────────┤
│  Kanata (LaunchDaemon)                              │
│  ├── Intercepts physical keyboard events            │
│  ├── Processes remapping rules                      │
│  └── Sends virtual keyboard events                  │
└─────────────────────────────────────────────────────┘
```

**Why Karabiner-DriverKit?** macOS sandboxing prevents user-space programs from directly intercepting keyboard events. The driver provides the necessary bridge.

### Layer Stack

```
┌─────────────────────────────────────────────────────────────┐
│  fn / fnvanilla    ← Fn key hold                            │
├─────────────────────────────────────────────────────────────┤
│  nums              ← Apostrophe (') hold                    │
├─────────────────────────────────────────────────────────────┤
│  sym               ← Space hold                             │
├─────────────────────────────────────────────────────────────┤
│  base / vanilla    ← Default (toggle via Fn+F1)             │
└─────────────────────────────────────────────────────────────┘
```

### Timing Configuration

```lisp
(defvar
  tap-time 200    ;; Max ms for a tap
  hold-time 230   ;; Min ms to trigger hold
)
```

---

## Installation

### Step 1: Install Dependencies

```bash
brew install --cask karabiner-driverkit-virtualhiddevice
brew install kanata
```

You may need to approve the system extension:
1. Open **System Settings** → **Privacy & Security**
2. Look for blocked system extension message
3. Click **Allow** and restart if prompted

### Step 2: Create Configuration

```bash
mkdir -p ~/.config/kanata
# Copy or create kanata.kbd configuration
```

### Step 3: Grant Input Monitoring Permission

1. Run kanata manually first: `sudo /opt/homebrew/bin/kanata -c ~/.config/kanata/kanata.kbd`
2. macOS will prompt for Input Monitoring permission
3. Open **System Settings** → **Privacy & Security** → **Input Monitoring**
4. Add and enable `/opt/homebrew/bin/kanata`

**Important: Use the Homebrew symlink path (`/opt/homebrew/bin/kanata`)**, not the Cellar path. The symlink is stable across `brew upgrade` -- macOS TCC (Input Monitoring) permissions are tied to the binary path. If you grant permission to a Cellar path (e.g., `/opt/homebrew/Cellar/kanata/1.7.0/bin/kanata`) or a copied binary at `/usr/local/bin/kanata`, the permission breaks every time Homebrew upgrades kanata. The `/opt/homebrew/bin/kanata` symlink always points to the current version, so permissions persist across upgrades.

---

## LaunchDaemon Setup

### Plist Files

Create these files in `/Library/LaunchDaemons/`:

#### 1. VirtualHIDDevice Manager

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.example.karabiner-vhidmanager</string>
    <key>ProgramArguments</key>
    <array>
        <string>/Applications/.Karabiner-VirtualHIDDevice-Manager.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Manager</string>
        <string>activate</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
</dict>
</plist>
```

#### 2. VirtualHIDDevice Daemon

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.example.karabiner-vhiddaemon</string>
    <key>ProgramArguments</key>
    <array>
        <string>/Library/Application Support/org.pqrs/Karabiner-DriverKit-VirtualHIDDevice/Applications/Karabiner-VirtualHIDDevice-Daemon.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Daemon</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <true/>
</dict>
</plist>
```

#### 3. Kanata Service

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.example.kanata</string>
    <key>ProgramArguments</key>
    <array>
        <string>/bin/bash</string>
        <string>-c</string>
        <string>sleep 5 &amp;&amp; exec /opt/homebrew/bin/kanata -c /Users/YOUR_USERNAME/.config/kanata/kanata.kbd --port 10000</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <true/>
    <key>ThrottleInterval</key>
    <integer>5</integer>
    <key>StandardOutPath</key>
    <string>/tmp/kanata.out.log</string>
    <key>StandardErrorPath</key>
    <string>/tmp/kanata.err.log</string>
</dict>
</plist>
```

**Important:** Replace `YOUR_USERNAME` with your actual username.

**Design notes:**
- The `sleep 5` delay gives Karabiner DriverKit VirtualHIDDevice time to initialize on boot before kanata tries to connect.
- `KeepAlive` is unconditional (`true`) so launchd restarts kanata regardless of exit code.
- `ThrottleInterval` of 5 seconds prevents rapid restart loops.
- Logs go to `/tmp/` which is cleaned on reboot -- no manual log rotation needed.
- Uses the Homebrew symlink (`/opt/homebrew/bin/kanata`) so TCC Input Monitoring permissions survive `brew upgrade`.

### Set Permissions and Load

```bash
# Fix ownership (CRITICAL - must be root:wheel)
sudo chown root:wheel /Library/LaunchDaemons/com.example.*.plist
sudo chmod 644 /Library/LaunchDaemons/com.example.*.plist

# Load services (in order)
sudo launchctl bootstrap system /Library/LaunchDaemons/com.example.karabiner-vhidmanager.plist
sudo launchctl bootstrap system /Library/LaunchDaemons/com.example.karabiner-vhiddaemon.plist
sudo launchctl bootstrap system /Library/LaunchDaemons/com.example.kanata.plist
```

### Boot Timing

The plist uses a `sleep 5` delay inside a bash wrapper (`/bin/bash -c "sleep 5 && exec ..."`) to give Karabiner DriverKit time to initialize before kanata starts. Combined with unconditional `KeepAlive` and a 5-second `ThrottleInterval`, this handles boot timing reliably without any external wrapper scripts.

**Note:** Earlier versions of this setup used a standalone `/usr/local/bin/kanata-wrapper.sh` script. That approach is **obsolete** -- the inline bash wrapper in the plist replaces it. If you have an old `kanata-wrapper.sh` file, it can be safely deleted.

---

## Layer Reference

### Base Layer - Home Row Modifiers

| Key | Tap | Hold |
|-----|-----|------|
| `A` | a | Left GUI (⌘) |
| `S` | s | Left Alt (⌥) |
| `D` | d | Left Shift (⇧) |
| `F` | f | Left Control (⌃) |
| `J` | j | Right Control (⌃) |
| `K` | k | Right Shift (⇧) |
| `L` | l | Right Alt (⌥) |
| `;` | ; | Right GUI (⌘) |

### Special Keys

| Key | Tap | Hold |
|-----|-----|------|
| `Caps Lock` | Escape | Left Control |
| `Tab` | Tab | Hyper (⌘⌥⇧⌃) |
| `Space` | Space | Symbols Layer |
| `'` | ' (apostrophe) | Numbers Layer |
| `Right Shift` | Backspace | — |
| `Fn` | Fn | Function Layer |

### Symbols Layer (Space Hold)

Optimized for Python/Neovim/CLI with high-frequency symbols on home row.

```
┌─────────────────────────────────────────────────────────────────┐
│                    SYMBOLS LAYER (Space Hold)                   │
├─────────────────────────────────────────────────────────────────┤
│  LEFT HAND                         RIGHT HAND                   │
│  ┌─────┬─────┬─────┬─────┬─────┐  ┌─────┬─────┬─────┬─────┬─────┐│
│  │  !  │  @  │  #  │  $  │  %  │  │  ^  │  &  │  *  │  (  │  )  ││
│  │  q  │  w  │  e  │  r  │  t  │  │  y  │  u  │  i  │  o  │  p  ││
│  ├─────┼─────┼─────┼─────┼─────┤  ├─────┼─────┼─────┼─────┼─────┤│
│  │  {  │  }  │  [  │  ]  │  .  │  │  :  │  =  │  _  │  -  │  |  ││
│  │  a  │  s  │  d  │  f  │  g  │  │  h  │  j  │  k  │  l  │  ;  ││
│  ├─────┼─────┼─────┼─────┼─────┤  ├─────┼─────┼─────┼─────┼─────┤│
│  │  <  │  >  │  "  │  '  │  `  │  │  ~  │  \  │  +  │  ?  │     ││
│  │  z  │  x  │  c  │  v  │  b  │  │  n  │  m  │  ,  │  .  │  /  ││
│  └─────┴─────┴─────┴─────┴─────┘  └─────┴─────┴─────┴─────┴─────┘│
└─────────────────────────────────────────────────────────────────┘
```

**Symbol Mapping:**

| Key | Symbol | Key | Symbol | Key | Symbol |
|-----|--------|-----|--------|-----|--------|
| `q` | `!` | `w` | `@` | `e` | `#` |
| `r` | `$` | `t` | `%` | `y` | `^` |
| `u` | `&` | `i` | `*` | `o` | `(` |
| `p` | `)` | `a` | `{` | `s` | `}` |
| `d` | `[` | `f` | `]` | `g` | `.` |
| `h` | `:` | `j` | `=` | `k` | `_` |
| `l` | `-` | `;` | `\|` | `z` | `<` |
| `x` | `>` | `c` | `"` | `v` | `'` |
| `b` | `` ` `` | `n` | `~` | `m` | `\` |
| `,` | `+` | `.` | `?` | | |

### Numbers Layer (Apostrophe Hold)

Left hand passes through to base layer (letters + home row mods work). Right hand becomes numpad.

```
┌─────────────────────────────────────────────────────────────────┐
│                   NUMBERS LAYER (' Hold)                        │
├─────────────────────────────────────────────────────────────────┤
│  LEFT HAND (transparent)           RIGHT HAND (numpad)          │
│  ┌─────┬─────┬─────┬─────┬─────┐  ┌─────┬─────┬─────┬─────┬─────┐│
│  │  1  │  2  │  3  │  4  │  5  │  │  6  │  7  │  8  │  9  │  +  ││
│  │  q  │  w  │  e  │  r  │  t  │  │  y  │  u  │  i  │  o  │  p  ││
│  ├─────┼─────┼─────┼─────┼─────┤  ├─────┼─────┼─────┼─────┼─────┤│
│  │ (a) │ (s) │ (d) │ (f) │ (g) │  │  0  │  4  │  5  │  6  │  -  ││
│  │pass │thru │base │layer│     │  │  h  │  j  │  k  │  l  │  ;  ││
│  ├─────┼─────┼─────┼─────┼─────┤  ├─────┼─────┼─────┼─────┼─────┤│
│  │     │     │  .  │  +  │     │  │  ,  │  1  │  2  │  3  │  /  ││
│  │  z  │  x  │  c  │  v  │  b  │  │  n  │  m  │  ,  │  .  │  /  ││
│  └─────┴─────┴─────┴─────┴─────┘  └─────┴─────┴─────┴─────┴─────┘│
└─────────────────────────────────────────────────────────────────┘
```

### Function Layer (Fn Hold)

- **F1-F12** on number row
- **Fn + F1** toggles between base and vanilla layers

### Vanilla Layer

A "stock" layer without home row modifiers for gaming or handing keyboard to others. Toggle with **Fn + F1**.

---

## Quick Reference

### Service Management

```bash
# Check status
sudo launchctl list | grep kanata

# Start
sudo launchctl bootstrap system /Library/LaunchDaemons/com.example.kanata.plist

# Stop
sudo launchctl bootout system/com.example.kanata

# Restart (quick - uses KeepAlive)
sudo killall kanata

# Restart (full reload)
sudo launchctl bootout system/com.example.kanata && \
sudo launchctl bootstrap system /Library/LaunchDaemons/com.example.kanata.plist
```

### Logs

```bash
# Live output
tail -f /tmp/kanata.out.log

# Live errors
tail -f /tmp/kanata.err.log

# Recent errors
tail -50 /tmp/kanata.err.log

# Clear logs (they are also cleared automatically on reboot)
rm -f /tmp/kanata.out.log /tmp/kanata.err.log
```

### Configuration

```bash
# Edit config
nvim ~/.config/kanata/kanata.kbd

# Validate syntax
kanata -c ~/.config/kanata/kanata.kbd --check

# Test manually (Ctrl+C to stop)
sudo kanata -c ~/.config/kanata/kanata.kbd -d

# Apply changes
sudo killall kanata
```

### Diagnostics

```bash
# Check kanata process
ps aux | grep kanata | grep -v grep

# Check port 10000
sudo lsof -i :10000

# View service details
sudo launchctl print system/com.example.kanata

# Check VirtualHID services
sudo launchctl list | grep vhid
```

### Service Status Codes

```
PID    STATUS  NAME
12345  0       com.example.kanata     ← Running, healthy
-      0       com.example.kanata     ← Loaded but not running
12345  -6      com.example.kanata     ← Error (check logs)
```

---

## Troubleshooting

### Keys Not Remapping

```bash
# 1. Check if kanata is running
sudo launchctl list | grep kanata

# 2. Check driver connection
tail -50 /tmp/kanata.out.log | grep "driver connected"
# Should see: driver connected: true

# 3. Check for errors
tail -50 /tmp/kanata.err.log

# 4. Verify VirtualHIDDevice services
sudo launchctl list | grep vhid
```

### "IOHIDDeviceOpen error: not permitted"

Missing Input Monitoring permission.

1. **System Settings** → **Privacy & Security** → **Input Monitoring**
2. Add `/opt/homebrew/bin/kanata` (click + and navigate to it)
3. Enable the toggle
4. Restart: `sudo launchctl bootout system/com.example.kanata && sudo launchctl bootstrap system /Library/LaunchDaemons/com.example.kanata.plist`

**Note:** Always grant permission to the Homebrew symlink at `/opt/homebrew/bin/kanata`, not to the Cellar path. See [Step 3: Grant Input Monitoring Permission](#step-3-grant-input-monitoring-permission) for details.

### "Address already in use" (Port 10000)

Multiple kanata instances or duplicate services.

```bash
# Find what's using port 10000
sudo lsof -i :10000

# Check for duplicates
sudo launchctl list | grep kanata
ls /Library/LaunchDaemons/*kanata*.plist

# Kill all and reload single service
sudo killall kanata
sudo launchctl bootout system/com.example.kanata
sudo launchctl bootstrap system /Library/LaunchDaemons/com.example.kanata.plist
```

### "Input/output error 5" When Loading

Incorrect file ownership.

```bash
sudo chown root:wheel /Library/LaunchDaemons/com.example.kanata.plist
sudo launchctl bootstrap system /Library/LaunchDaemons/com.example.kanata.plist
```

### Karabiner Elements Conflict

Karabiner Elements (full app) conflicts with Kanata. Uninstall the app but KEEP VirtualHIDDevice:

```bash
# Remove Karabiner Elements apps
sudo rm -rf "/Applications/Karabiner-Elements.app"
sudo rm -rf "/Applications/Karabiner-EventViewer.app"
sudo rm -rf "/Library/Application Support/org.pqrs/Karabiner-Elements"

# DO NOT remove VirtualHIDDevice components
```

### Not Working After Update

If the plist uses the Homebrew symlink (`/opt/homebrew/bin/kanata`), upgrades should work automatically -- the symlink points to the new version, and TCC permissions persist.

```bash
# 1. Verify symlink still resolves
ls -la /opt/homebrew/bin/kanata

# 2. Restart kanata (KeepAlive handles this, but for a clean restart)
sudo launchctl bootout system/com.example.kanata
sudo launchctl bootstrap system /Library/LaunchDaemons/com.example.kanata.plist

# 3. Check logs if issues occur
tail -50 /tmp/kanata.err.log
```

### Troubleshooting Checklist

- [ ] Karabiner-DriverKit-VirtualHIDDevice installed
- [ ] System extension approved in System Settings
- [ ] VirtualHIDDevice services running
- [ ] Kanata Homebrew symlink exists at `/opt/homebrew/bin/kanata`
- [ ] Config file valid (`kanata --check`)
- [ ] `/opt/homebrew/bin/kanata` has Input Monitoring permission (not Cellar path)
- [ ] Plist ownership is `root:wheel`
- [ ] Plist uses `/opt/homebrew/bin/kanata` (Homebrew symlink, not Cellar path)
- [ ] Plist has `sleep 5` delay for boot timing
- [ ] No duplicate kanata services
- [ ] Port 10000 not in use by another process
- [ ] No Karabiner Elements (full app) installed

### Emergency Reset

```bash
# 1. Kill everything
sudo killall kanata
sudo launchctl bootout system/com.example.kanata

# 2. Check for issues
kanata -c ~/.config/kanata/kanata.kbd --check

# 3. View errors
tail -50 /tmp/kanata.err.log

# 4. Reload
sudo launchctl bootstrap system /Library/LaunchDaemons/com.example.kanata.plist
```

---

## Maintenance

### Updating Kanata

```bash
brew upgrade kanata

# Verify Homebrew symlink still resolves
ls -la /opt/homebrew/bin/kanata

# Restart kanata to pick up the new version
sudo launchctl bootout system/com.example.kanata
sudo launchctl bootstrap system /Library/LaunchDaemons/com.example.kanata.plist
```

Because the plist and TCC permissions both reference the stable Homebrew symlink (`/opt/homebrew/bin/kanata`), you should **not** need to re-grant Input Monitoring after upgrades. If kanata fails to start after an upgrade, check `/tmp/kanata.err.log`.

### Editing Configuration

```bash
# 1. Edit
nvim ~/.config/kanata/kanata.kbd

# 2. Validate
kanata -c ~/.config/kanata/kanata.kbd --check

# 3. Reload (KeepAlive auto-restarts)
sudo killall kanata
```

### Log Rotation

Logs are stored in `/tmp/` which is cleared on every reboot, so manual rotation is rarely needed.

```bash
# Check sizes
du -sh /tmp/kanata.*.log

# Clear logs manually if needed (service recreates them)
rm -f /tmp/kanata.out.log /tmp/kanata.err.log
```

### Adding New Keyboards

Find device names:
```bash
kanata --list
```

Add to config:
```lisp
(defcfg
  macos-dev-names-include (
    "Apple Internal Keyboard / Trackpad"
    "MX MCHNCL M"
    "Your New Keyboard Name"
  )
)
```

---

## Customization Tips

### Adjusting Timing

If experiencing misfires:
```lisp
(defvar
  tap-time 200    ;; Increase if taps register as holds (150-250ms)
  hold-time 230   ;; Increase if holds register as taps (200-300ms)
)
```

Keep `hold-time` > `tap-time`.

### Adding Combos

For instant symbol access without layers:
```lisp
(defcfg
  process-unmapped-keys yes
  concurrent-tap-hold yes
  chords-v2-min-idle 50
)

(defchords base 50
  (d f) (macro S-9 S-0 left)    ;; d+f = () with cursor inside
  (j k) S-\                      ;; j+k = |
)
```

### Symbol Key Codes

| Code | Symbol | Code | Symbol |
|------|--------|------|--------|
| `S-1` | ! | `S-2` | @ |
| `S-3` | # | `S-4` | $ |
| `S-5` | % | `S-6` | ^ |
| `S-7` | & | `S-8` | * |
| `S-9` | ( | `S-0` | ) |
| `S-[` | { | `S-]` | } |
| `S-\` | \| | `S-;` | : |
| `S-'` | " | `S--` | _ |
| `S-=` | + | `S-grv` | ~ |
| `grv` | ` | | |

---

## Resources

- [Kanata GitHub](https://github.com/jtroo/kanata)
- [Configuration Guide](https://github.com/jtroo/kanata/blob/main/docs/config.adoc)
- [macOS Setup Discussion](https://github.com/jtroo/kanata/discussions/1537)
- [Karabiner-DriverKit-VirtualHIDDevice](https://github.com/pqrs-org/Karabiner-DriverKit-VirtualHIDDevice)
