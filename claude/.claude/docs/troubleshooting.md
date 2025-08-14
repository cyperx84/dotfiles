# Troubleshooting Guide

Common issues and solutions for Claude workspace management and usage.

## 🚨 Common Issues

### Configuration Problems

#### Settings Not Loading
**Symptoms:** Changes to `settings.json` don't take effect

**Diagnosis:**
```bash
# Check if symbolic links are working
ls -la settings.json settings.local.json

# Verify JSON syntax
jq . config/settings.json
jq . config/settings.local.json
```

**Solutions:**
```bash
# Recreate symbolic links
rm settings.json settings.local.json
ln -sf config/settings.json settings.json
ln -sf config/settings.local.json settings.local.json

# Fix JSON syntax errors
jq . config/settings.json  # Will show syntax errors
# Edit file to fix issues, then retry
```

#### Status Line Not Displaying
**Symptoms:** Custom status line doesn't appear or shows errors

**Diagnosis:**
```bash
# Test the status line command manually
input='{"workspace":{"current_dir":"/Users/test/Code"},"model":{"display_name":"Claude"}}'
echo "$input" | bash -c 'INPUT_FROM_SETTINGS_JSON_COMMAND_HERE'
```

**Solutions:**
```bash
# Common fixes:
# 1. Escape special characters properly
# 2. Check jq is installed: brew install jq
# 3. Verify command syntax in smaller parts

# Simplified status line for testing:
{
  "statusLine": {
    "type": "simple", 
    "template": "{model}"
  }
}
```

### Project Management Issues

#### Projects Not Appearing in Active Directory
**Symptoms:** Claude Code sessions don't create project directories

**Diagnosis:**
```bash
# Check if projects directory exists and is writable
ls -la projects/active/
touch projects/active/test-file && rm projects/active/test-file

# Check if symbolic links work
ls -la | grep projects
```

**Solutions:**
```bash
# Recreate project structure
mkdir -p projects/{active,archived}

# Fix permissions
chmod 755 projects/ projects/active/ projects/archived/

# Start Claude Code in a test directory
cd /tmp/test-claude
claude code
# Check if project appears in ~/.claude/projects/active/
```

#### Conversation History Missing
**Symptoms:** Previous conversations can't be accessed

**Diagnosis:**
```bash
# Find conversation files
find . -name "*.jsonl" -type f

# Check for corrupted files
find projects -name "*.jsonl" -exec jq empty {} \; 2>&1 | grep -v "parse error" || echo "Found corrupted files"
```

**Solutions:**
```bash
# Restore from backup
./tools/scripts/backup-workspace.sh data
# Find and restore from most recent backup

# Repair corrupted JSONL files
for file in $(find projects -name "*.jsonl"); do
    if ! jq empty "$file" 2>/dev/null; then
        echo "Repairing $file"
        # Manual repair may be needed
        cp "$file" "$file.backup"
        # Edit file to fix JSON syntax
    fi
done
```

### Agent Problems

#### Agent Not Responding or Performing Poorly
**Symptoms:** Task tool fails or gives unexpected results

**Diagnosis:**
```bash
# Check agent template validity
jq . agents/templates/*.json
jq . agents/subagents/*.json

# Test with different agent types
# Try: general-purpose, code-analysis, documentation
```

**Solutions:**
```bash
# Start with basic agent
Use: subagent_type: "general-purpose"

# If custom agent fails, revert to template
cp agents/templates/general-purpose-agent.json agents/subagents/working-agent.json

# Simplify agent prompt
# Remove complex requirements and be more specific
```

#### "Agent Not Available" Errors
**Symptoms:** Task tool reports agent type not available

**Solutions:**
```bash
# Use exact agent type names:
- "general-purpose" (not "general_purpose")
- "code-analysis" (not "code_analysis") 
- "documentation" (not "docs")
- "setup-configuration" (not "setup")

# Check available agents in Claude Code documentation
```

### Data Management Issues

#### Todo Lists Not Saving
**Symptoms:** TodoWrite tool fails or todos disappear

**Diagnosis:**
```bash
# Check todo directory and permissions
ls -la data/todos/
touch data/todos/test.json && rm data/todos/test.json

# Check for symbolic link issues
ls -la todos
```

**Solutions:**
```bash
# Recreate todo structure
mkdir -p data/todos
ln -sf data/todos todos

# Fix permissions
chmod 755 data/todos/
chmod 644 data/todos/*.json
```

#### Backup Scripts Failing
**Symptoms:** Backup scripts exit with errors

**Diagnosis:**
```bash
# Test backup script with dry run
./tools/scripts/backup-workspace.sh config /tmp/test-backup

# Check disk space
df -h

# Check permissions
ls -la tools/scripts/
```

**Solutions:**
```bash
# Fix script permissions
chmod +x tools/scripts/*.sh

# Create backup directory
mkdir -p ~/claude-backups

# Test with minimal backup first
./tools/scripts/backup-workspace.sh minimal
```

### Performance Issues

#### Slow Response Times
**Symptoms:** Claude Code takes long time to respond

**Diagnosis:**
```bash
# Check workspace size
du -sh ~/.claude/

# Find large files
find ~/.claude -size +100M -exec ls -lh {} \;

# Check available disk space
df -h
```

**Solutions:**
```bash
# Clean up old data
./tools/scripts/cleanup-data.sh 30 false

# Archive old projects
./tools/scripts/archive-project.sh old-project-name

# Remove large cache files
find data/cache -size +50M -mtime +7 -delete
```

#### High Disk Usage
**Symptoms:** Workspace taking too much disk space

**Analysis:**
```bash
# Analyze disk usage
du -sh ~/.claude/*/ | sort -hr

# Find largest components
find ~/.claude -type f -size +10M -exec ls -lh {} \;
```

**Solutions:**
```bash
# Archive old projects
for project in $(find projects/active -type d -mtime +30 -name "-Users-*"); do
    ./tools/scripts/archive-project.sh "$(basename "$project")"
done

# Compress archived data
cd projects/archived
tar -czf old-projects-$(date +%Y%m).tar.gz */ && rm -rf */

# Clean cache aggressively
rm -rf data/cache/statsig/statsig.cached.evaluations.*
```

## 🔧 System-Specific Issues

### macOS Issues

#### Permission Denied Errors
```bash
# Grant full disk access to Terminal app in System Preferences > Privacy & Security

# Fix common permission issues
sudo chown -R $(whoami) ~/.claude
chmod -R u+w ~/.claude
```

#### Symbolic Link Issues on APFS
```bash
# Use relative paths for better compatibility
rm settings.json
ln -s config/settings.json settings.json
```

### Linux Issues

#### Missing Dependencies
```bash
# Install required packages
sudo apt update
sudo apt install jq tree curl git

# For Arch Linux
sudo pacman -S jq tree curl git
```

#### SELinux Issues
```bash
# Check SELinux status
sestatus

# If necessary, adjust SELinux context
restorecon -R ~/.claude
```

### Windows/WSL Issues

#### Path Length Limitations
```bash
# Enable long paths in Windows
# Run as Administrator in PowerShell:
# New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem" -Name "LongPathsEnabled" -Value 1 -PropertyType DWORD -Force
```

#### Line Ending Issues
```bash
# Convert files to Unix line endings
dos2unix tools/scripts/*.sh
find . -name "*.json" -exec dos2unix {} \;
```

## 🐛 Advanced Troubleshooting

### Debugging Mode

#### Enable Verbose Logging
Add to `config/settings.local.json`:
```json
{
  "debug": true,
  "verboseLogging": true,
  "logLevel": "debug"
}
```

#### Script Debugging
```bash
# Add debug flags to scripts
set -x  # Enable trace mode
set -e  # Exit on error
set -u  # Error on undefined variables

# Example debugging a backup script
bash -x ./tools/scripts/backup-workspace.sh config
```

### Data Recovery

#### Recover Corrupted JSON Files
```bash
#!/bin/bash
# tools/scripts/repair-json.sh

for file in $(find . -name "*.json"); do
    if ! jq empty "$file" 2>/dev/null; then
        echo "Repairing: $file"
        cp "$file" "$file.backup"
        
        # Try to extract valid JSON parts
        grep -o '{[^}]*}' "$file" | jq -s . > "$file.temp"
        
        # Validate repair
        if jq empty "$file.temp" 2>/dev/null; then
            mv "$file.temp" "$file"
            echo "✓ Repaired: $file"
        else
            echo "✗ Could not repair: $file"
            rm "$file.temp"
        fi
    fi
done
```

#### Recover from Git History
```bash
# If workspace is under git control
git log --oneline --name-only | head -20

# Restore specific files
git checkout HEAD~5 -- config/settings.json

# Create recovery branch
git branch recovery-$(date +%Y%m%d)
```

### Network-Related Issues

#### WebFetch/WebSearch Failures
```bash
# Test network connectivity
ping -c 3 google.com
curl -I https://httpbin.org/status/200

# Check proxy settings
env | grep -i proxy

# Test with different URL
```

#### MCP Server Connection Issues
```bash
# Check MCP server status
ps aux | grep -i mcp

# Test MCP server directly
# (depends on specific MCP server implementation)

# Disable MCP servers temporarily
echo '{"enableAllProjectMcpServers": false}' > config/settings.local.json
```

## 🔄 Recovery Procedures

### Complete Workspace Reset

#### Backup Current State
```bash
# Create emergency backup
tar -czf claude-emergency-backup-$(date +%Y%m%d-%H%M%S).tar.gz ~/.claude
mv claude-emergency-backup-*.tar.gz ~/Documents/
```

#### Reset to Clean State
```bash
# Preserve important data
mkdir /tmp/claude-preserve
cp -r ~/.claude/projects/active /tmp/claude-preserve/
cp -r ~/.claude/config /tmp/claude-preserve/
cp -r ~/.claude/agents/subagents /tmp/claude-preserve/ 2>/dev/null || true

# Reset workspace
rm -rf ~/.claude
git clone <this-repository> ~/.claude

# Restore preserved data
cp -r /tmp/claude-preserve/active ~/.claude/projects/
cp -r /tmp/claude-preserve/config/* ~/.claude/config/
cp -r /tmp/claude-preserve/subagents ~/.claude/agents/ 2>/dev/null || true

# Recreate symbolic links
cd ~/.claude
ln -sf config/settings.json settings.json
ln -sf config/settings.local.json settings.local.json
ln -sf data/todos todos
```

### Partial Recovery

#### Recover Specific Components
```bash
# Recover only configuration
git checkout HEAD -- config/

# Recover only agents
git checkout HEAD -- agents/

# Recover only tools
git checkout HEAD -- tools/
chmod +x tools/scripts/*.sh
```

## 📊 Health Checks

### Automated Health Check Script
```bash
#!/bin/bash
# tools/scripts/health-check.sh

echo "🏥 Claude Workspace Health Check"
echo "==============================="

ISSUES=0

# Check directory structure
for dir in config agents projects/active projects/archived tools/scripts data/todos; do
    if [ ! -d "$dir" ]; then
        echo "❌ Missing directory: $dir"
        ISSUES=$((ISSUES + 1))
    else
        echo "✅ Directory exists: $dir"
    fi
done

# Check symbolic links
for link in settings.json todos; do
    if [ ! -L "$link" ]; then
        echo "❌ Missing symbolic link: $link"
        ISSUES=$((ISSUES + 1))
    else
        echo "✅ Symbolic link OK: $link"
    fi
done

# Check JSON files
for file in config/settings.json agents/templates/*.json; do
    if [ -f "$file" ]; then
        if jq empty "$file" 2>/dev/null; then
            echo "✅ Valid JSON: $file"
        else
            echo "❌ Invalid JSON: $file"
            ISSUES=$((ISSUES + 1))
        fi
    fi
done

# Check script permissions
for script in tools/scripts/*.sh; do
    if [ -x "$script" ]; then
        echo "✅ Executable: $script"
    else
        echo "❌ Not executable: $script"
        ISSUES=$((ISSUES + 1))
    fi
done

echo ""
if [ $ISSUES -eq 0 ]; then
    echo "🎉 All health checks passed!"
else
    echo "⚠️  Found $ISSUES issues that need attention"
fi
```

## 🆘 Getting Additional Help

### Diagnostic Information to Collect
```bash
# System information
uname -a
echo "Claude Code version:"
claude --version 2>/dev/null || echo "Claude CLI not found"

# Workspace information  
echo "Workspace size:"
du -sh ~/.claude

echo "Directory structure:"
tree -L 2 ~/.claude

echo "Recent errors:"
find ~/.claude -name "*.log" -mtime -1 -exec tail -20 {} \;
```

### Community Resources
- Claude Code Documentation: https://docs.anthropic.com/claude-code
- GitHub Issues: https://github.com/anthropics/claude-code/issues
- Community Forums: [Check Claude Code documentation for links]

### Professional Support
For enterprise users or complex issues:
- Document the issue with diagnostic information
- Include steps to reproduce
- Provide workspace health check results
- Include relevant configuration files (sanitized of secrets)