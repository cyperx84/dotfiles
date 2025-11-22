# Kanata Configuration

This directory contains configuration files and utilities for [Kanata](https://github.com/jtroo/kanata), a powerful keyboard remapping tool for macOS.

## Contents

```
kanata/
├── README.md              # This file
├── SETUP_GUIDE.md         # Comprehensive setup and troubleshooting guide
├── kanata-check.sh        # Diagnostic script for checking kanata health
└── .config/
    └── kanata/
        └── kanata.kbd     # Kanata key mapping configuration
```

## Quick Start

### Installation

1. **Install dependencies:**
   ```bash
   brew install --cask karabiner-driverkit-virtualhiddevice
   brew install kanata
   ```

2. **Symlink config to home directory:**
   ```bash
   ln -sf ~/dotfiles/kanata/.config ~/.config/kanata
   ```

3. **Read the detailed setup guide:**
   ```bash
   cat ~/dotfiles/kanata/SETUP_GUIDE.md
   ```

### Health Check

Run the diagnostic script to check your kanata installation:

```bash
cd ~/dotfiles/kanata
./kanata-check.sh
```

**Options:**
- `./kanata-check.sh --verbose` - Show detailed output
- `./kanata-check.sh --fix` - Attempt automatic fixes (requires sudo)
- `./kanata-check.sh --help` - Show help

### Common Commands

```bash
# Check service status
sudo launchctl list | grep kanata

# View logs (live)
sudo tail -f /Library/Logs/Kanata/kanata.out.log
sudo tail -f /Library/Logs/Kanata/kanata.err.log

# Restart service
sudo launchctl bootout system/com.example.kanata
sudo launchctl bootstrap system /Library/LaunchDaemons/com.example.kanata.plist

# Test configuration
kanata -c ~/.config/kanata/kanata.kbd --check

# Run manually for testing
sudo kanata -c ~/.config/kanata/kanata.kbd -d
```

## Configuration

Your key mappings are defined in `.config/kanata/kanata.kbd`.

**After editing:**
1. Validate: `kanata -c ~/.config/kanata/kanata.kbd --check`
2. Reload: `sudo killall kanata` (service will auto-restart)

See the [Kanata documentation](https://github.com/jtroo/kanata/blob/main/docs/config.adoc) for configuration syntax.

## Troubleshooting

If kanata isn't working:

1. **Run the diagnostic script:**
   ```bash
   ~/dotfiles/kanata/kanata-check.sh
   ```

2. **Check logs for errors:**
   ```bash
   sudo tail -50 /Library/Logs/Kanata/kanata.err.log
   ```

3. **Read the full guide:**
   ```bash
   less ~/dotfiles/kanata/SETUP_GUIDE.md
   ```

4. **Common issues:**
   - Missing Input Monitoring permission → System Settings → Privacy & Security
   - Port 10000 already in use → Check for duplicate services
   - Driver not connected → Check VirtualHIDDevice services are running

## Files

### SETUP_GUIDE.md

A comprehensive 500+ line guide covering:
- Detailed architecture explanation
- Step-by-step installation instructions
- LaunchDaemon setup with templates
- Common issues and solutions
- Troubleshooting procedures
- Maintenance tasks

**Read this if:**
- You're setting up kanata for the first time
- You're having problems and need to understand how it works
- You need to recreate the LaunchDaemon plists

### kanata-check.sh

A diagnostic script that performs ~30 checks on your kanata installation:
- ✓ Checks if all required services are running
- ✓ Detects duplicate or conflicting services
- ✓ Verifies file permissions and ownership
- ✓ Checks for port conflicts
- ✓ Scans logs for errors
- ✓ Detects Karabiner Elements conflicts
- ✓ Validates configuration files

**Run this:**
- After installation to verify everything works
- When troubleshooting issues
- After updating kanata or macOS
- Periodically for health monitoring

### .config/kanata/kanata.kbd

Your actual key remapping configuration. This is symlinked to `~/.config/kanata/kanata.kbd`.

**Backup:** This file should be tracked in your dotfiles repo.

## LaunchDaemon Files

The actual LaunchDaemon plist files are stored in `/Library/LaunchDaemons/`:
- `com.example.kanata.plist` - Main kanata service
- `com.example.karabiner-vhidmanager.plist` - VirtualHID manager
- `com.example.karabiner-vhiddaemon.plist` - VirtualHID daemon

**Note:** These are not tracked in dotfiles because:
1. They require root ownership and live in a system directory
2. They may contain machine-specific paths
3. They're rarely edited after initial setup

Templates are provided in `SETUP_GUIDE.md` if you need to recreate them.

## Updating

### Update Kanata

```bash
# Update via Homebrew
brew upgrade kanata

# Run diagnostics to catch any issues
~/dotfiles/kanata/kanata-check.sh

# May need to re-grant Input Monitoring permission for new binary
```

### Update Configuration

```bash
# Edit your config
nvim ~/dotfiles/kanata/.config/kanata/kanata.kbd

# Validate
kanata -c ~/.config/kanata/kanata.kbd --check

# Reload (kanata auto-restarts due to KeepAlive)
sudo killall kanata

# Or manually reload
sudo launchctl bootout system/com.example.kanata
sudo launchctl bootstrap system /Library/LaunchDaemons/com.example.kanata.plist
```

## Resources

- [Kanata GitHub](https://github.com/jtroo/kanata)
- [Configuration Guide](https://github.com/jtroo/kanata/blob/main/docs/config.adoc)
- [macOS Setup Discussion](https://github.com/jtroo/kanata/discussions/1537)
- [Karabiner-DriverKit-VirtualHIDDevice](https://github.com/pqrs-org/Karabiner-DriverKit-VirtualHIDDevice)

## License

Configurations in this directory are part of your personal dotfiles.
Kanata itself is licensed under LGPL-3.0-only.

---

**Last Updated:** November 2024
**Tested On:** macOS Sequoia 15.x
**Kanata Version:** 1.7.0+
