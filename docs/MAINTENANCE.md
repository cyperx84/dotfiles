# Dotfiles Maintenance Guide

> **🔧 Quick Navigation**
> [Validation Scripts](#validation-scripts) • [Troubleshooting](#troubleshooting) • [Service Management](#service-management) • [Updates & Upgrades](#updates--upgrades) • [Common Issues](#common-issues)

## Overview

This guide provides comprehensive maintenance procedures for the dotfiles system, including validation scripts, troubleshooting workflows, and service management. All procedures are designed to be both human and agent executable.

---

## Validation Scripts

### 🧪 System Validation Commands

**Complete System Check**:
```bash
# Run all validation scripts
~/.config/sketchybar/test_sketchybar.sh            # SketchyBar plugins
~/.config/sketchybar/plugin_health_monitor.sh test # Plugin health
sesh list                                           # Sesh sessions (manual check)

# Quick service status check
brew services list | grep -E "(yabai|skhd|sketchybar)"
```

### 📋 Sesh Validation

**⚠️ NOTE**: The `~/bin/validate_sesh.sh` script was **REMOVED** in Oct 2025 migration.

**Manual Validation**:
```bash
# Check sesh configuration and sessions
sesh list  # Should show sessions without errors

# Verify sesh.toml syntax
cat ~/.config/sesh/sesh.toml  # Check for syntax errors

# Test session switching
sesh connect <session-name>
```

**What to check manually**:
- Configuration syntax (`~/.config/sesh/sesh.toml`)
- Session definitions load correctly
- Essential tool dependencies (tmux, fzf, eza, yazi, nvim) are installed
- Tmuxinator integration works
- Session previews display correctly (FZF integration)

### 🎨 SketchyBar Validation
**Scripts**: Multiple testing utilities in `~/.config/sketchybar/`

**Core Testing**:
```bash
# Test all plugins
~/.config/sketchybar/test_sketchybar.sh

# Test specific plugin
~/.config/sketchybar/test_sketchybar.sh github

# Health monitoring
~/.config/sketchybar/plugin_health_monitor.sh test
~/.config/sketchybar/plugin_health_monitor.sh report
```

**Debugging Tools**:
```bash
# Full debugging session
~/.config/sketchybar/debug_sketchybar.sh

# Debug specific plugin
~/.config/sketchybar/debug_sketchybar.sh plugin git

# Monitor plugins in real-time
~/.config/sketchybar/debug_sketchybar.sh monitor
```

**Helper Binary Validation**:
```bash
# Recompile helper if needed
cd ~/.config/sketchybar/helper && make clean && make
```

---

## Service Management

### 🚀 Core Services

**Start Services**:
```bash
# Window management
brew services start yabai
brew services start skhd

# Menu bar
brew services start sketchybar

# Check status
brew services list | grep -E "(yabai|skhd|sketchybar)"
```

**Restart Services** (after config changes):
```bash
# Individual restarts
brew services restart yabai
brew services restart skhd
brew services restart sketchybar

# Quick reload (within active session)
sketchybar --reload              # SketchyBar only
yabai --restart-service          # Yabai only
```

**Stop Services**:
```bash
brew services stop yabai
brew services stop skhd
brew services stop sketchybar
```

### 🔄 Configuration Reloading

**Without Service Restart**:
```bash
# SketchyBar
sketchybar --reload

# Tmux (from within tmux)
tmux source-file ~/.tmux.conf
# or: C-a r (if using tmux prefix binding)

# Zsh
exec zsh
# or: source ~/.zshrc
```

**Yabai Configuration**:
```bash
# Validate before restarting
yabai --check-config

# Restart if valid
yabai --restart-service
```

---

## Troubleshooting

### 🔍 Diagnostic Workflows

**Window Management Issues**:
```bash
# 1. Check service status
brew services list | grep -E "(yabai|skhd)"

# 2. Check permissions
# System Preferences > Security & Privacy > Accessibility
# Ensure yabai and skhd have permissions

# 3. Check configuration syntax
yabai --check-config

# 4. Check SKHD logs
tail -f /usr/local/var/log/skhd/skhd.out.log

# 5. Manual restart
brew services restart yabai
brew services restart skhd
```

**SketchyBar Issues**:
```bash
# 1. Run health check
~/.config/sketchybar/plugin_health_monitor.sh test

# 2. Check specific plugin
~/.config/sketchybar/test_sketchybar.sh <plugin_name>

# 3. Reload configuration
sketchybar --reload

# 4. Check plugin dependencies
~/.config/sketchybar/plugin_health_monitor.sh deps

# 5. Debug mode
~/.config/sketchybar/debug_sketchybar.sh
```

**Terminal/Tmux Issues**:
```bash
# 1. Check Ghostty configuration
# Look for syntax errors in ~/.config/ghostty/config

# 2. Validate tmux configuration
tmux source-file ~/.tmux.conf

# 3. Check plugin installation (tmux)
~/.tmux/plugins/tpm/bin/install_plugins

# 4. Test terminal capabilities
echo $TERM
tput colors
```

**Neovim Issues**:
```bash
# 1. Check health
nvim --cmd "checkhealth"

# 2. Plugin issues
nvim --cmd "Lazy sync"

# 3. LSP issues
nvim --cmd "LspInfo"

# 4. Clean start (backup config first)
mv ~/.local/share/nvim ~/.local/share/nvim.backup
```

### 🔧 Session Management Issues

**Sesh Problems**:
```bash
# 1. Validate configuration (manual)
sesh list

# 2. Check sesh availability
which sesh
sesh --version

# 3. Test basic functionality
sesh list

# 4. Check session switching
sesh connect <session-name>
```

**Tmux/Session Issues**:
```bash
# 1. Check running sessions
tmux list-sessions

# 2. Kill problematic sessions
tmux kill-session -t session_name
tmux kill-server  # Nuclear option

# 3. Check tmux configuration
tmux source-file ~/.tmux.conf

# 4. Plugin issues
~/.tmux/plugins/tpm/bin/install_plugins
```

---

## Updates & Upgrades

### 📦 System Updates

**Homebrew Maintenance**:
```bash
# Update package definitions
brew update

# Upgrade all packages
brew upgrade

# Clean up old versions
brew cleanup

# Check for issues
brew doctor
```

**Plugin Updates**:
```bash
# Tmux plugins
# In tmux: prefix + U (update all plugins)
# Or manually: ~/.tmux/plugins/tpm/bin/update_plugins

# Neovim plugins
nvim --cmd "Lazy sync"

# SketchyBar (manual update)
cd ~/.config/sketchybar && git pull
```

### 🔄 Configuration Updates

**After Updating Dotfiles**:
```bash
# 1. Pull latest changes
cd ~/dotfiles && git pull

# 2. Re-stow configurations
stow -R */  # Restow all configurations

# 3. Restart services
brew services restart yabai
brew services restart skhd
brew services restart sketchybar

# 4. Reload shell
exec zsh

# 5. Validate
sesh list  # Manual check (validate_sesh.sh removed Oct 2025)
~/.config/sketchybar/test_sketchybar.sh
```

**Stow Management**:
```bash
# Check what's stowed
stow --list

# Remove and re-add specific component
stow -D component_name
stow component_name

# Handle conflicts
stow --adopt component_name  # Adopt existing files
```

---

## Common Issues

### ❌ Window Management Not Working

**Symptoms**: Keybinds not responding, windows not tiling
**Solutions**:
1. **Check Accessibility Permissions**:
   - System Preferences > Security & Privacy > Accessibility
   - Add and enable `yabai` and `skhd`

2. **Restart Services**:
   ```bash
   brew services restart yabai
   brew services restart skhd
   ```

3. **Check Configuration**:
   ```bash
   yabai --check-config
   ```

### ❌ SketchyBar Not Displaying

**Symptoms**: Menu bar missing or plugins not working
**Solutions**:
1. **Restart SketchyBar**:
   ```bash
   brew services restart sketchybar
   ```

2. **Check Plugin Health**:
   ```bash
   ~/.config/sketchybar/plugin_health_monitor.sh test
   ```

3. **Rebuild Helper Binary**:
   ```bash
   cd ~/.config/sketchybar/helper && make clean && make
   ```

### ❌ Terminal Colors/Fonts Issues

**Symptoms**: Wrong colors, missing ligatures, font rendering issues
**Solutions**:
1. **Check Font Installation**:
   ```bash
   fc-list | grep -i monaspace
   ```

2. **Verify Ghostty Config**:
   ```bash
   # Check for syntax errors in ~/.config/ghostty/config
   ```

3. **Reset Terminal**:
   ```bash
   # Close all terminal windows and restart Ghostty
   ```

### ❌ Keyboard Remapping Not Working

**Symptoms**: Caps lock still caps lock, modifier keys not working
**Solutions**:
1. **Karabiner-Elements Issues**:
   - Check if app is running in System Preferences
   - Restart Karabiner-Elements service

2. **Kanata Issues** (if using):
   ```bash
   # Check if kanata service is running
   sudo kanata --cfg ~/.config/kanata/kanata.kbd
   ```

3. **Permission Issues**:
   - Grant Input Monitoring permissions in System Preferences

### ❌ Session Management Problems

**Symptoms**: Sesh not finding sessions, tmux issues
**Solutions**:
1. **Validate Sesh**:
   ```bash
   sesh list  # Manual validation (script removed Oct 2025)
   ```

2. **Check Dependencies**:
   ```bash
   which sesh tmux fzf
   ```

3. **Reset Tmux**:
   ```bash
   tmux kill-server  # Kill all sessions
   # Restart fresh
   ```

---

## Maintenance Schedule

### 🗓️ Regular Maintenance

**Weekly**:
- Run `brew update && brew upgrade`
- Run validation scripts
- Check service status

**Monthly**:
- Update Neovim plugins (`Lazy sync`)
- Update tmux plugins (prefix + U)
- Review and clean old sessions

**After System Updates**:
- Restart all services
- Re-verify accessibility permissions
- Run full validation suite

---

## Emergency Recovery

### 🚨 Complete System Reset

**If everything breaks**:
```bash
# 1. Stop all services
brew services stop yabai
brew services stop skhd
brew services stop sketchybar

# 2. Backup current config
cp -r ~/.config ~/.config.backup.$(date +%Y%m%d)

# 3. Re-stow from scratch
cd ~/dotfiles
stow -D */  # Remove all stow links
stow */     # Re-create all links

# 4. Restart services
brew services start yabai
brew services start skhd
brew services start sketchybar

# 5. Restart shell
exec zsh

# 6. Validate everything
sesh list  # Manual check (validate_sesh.sh removed Oct 2025)
~/.config/sketchybar/test_sketchybar.sh
```

### 🔙 Rollback Procedure

**If new changes break system**:
```bash
# 1. Git rollback
cd ~/dotfiles
git log --oneline  # Find last working commit
git reset --hard <commit_hash>

# 2. Re-stow
stow -D */ && stow */

# 3. Restart services and validate
```

---

## Related Documentation

- **[Components Guide](COMPONENTS.md)** - Detailed component information
- **[Troubleshooting Keybinds](KEYBINDS.md)** - Key binding reference
- **[Workflow Guides](WORKFLOW_GUIDES.md)** - Integration workflows
- **[AGENTS.md](../AGENTS.md)** - Development guidelines and testing

---

*This maintenance guide ensures system reliability and provides systematic approaches to common issues. Keep this guide updated as new components are added or procedures change.*