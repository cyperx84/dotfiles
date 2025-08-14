# Setup Guide

Complete guide for setting up and configuring your Claude workspace repository.

## 🚀 Initial Setup

### Prerequisites
- Claude Code CLI installed and configured
- Git (for version control)
- Node.js (for local tools, if needed)
- Basic terminal/shell knowledge

### 1. Repository Initialization

If you're setting up in an existing `.claude` directory:
```bash
cd ~/.claude
git init
git add .gitignore README.md
git commit -m "Initial commit - Claude workspace setup"
```

If you're cloning this repository:
```bash
git clone <repository-url> ~/.claude
cd ~/.claude
```

### 2. Configuration Setup

#### Basic Configuration
1. Review and customize `config/settings.json`:
   ```bash
   vim config/settings.json
   ```

2. Create local overrides (optional):
   ```bash
   cp config/settings.json config/settings.local.json
   vim config/settings.local.json
   ```

#### Status Line Configuration
The default status line shows directory icons and model info. Customize icons by editing the `sed` commands in `config/settings.json`:

```json
{
  "statusLine": {
    "type": "command",
    "command": "input=$(cat); dir=$(echo \"$input\" | jq -r '.workspace.current_dir'); model=$(echo \"$input\" | jq -r '.model.display_name'); printf '\\033[1;32m󰯈\\033[0m \\033[1;33m%s\\033[0m \\033[1;36m%s\\033[0m' \"$(basename \"$dir\" | sed 's/^mynewproject$/󰎯/g')\" \"$model\""
  }
}
```

### 3. Agent Setup

#### Using Default Agents
No setup required - templates are ready to use with the Task tool:
```
Use the Task tool with these subagent_type values:
- general-purpose
- code-analysis  
- documentation
- setup-configuration
```

#### Creating Custom Agents
1. Copy a template:
   ```bash
   cp agents/templates/general-purpose-agent.json agents/subagents/my-agent.json
   ```

2. Customize the agent definition:
   ```bash
   vim agents/subagents/my-agent.json
   ```

3. Validate the JSON:
   ```bash
   jq . agents/subagents/my-agent.json
   ```

### 4. Tools Setup

#### Script Permissions
Make utility scripts executable:
```bash
chmod +x tools/scripts/*.sh
```

#### Shell Integration (Optional)
Add convenient aliases to your shell:
```bash
# Add to ~/.bashrc or ~/.zshrc
alias claude-backup='~/.claude/tools/scripts/backup-workspace.sh'
alias claude-cleanup='~/.claude/tools/scripts/cleanup-data.sh'
alias claude-archive='~/.claude/tools/scripts/archive-project.sh'
```

#### Cron Jobs (Optional)
Set up automatic maintenance:
```bash
crontab -e
# Add these lines:
# Daily cleanup at 2 AM
0 2 * * * cd ~/.claude && ./tools/scripts/cleanup-data.sh 30 false
# Weekly backup on Sundays at 3 AM  
0 3 * * 0 cd ~/.claude && ./tools/scripts/backup-workspace.sh full
```

### 5. Initial Backup
Create your first backup:
```bash
./tools/scripts/backup-workspace.sh full
```

## 🔧 Advanced Configuration

### Custom Status Line Icons
Add new directory-specific icons by modifying the `sed` chain in `config/settings.json`:

```bash
# Example: Add icon for "kubernetes" directory
sed 's/^kubernetes$/󱃾/g'
```

### MCP Server Configuration
Configure Model Context Protocol servers in `config/settings.local.json`:
```json
{
  "enableAllProjectMcpServers": false,
  "mcpServers": {
    "custom-server": {
      "command": "path/to/server",
      "args": ["--config", "config.json"]
    }
  }
}
```

### Project-Specific Settings
For project-specific configurations, use environment variables or project-specific files:
```json
{
  "projectSettings": {
    "/path/to/specific/project": {
      "customSetting": "value"
    }
  }
}
```

## 🗂️ Data Migration

### From Existing Claude Setup
If you have existing Claude data to migrate:

1. **Backup existing data first:**
   ```bash
   tar -czf claude-backup-$(date +%Y%m%d).tar.gz ~/.claude
   ```

2. **Move conversation history:**
   ```bash
   # Find existing project conversations
   find ~/.claude -name "*.jsonl" -path "*/projects/*"
   
   # Move to new structure
   for dir in ~/.claude/projects/*/; do
     mv "$dir" ~/.claude/projects/active/
   done
   ```

3. **Migrate todos:**
   ```bash
   # Move existing todos to new location
   mv ~/.claude/todos/* ~/.claude/data/todos/ 2>/dev/null || true
   ```

### From Other Systems
Converting from other AI coding assistants:

1. **Extract conversation history** in JSON format
2. **Convert to Claude's JSONL format:**
   ```bash
   # Example conversion script
   jq -r '.messages[] | {type: "message", role: .role, content: .content, timestamp: .timestamp}' \
     other-format.json > claude-format.jsonl
   ```
3. **Place in appropriate project directory**

## 🔍 Verification

### Test Configuration
1. **Check file structure:**
   ```bash
   tree -L 2 ~/.claude
   ```

2. **Validate JSON files:**
   ```bash
   find config agents -name "*.json" -exec jq . {} \;
   ```

3. **Test scripts:**
   ```bash
   # Dry run cleanup
   ./tools/scripts/cleanup-data.sh 30 true
   
   # Test backup
   ./tools/scripts/backup-workspace.sh config
   ```

4. **Start Claude Code:**
   ```bash
   claude code
   ```

### Common Setup Issues

#### Permission Errors
```bash
# Fix permissions
chmod -R 644 config/*.json
chmod -R 755 tools/scripts/*.sh
chmod 600 config/settings.local.json  # If contains secrets
```

#### Symbolic Link Issues
```bash
# Recreate symbolic links if broken
ln -sf config/settings.json settings.json
ln -sf config/settings.local.json settings.local.json
ln -sf data/todos todos
ln -sf data/snapshots shell-snapshots
```

#### JSON Syntax Errors
```bash
# Validate and fix JSON
jq . config/settings.json
# Fix syntax errors and retry
```

## 📋 Post-Setup Checklist

- [ ] Repository initialized with git
- [ ] Configuration files reviewed and customized
- [ ] Agent templates tested with Task tool
- [ ] Utility scripts made executable and tested
- [ ] Initial backup created
- [ ] Shell aliases added (optional)
- [ ] Cron jobs configured (optional)
- [ ] Claude Code starts successfully
- [ ] Status line displays correctly
- [ ] Todo list functionality works
- [ ] Project conversations save properly

## 🔄 Updating the Setup

### Updating Templates
```bash
# Pull latest templates from repository
git pull origin main

# Or manually update specific templates
cp new-template.json agents/templates/
```

### Configuration Updates
```bash
# Backup current config
cp config/settings.json config/settings.json.bak

# Update configuration
vim config/settings.json

# Test changes
claude code --test-config
```

### Script Updates
```bash
# Update scripts while preserving execute permissions
git pull
chmod +x tools/scripts/*.sh
```

## 🆘 Getting Help

If you encounter issues during setup:

1. **Check logs:** `~/.claude/logs/` (if exists)
2. **Validate configuration:** Use `jq` to check JSON syntax
3. **Test components individually:** Scripts, agents, configuration
4. **Consult troubleshooting:** See `docs/troubleshooting.md`
5. **Community resources:** Check Claude Code documentation and forums

## 🔗 Next Steps

After setup is complete:

1. **Read the workflows guide:** `docs/workflows.md`
2. **Explore customization options:** `docs/customization.md`
3. **Start your first project:** Navigate to a project directory and run `claude code`
4. **Experiment with agents:** Try the Task tool with different agent types