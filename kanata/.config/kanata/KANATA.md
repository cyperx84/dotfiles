# Kanata Configuration for macOS

> **Version:** 1.1 | **Last Updated:** December 2024 | **macOS:** Sequoia 15.x | **Kanata:** 1.7.0+

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
  /Library/Logs/Kanata/
    kanata.out.log                      # Info/debug output
    kanata.err.log                      # Errors and panics

Binaries:
  /usr/local/bin/kanata                 # Kanata executable

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

1. Run kanata manually first: `sudo kanata -c ~/.config/kanata/kanata.kbd`
2. macOS will prompt for Input Monitoring permission
3. Open **System Settings** → **Privacy & Security** → **Input Monitoring**
4. Enable the toggle for kanata

**Note:** Each kanata version installs to a different path. After `brew upgrade kanata`, re-add the new binary to Input Monitoring.

### Step 4: Create Log Directory

```bash
sudo mkdir -p /Library/Logs/Kanata
sudo chmod 755 /Library/Logs/Kanata
```

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
        <string>/usr/local/bin/kanata</string>
        <string>-c</string>
        <string>/Users/YOUR_USERNAME/.config/kanata/kanata.kbd</string>
        <string>--port</string>
        <string>10000</string>
        <string>--debug</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <true/>
    <key>StandardOutPath</key>
    <string>/Library/Logs/Kanata/kanata.out.log</string>
    <key>StandardErrorPath</key>
    <string>/Library/Logs/Kanata/kanata.err.log</string>
</dict>
</plist>
```

**Important:** Replace `YOUR_USERNAME` with your actual username.

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

### Boot Timing Fix (Optional)

If kanata fails on boot because VirtualHIDDevice isn't ready, create a wrapper script:

**Create `/usr/local/bin/kanata-wrapper.sh`:**

```bash
#!/bin/bash
MAX_WAIT=30
SLEEP_INTERVAL=2

echo "[$(date)] Waiting for Karabiner-VirtualHIDDevice driver..."

for i in $(seq 1 $MAX_WAIT); do
    if pgrep -f "Karabiner-VirtualHIDDevice-Daemon" >/dev/null 2>&1; then
        echo "[$(date)] VirtualHIDDevice daemon detected, waiting ${SLEEP_INTERVAL}s..."
        sleep $SLEEP_INTERVAL
        echo "[$(date)] Starting kanata..."
        exec /usr/local/bin/kanata "$@"
    fi
    sleep 1
done

echo "[$(date)] ERROR: VirtualHIDDevice driver not ready after ${MAX_WAIT}s"
exit 1
```

```bash
sudo chmod +x /usr/local/bin/kanata-wrapper.sh
```

Then update the plist to use `/usr/local/bin/kanata-wrapper.sh` instead of `/usr/local/bin/kanata`.

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
sudo tail -f /Library/Logs/Kanata/kanata.out.log

# Live errors
sudo tail -f /Library/Logs/Kanata/kanata.err.log

# Recent errors
sudo tail -50 /Library/Logs/Kanata/kanata.err.log

# Clear logs
sudo rm /Library/Logs/Kanata/*.log
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
sudo tail -50 /Library/Logs/Kanata/kanata.out.log | grep "driver connected"
# Should see: driver connected: true

# 3. Check for errors
sudo tail -50 /Library/Logs/Kanata/kanata.err.log

# 4. Verify VirtualHIDDevice services
sudo launchctl list | grep vhid
```

### "IOHIDDeviceOpen error: not permitted"

Missing Input Monitoring permission.

1. **System Settings** → **Privacy & Security** → **Input Monitoring**
2. Add `/usr/local/bin/kanata` (click + and navigate)
3. Enable the toggle
4. Restart: `sudo launchctl bootout system/com.example.kanata && sudo launchctl bootstrap system /Library/LaunchDaemons/com.example.kanata.plist`

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

```bash
# 1. Check new binary location
which kanata

# 2. Update plist if path changed
sudo nvim /Library/LaunchDaemons/com.example.kanata.plist

# 3. Grant Input Monitoring permission to new binary

# 4. Reload
sudo launchctl bootout system/com.example.kanata
sudo launchctl bootstrap system /Library/LaunchDaemons/com.example.kanata.plist
```

### Troubleshooting Checklist

- [ ] Karabiner-DriverKit-VirtualHIDDevice installed
- [ ] System extension approved in System Settings
- [ ] VirtualHIDDevice services running
- [ ] Kanata binary exists at `/usr/local/bin/kanata`
- [ ] Config file valid (`kanata --check`)
- [ ] Kanata has Input Monitoring permission
- [ ] Plist ownership is `root:wheel`
- [ ] Plist paths to config and binary are correct
- [ ] Log directory exists and is writable
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
sudo tail -50 /Library/Logs/Kanata/kanata.err.log

# 4. Reload
sudo launchctl bootstrap system /Library/LaunchDaemons/com.example.kanata.plist
```

---

## Maintenance

### Updating Kanata

```bash
brew upgrade kanata

# Check new path
which kanata

# Update plist if needed, then reload
sudo launchctl bootout system/com.example.kanata
sudo launchctl bootstrap system /Library/LaunchDaemons/com.example.kanata.plist

# Re-grant Input Monitoring if prompted
```

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

```bash
# Check sizes
sudo du -sh /Library/Logs/Kanata/*

# Clear logs (service recreates them)
sudo rm /Library/Logs/Kanata/*.log
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
