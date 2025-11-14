# Kanata Setup Guide for macOS

A comprehensive guide for setting up and troubleshooting Kanata keyboard remapping on macOS.

## Table of Contents

- [Overview](#overview)
- [Architecture](#architecture)
- [Installation](#installation)
- [LaunchDaemon Setup](#launchdaemon-setup)
- [Common Issues & Solutions](#common-issues--solutions)
- [Troubleshooting](#troubleshooting)
- [Maintenance](#maintenance)
- [References](#references)

---

## Overview

### What is Kanata?

Kanata is a powerful, cross-platform keyboard remapping tool written in Rust. It allows you to:
- Remap keys at a low level (before they reach applications)
- Create sophisticated key combinations and layers
- Define custom behaviors like tap-hold, chords, and macros
- Run custom shell commands from key presses

### Why Kanata on macOS?

Unlike other remapping tools on macOS:
- **Low-level interception**: Works at the HID device level
- **Complex remapping**: Supports advanced features like layers, tap-hold, and chords
- **Text editor friendly**: Portable configuration in a simple text format
- **No GUI overhead**: Runs as a system daemon with minimal resource usage

---

## Architecture

### Components

Kanata on macOS requires several components working together:

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

### 1. Karabiner-DriverKit-VirtualHIDDevice

This is a kernel extension that provides:
- A virtual HID (Human Interface Device) keyboard/mouse
- Low-level access to physical keyboard events
- Ability to inject synthetic keyboard events

**Why needed?** macOS sandboxing prevents user-space programs from directly intercepting keyboard events. This driver provides the necessary bridge.

### 2. VirtualHIDDevice Manager & Daemon

Two LaunchDaemons that manage the DriverKit extension:
- **Manager**: Activates the virtual HID device
- **Daemon**: Maintains communication with the driver

### 3. Kanata

The main remapping engine:
- Reads your configuration file (`kanata.kbd`)
- Intercepts keyboard events via the virtual HID device
- Applies your remapping rules
- Sends transformed events back to the system
- Optionally exposes a TCP server for debugging/monitoring

---

## Installation

### Prerequisites

- macOS 10.15 (Catalina) or later
- Homebrew package manager
- Administrator (sudo) access

### Step 1: Install Karabiner-DriverKit-VirtualHIDDevice

```bash
brew install --cask karabiner-driverkit-virtualhiddevice
```

**Note**: You may need to approve the system extension in System Settings:
1. Open **System Settings** → **Privacy & Security**
2. Look for a message about blocked system extension
3. Click **Allow** and restart if prompted

### Step 2: Install Kanata

```bash
brew install kanata
```

This installs the kanata binary to `/usr/local/bin/kanata`.

### Step 3: Create Configuration Directory

```bash
mkdir -p ~/.config/kanata
```

### Step 4: Create or Copy Your Configuration

Create `~/.config/kanata/kanata.kbd` with your key mappings.

**Basic example**:
```lisp
(defsrc
  caps a s d f
)

(deflayer default
  lctl a s d f
)
```

This simple config remaps Caps Lock to Left Control.

### Step 5: Grant Input Monitoring Permission

Kanata requires permission to monitor keyboard input:

1. Run kanata manually first: `sudo kanata -c ~/.config/kanata/kanata.kbd`
2. macOS will prompt for Input Monitoring permission
3. Open **System Settings** → **Privacy & Security** → **Input Monitoring**
4. Enable the toggle for kanata (or the terminal you ran it from)

**Important**: Each version of kanata gets installed to a different directory. When you update kanata via Homebrew, you'll need to:
1. Re-add the new kanata binary path to Input Monitoring
2. Remove the old one (optional, but keeps things clean)

---

## LaunchDaemon Setup

LaunchDaemons run services automatically at system boot with root privileges.

### File Locations

All plist files go in `/Library/LaunchDaemons/`:
- `com.example.karabiner-vhidmanager.plist`
- `com.example.karabiner-vhiddaemon.plist`
- `com.example.kanata.plist`

### Creating the Plist Files

#### 1. VirtualHIDDevice Manager

Create `/Library/LaunchDaemons/com.example.karabiner-vhidmanager.plist`:

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

Create `/Library/LaunchDaemons/com.example.karabiner-vhiddaemon.plist`:

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

Create `/Library/LaunchDaemons/com.example.kanata.plist`:

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

**Important**: Replace `YOUR_USERNAME` with your actual username.

### Understanding the Kanata Plist

- **Label**: Unique identifier for the service
- **ProgramArguments**: Command to run (kanata with arguments)
  - `-c`: Path to configuration file
  - `--port 10000`: TCP server port for monitoring/debugging
  - `--debug`: Enable debug logging
- **RunAtLoad**: Start service when loaded (at boot)
- **KeepAlive**: Restart if crashes
- **StandardOutPath/StandardErrorPath**: Log file locations

### Setting File Permissions

**Critical**: LaunchDaemon plist files MUST be owned by root:

```bash
sudo chown root:wheel /Library/LaunchDaemons/com.example.*.plist
sudo chmod 644 /Library/LaunchDaemons/com.example.*.plist
```

Common issues arise when files are owned by your user account instead of root.

### Creating Log Directory

```bash
sudo mkdir -p /Library/Logs/Kanata
sudo chmod 755 /Library/Logs/Kanata
```

### Loading the Services

Load services in this order:

```bash
# 1. Load VirtualHIDDevice services (they may already be loaded)
sudo launchctl bootstrap system /Library/LaunchDaemons/com.example.karabiner-vhidmanager.plist
sudo launchctl bootstrap system /Library/LaunchDaemons/com.example.karabiner-vhiddaemon.plist

# 2. Load Kanata
sudo launchctl bootstrap system /Library/LaunchDaemons/com.example.kanata.plist
```

**Note**: If you get an error about services already being loaded, that's okay. The VirtualHIDDevice services may have been loaded by the installer.

### Managing Services

```bash
# Check service status
sudo launchctl list | grep -E "(kanata|karabiner)"

# View service details
sudo launchctl print system/com.example.kanata

# Unload a service
sudo launchctl bootout system/com.example.kanata

# Reload a service (after editing config)
sudo launchctl bootout system/com.example.kanata
sudo launchctl bootstrap system /Library/LaunchDaemons/com.example.kanata.plist
```

---

## Common Issues & Solutions

### Issue 1: "IOHIDDeviceOpen error: not permitted"

**Symptom**: Kanata fails to start with permission error in logs.

**Cause**: Missing Input Monitoring permission.

**Solution**:
1. Open **System Settings** → **Privacy & Security** → **Input Monitoring**
2. Find kanata in the list (you may need to click the + button and navigate to `/usr/local/bin/kanata`)
3. Enable the toggle
4. Restart the kanata service:
   ```bash
   sudo launchctl bootout system/com.example.kanata
   sudo launchctl bootstrap system /Library/LaunchDaemons/com.example.kanata.plist
   ```

### Issue 2: "Address already in use" (Port 10000 conflict)

**Symptom**: Kanata crashes repeatedly with "TCP server starts: Os { code: 48, kind: AddrInUse }"

**Cause**: Multiple kanata instances running, or duplicate LaunchDaemon configs.

**Solution**:
1. Check for duplicate services:
   ```bash
   sudo launchctl list | grep kanata
   ```
2. Check for multiple plist files:
   ```bash
   ls /Library/LaunchDaemons/*kanata*.plist
   ```
3. Kill all kanata processes:
   ```bash
   sudo killall kanata
   ```
4. Remove duplicate plist files:
   ```bash
   sudo rm /Library/LaunchDaemons/DUPLICATE_FILE.plist
   ```
5. Unload all kanata services and reload only one:
   ```bash
   sudo launchctl bootout system/com.example.kanata
   sudo launchctl bootstrap system /Library/LaunchDaemons/com.example.kanata.plist
   ```

### Issue 3: "Input/output error 5" when loading LaunchDaemon

**Symptom**: `Bootstrap failed: 5: Input/output error` when loading plist.

**Cause**: Incorrect file ownership (not owned by root).

**Solution**:
```bash
sudo chown root:wheel /Library/LaunchDaemons/com.example.kanata.plist
sudo launchctl bootstrap system /Library/LaunchDaemons/com.example.kanata.plist
```

### Issue 4: Karabiner Elements Conflict

**Symptom**: Kanata doesn't work properly, or keys behave unexpectedly.

**Cause**: Karabiner Elements (full application) conflicts with Kanata. Both try to intercept keyboard events.

**Solution**: Uninstall Karabiner Elements (the full app), but KEEP the VirtualHIDDevice driver.

```bash
# Remove Karabiner Elements apps
sudo rm -rf "/Applications/Karabiner-Elements.app"
sudo rm -rf "/Applications/Karabiner-EventViewer.app"

# Remove Elements support files
sudo rm -rf "/Library/Application Support/org.pqrs/Karabiner-Elements"

# Unload karabiner_grabber service if running
sudo launchctl bootout system/org.pqrs.service.daemon.karabiner_grabber

# DO NOT remove VirtualHIDDevice components:
# - /Applications/.Karabiner-VirtualHIDDevice-Manager.app
# - /Library/Application Support/org.pqrs/Karabiner-DriverKit-VirtualHIDDevice
```

### Issue 5: Kanata Not Starting After Update

**Symptom**: After `brew upgrade kanata`, the service doesn't work.

**Cause**: New kanata version installed to different path, needs new Input Monitoring permission.

**Solution**:
1. Check the new binary location:
   ```bash
   which kanata
   ```
2. Update the plist file with the new path if it changed
3. Add the new binary to Input Monitoring permissions
4. Reload the service:
   ```bash
   sudo launchctl bootout system/com.example.kanata
   sudo launchctl bootstrap system /Library/LaunchDaemons/com.example.kanata.plist
   ```

### Issue 6: Service Running but Keys Not Remapped

**Symptom**: `launchctl list` shows kanata running, but keys aren't remapped.

**Diagnostic Steps**:
1. Check if the driver is connected:
   ```bash
   sudo tail -50 /Library/Logs/Kanata/kanata.out.log | grep "driver connected"
   ```
   Should see: `driver connected: true`

2. Check for config errors:
   ```bash
   sudo tail -100 /Library/Logs/Kanata/kanata.err.log
   ```

3. Verify the config file is valid:
   ```bash
   kanata -c ~/.config/kanata/kanata.kbd --check
   ```

4. Check VirtualHIDDevice services:
   ```bash
   sudo launchctl list | grep vhid
   ```
   Should see both vhidmanager and vhiddaemon running.

---

## Troubleshooting

### Diagnostic Commands

#### Check Service Status

```bash
# List all kanata and karabiner services
sudo launchctl list | grep -E "(kanata|karabiner)"

# Expected output (healthy system):
# 12345  0  com.example.kanata                      (PID and exit code 0)
# -      0  com.example.karabiner-vhidmanager      (no PID, runs once)
# 67890  0  com.example.karabiner-vhiddaemon       (PID and exit code 0)
```

Exit codes:
- `0`: Running successfully
- `-6`: Service failed (check logs)
- `-`: Service ran and completed (expected for vhidmanager)

#### Check Running Processes

```bash
# Find kanata processes
ps aux | grep kanata | grep -v grep

# Expected: One kanata process owned by root
```

#### View Logs

```bash
# View output log (info and debug messages)
sudo tail -f /Library/Logs/Kanata/kanata.out.log

# View error log (errors and panics)
sudo tail -f /Library/Logs/Kanata/kanata.err.log

# Search for common errors
sudo grep -i "error\|panic\|failed" /Library/Logs/Kanata/kanata.err.log | tail -20
```

#### Test Configuration

```bash
# Check config syntax
kanata -c ~/.config/kanata/kanata.kbd --check

# Run kanata manually (for testing)
sudo kanata -c ~/.config/kanata/kanata.kbd -d

# Stop with Ctrl+C when done testing
```

#### Check Port Conflicts

```bash
# See what's using port 10000
sudo lsof -i :10000

# Expected: One kanata process
```

#### Verify Driver Status

```bash
# Check if VirtualHIDDevice is loaded
system_profiler SPExtensionsDataType | grep -i karabiner
```

### Complete Reset Procedure

If everything is broken and you want to start fresh:

```bash
# 1. Stop all services
sudo launchctl bootout system/com.example.kanata
sudo killall kanata

# 2. Remove plist files
sudo rm /Library/LaunchDaemons/com.example.kanata.plist

# 3. Clear logs
sudo rm -rf /Library/Logs/Kanata/*

# 4. Reinstall kanata
brew uninstall kanata
brew install kanata

# 5. Follow installation steps from the beginning
```

---

## Maintenance

### Updating Kanata

```bash
# Update via Homebrew
brew upgrade kanata

# Verify new version
kanata --version

# Update plist if binary path changed
# Check current path
which kanata

# Restart service
sudo launchctl bootout system/com.example.kanata
sudo launchctl bootstrap system /Library/LaunchDaemons/com.example.kanata.plist

# Don't forget to grant Input Monitoring permission to the new binary
```

### Editing Configuration

After editing `~/.config/kanata/kanata.kbd`:

```bash
# Test the config first
kanata -c ~/.config/kanata/kanata.kbd --check

# If valid, reload the service
sudo launchctl bootout system/com.example.kanata
sudo launchctl bootstrap system /Library/LaunchDaemons/com.example.kanata.plist

# Or, if you set KeepAlive to true, you can just kill the process:
sudo killall kanata
# It will automatically restart with new config
```

### Log Rotation

The log files can grow large over time:

```bash
# Check log sizes
sudo du -sh /Library/Logs/Kanata/*

# Clear logs
sudo rm /Library/Logs/Kanata/*.log

# Service will recreate them automatically
```

### Backup Configuration

```bash
# Backup your config
cp ~/.config/kanata/kanata.kbd ~/dotfiles/kanata/.config/kanata/

# Backup LaunchDaemon plists
sudo cp /Library/LaunchDaemons/com.example.kanata.plist ~/dotfiles/kanata/
sudo cp /Library/LaunchDaemons/com.example.karabiner-*.plist ~/dotfiles/kanata/
```

---

## References

### Documentation

- [Kanata GitHub Repository](https://github.com/jtroo/kanata)
- [Kanata Configuration Guide](https://github.com/jtroo/kanata/blob/main/docs/config.adoc)
- [Karabiner-DriverKit-VirtualHIDDevice](https://github.com/pqrs-org/Karabiner-DriverKit-VirtualHIDDevice)
- [macOS LaunchDaemon Documentation](https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/BPSystemStartup/Chapters/CreatingLaunchdJobs.html)

### Key GitHub Discussions

- [Kanata Setup on macOS Sequoia](https://github.com/jtroo/kanata/discussions/1537) - Comprehensive setup guide
- [Input Monitoring Permissions](https://github.com/jtroo/kanata/discussions/130)
- [macOS Troubleshooting](https://github.com/jtroo/kanata/discussions?discussions_q=macos)

### Useful Commands Reference

```bash
# Service Management
sudo launchctl list | grep kanata                    # Check service status
sudo launchctl bootstrap system /path/to/file.plist  # Load service
sudo launchctl bootout system/service.name           # Unload service
sudo launchctl print system/service.name             # View service details

# Debugging
sudo tail -f /Library/Logs/Kanata/kanata.out.log    # Watch output log
sudo tail -f /Library/Logs/Kanata/kanata.err.log    # Watch error log
ps aux | grep kanata                                 # Find processes
sudo lsof -i :10000                                  # Check port usage
sudo killall kanata                                  # Kill all instances

# Permissions
sudo chown root:wheel /Library/LaunchDaemons/*.plist # Fix ownership
sudo chmod 644 /Library/LaunchDaemons/*.plist        # Fix permissions

# Testing
kanata -c ~/.config/kanata/kanata.kbd --check       # Validate config
sudo kanata -c ~/.config/kanata/kanata.kbd -d       # Run manually with debug
```

---

## Appendix: Understanding LaunchDaemons

### LaunchDaemon vs LaunchAgent

- **LaunchDaemon**: Runs as root, starts at boot, no user login required
  - Location: `/Library/LaunchDaemons/`
  - Use for: System services that need root access (like kanata)

- **LaunchAgent**: Runs as user, starts at login
  - Location: `~/Library/LaunchAgents/`
  - Use for: User-level services without root privileges

### Plist Key Reference

| Key | Type | Description |
|-----|------|-------------|
| `Label` | String | Unique identifier (reverse DNS notation) |
| `ProgramArguments` | Array | Command and arguments to execute |
| `RunAtLoad` | Boolean | Start when loaded (at boot) |
| `KeepAlive` | Boolean | Restart if crashes |
| `StandardOutPath` | String | Path for stdout output |
| `StandardErrorPath` | String | Path for stderr output |
| `WorkingDirectory` | String | Directory to run from (optional) |
| `EnvironmentVariables` | Dict | Environment variables (optional) |

### Service States

```bash
sudo launchctl print system/com.example.kanata
```

Key fields:
- `state = running`: Service is active
- `state = not running`: Service stopped (check logs)
- `pid = 12345`: Process ID (useful for debugging)
- `last exit code = 0`: Clean exit (non-zero means error)

---

## Troubleshooting Checklist

If kanata isn't working, check these in order:

- [ ] Karabiner-DriverKit-VirtualHIDDevice is installed
- [ ] System extension is approved in System Settings
- [ ] VirtualHIDDevice services are loaded and running
- [ ] Kanata binary exists at `/usr/local/bin/kanata`
- [ ] Config file exists and is valid (`kanata --check`)
- [ ] Kanata has Input Monitoring permission
- [ ] Plist file ownership is `root:wheel`
- [ ] Plist file path to config and binary are correct
- [ ] Log directory exists and is writable
- [ ] No duplicate kanata services running
- [ ] Port 10000 is not in use by another process
- [ ] No Karabiner Elements (full app) installed
- [ ] Check error logs for specific errors

---

**Last Updated**: November 2024
**Tested On**: macOS Sequoia (15.x)
**Kanata Version**: 1.7.0+

---

## Appendix: Boot Timing Fix

### Problem

After a restart, kanata may fail to start initially because it tries to connect before the VirtualHIDDevice driver is fully activated. The service eventually works (via KeepAlive restarts), but shows exit code 1.

### Solution: Startup Wrapper Script

A wrapper script that waits for the driver before starting kanata.

**1. Create `/usr/local/bin/kanata-wrapper.sh`:**

```bash
#!/bin/bash
# Kanata startup wrapper - waits for VirtualHIDDevice driver to be ready

MAX_WAIT=30  # Maximum seconds to wait
SLEEP_INTERVAL=2

echo "[$(date)] Waiting for Karabiner-VirtualHIDDevice driver..."

# Wait for driver to be available
for i in $(seq 1 $MAX_WAIT); do
    # Check if the VirtualHIDDevice daemon is running
    if pgrep -f "Karabiner-VirtualHIDDevice-Daemon" >/dev/null 2>&1; then
        echo "[$(date)] VirtualHIDDevice daemon detected, waiting ${SLEEP_INTERVAL}s for activation..."
        sleep $SLEEP_INTERVAL
        echo "[$(date)] Starting kanata..."
        exec /usr/local/bin/kanata "$@"
    fi

    if [ $i -eq 1 ]; then
        echo "[$(date)] Driver not ready yet, waiting..."
    fi

    sleep 1
done

echo "[$(date)] ERROR: VirtualHIDDevice driver not ready after ${MAX_WAIT}s"
exit 1
```

**2. Make it executable:**

```bash
sudo chmod +x /usr/local/bin/kanata-wrapper.sh
```

**3. Update the plist to use the wrapper:**

Edit `/Library/LaunchDaemons/com.example.kanata.plist` and change:

```xml
<string>/usr/local/bin/kanata</string>
```

to:

```xml
<string>/usr/local/bin/kanata-wrapper.sh</string>
```

**4. Reload the service:**

```bash
sudo launchctl bootout system/com.example.kanata
sudo launchctl bootstrap system /Library/LaunchDaemons/com.example.kanata.plist
```

Now kanata will wait for the driver to be ready at boot, preventing initial startup failures.

