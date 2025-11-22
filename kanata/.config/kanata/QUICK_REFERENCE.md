# Kanata Quick Reference

A cheat sheet for common kanata commands and troubleshooting on macOS.

## Essential Commands

### Service Management

```bash
# Check if kanata is running
sudo launchctl list | grep kanata

# Start kanata service
sudo launchctl bootstrap system /Library/LaunchDaemons/com.example.kanata.plist

# Stop kanata service
sudo launchctl bootout system/com.example.kanata

# Restart kanata (quick method)
sudo killall kanata  # Auto-restarts due to KeepAlive

# Restart kanata (full reload)
sudo launchctl bootout system/com.example.kanata && \
sudo launchctl bootstrap system /Library/LaunchDaemons/com.example.kanata.plist
```

### Logs

```bash
# View live output log
sudo tail -f /Library/Logs/Kanata/kanata.out.log

# View live error log
sudo tail -f /Library/Logs/Kanata/kanata.err.log

# Check recent errors
sudo tail -50 /Library/Logs/Kanata/kanata.err.log

# Search for specific error
sudo grep -i "error_term" /Library/Logs/Kanata/kanata.err.log

# Clear logs
sudo rm /Library/Logs/Kanata/*.log
```

### Configuration

```bash
# Edit config
nvim ~/.config/kanata/kanata.kbd

# Validate config syntax
kanata -c ~/.config/kanata/kanata.kbd --check

# Test config manually (Ctrl+C to stop)
sudo kanata -c ~/.config/kanata/kanata.kbd -d

# Apply changes (restart service)
sudo killall kanata
```

### Diagnostics

```bash
# Run full health check
~/dotfiles/kanata/kanata-check.sh

# Run with detailed output
~/dotfiles/kanata/kanata-check.sh --verbose

# Check which process is using port 10000
sudo lsof -i :10000

# Check kanata process
ps aux | grep kanata | grep -v grep

# View service details
sudo launchctl print system/com.example.kanata
```

## Common Issues

### Issue: Keys Not Remapping

```bash
# 1. Check if kanata is running
sudo launchctl list | grep kanata
ps aux | grep kanata | grep -v grep

# 2. Check driver connection
sudo tail -50 /Library/Logs/Kanata/kanata.out.log | grep "driver connected"
# Should see: driver connected: true

# 3. Check for errors
sudo tail -50 /Library/Logs/Kanata/kanata.err.log

# 4. Verify VirtualHIDDevice services
sudo launchctl list | grep vhid
```

### Issue: "Address already in use" Error

```bash
# 1. Find what's using port 10000
sudo lsof -i :10000

# 2. Check for duplicate services
sudo launchctl list | grep kanata
ls /Library/LaunchDaemons/*kanata*.plist

# 3. Kill all kanata processes
sudo killall kanata

# 4. Remove duplicate plists
sudo rm /Library/LaunchDaemons/DUPLICATE.plist

# 5. Reload single service
sudo launchctl bootout system/com.example.kanata
sudo launchctl bootstrap system /Library/LaunchDaemons/com.example.kanata.plist
```

### Issue: "IOHIDDeviceOpen error: not permitted"

```bash
# Grant Input Monitoring permission:
# System Settings → Privacy & Security → Input Monitoring
# Enable toggle for: /usr/local/bin/kanata

# Then restart service
sudo launchctl bootout system/com.example.kanata
sudo launchctl bootstrap system /Library/LaunchDaemons/com.example.kanata.plist
```

### Issue: "Input/output error 5" When Loading

```bash
# Fix file ownership
sudo chown root:wheel /Library/LaunchDaemons/com.example.kanata.plist
sudo chmod 644 /Library/LaunchDaemons/com.example.kanata.plist

# Try loading again
sudo launchctl bootstrap system /Library/LaunchDaemons/com.example.kanata.plist
```

### Issue: Service Won't Start

```bash
# 1. Check plist file exists and is valid
ls -l /Library/LaunchDaemons/com.example.kanata.plist

# 2. Verify ownership
stat -f "%Su:%Sg" /Library/LaunchDaemons/com.example.kanata.plist
# Should be: root:wheel (or root:*)

# 3. Check config file exists
ls -l ~/.config/kanata/kanata.kbd

# 4. Validate config
kanata -c ~/.config/kanata/kanata.kbd --check

# 5. Check log directory exists
ls -ld /Library/Logs/Kanata

# 6. Try loading with verbose error
sudo launchctl bootstrap system /Library/LaunchDaemons/com.example.kanata.plist 2>&1
```

### Issue: After Updating Kanata

```bash
# 1. Check new binary location
which kanata

# 2. Update plist if path changed
sudo nvim /Library/LaunchDaemons/com.example.kanata.plist

# 3. Grant Input Monitoring permission for new binary
# System Settings → Privacy & Security → Input Monitoring

# 4. Reload service
sudo launchctl bootout system/com.example.kanata
sudo launchctl bootstrap system /Library/LaunchDaemons/com.example.kanata.plist
```

## File Locations

```
Configuration:
  ~/.config/kanata/kanata.kbd           Main configuration file

LaunchDaemons:
  /Library/LaunchDaemons/
    com.example.kanata.plist            Kanata service
    com.example.karabiner-vhid*.plist   VirtualHID services

Logs:
  /Library/Logs/Kanata/
    kanata.out.log                      Info/debug output
    kanata.err.log                      Errors and panics

Binaries:
  /usr/local/bin/kanata                 Kanata executable

Drivers:
  /Library/Application Support/org.pqrs/
    Karabiner-DriverKit-VirtualHIDDevice/
  /Applications/
    .Karabiner-VirtualHIDDevice-Manager.app

Dotfiles:
  ~/dotfiles/kanata/
    SETUP_GUIDE.md                      Comprehensive guide
    QUICK_REFERENCE.md                  This file
    kanata-check.sh                     Diagnostic script
    .config/kanata/kanata.kbd           Config (symlinked)
```

## Service Status Codes

When running `sudo launchctl list | grep kanata`:

```
PID    STATUS  NAME
---    ------  ----
12345  0       com.example.kanata     ← Healthy (running, exit code 0)
-      0       com.example.kanata     ← Loaded but not running
12345  -6      com.example.kanata     ← Error state (check logs)
-      -       com.example.kanata     ← Not loaded
```

## Plist Template

Minimal working plist for `/Library/LaunchDaemons/com.example.kanata.plist`:

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
        <string>/Users/USERNAME/.config/kanata/kanata.kbd</string>
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

**Remember:** Replace `USERNAME` with your username!

## Emergency Reset

If everything is broken:

```bash
# 1. Kill all kanata processes
sudo killall kanata

# 2. Unload all kanata services
sudo launchctl bootout system/com.example.kanata

# 3. Check for issues
~/dotfiles/kanata/kanata-check.sh

# 4. View recent errors
sudo tail -50 /Library/Logs/Kanata/kanata.err.log

# 5. Test config
kanata -c ~/.config/kanata/kanata.kbd --check

# 6. Reload service
sudo launchctl bootstrap system /Library/LaunchDaemons/com.example.kanata.plist

# Still broken? Read the full guide:
less ~/dotfiles/kanata/SETUP_GUIDE.md
```

## Getting Help

1. **Run diagnostics:** `~/dotfiles/kanata/kanata-check.sh --verbose`
2. **Check logs:** `sudo tail -100 /Library/Logs/Kanata/kanata.err.log`
3. **Read full guide:** `less ~/dotfiles/kanata/SETUP_GUIDE.md`
4. **Check GitHub:** [Kanata Discussions](https://github.com/jtroo/kanata/discussions)
5. **macOS specific:** [Discussion #1537](https://github.com/jtroo/kanata/discussions/1537)

---

**Quick access:**
- Full guide: `~/dotfiles/kanata/SETUP_GUIDE.md`
- Diagnostics: `~/dotfiles/kanata/kanata-check.sh`
- Config: `~/.config/kanata/kanata.kbd`
