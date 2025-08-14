# Tools and Utilities

This directory contains custom tools, scripts, and utilities for managing your Claude workspace.

## 📁 Structure

```
tools/
├── local/              # Local Claude Code installation and dependencies
│   ├── claude          # Local Claude executable
│   ├── node_modules/   # Node.js dependencies
│   ├── package.json    # Node package configuration
│   └── package-lock.json
├── scripts/            # Automation and utility scripts
│   ├── archive-project.sh    # Archive projects from active to archived
│   ├── backup-workspace.sh   # Create workspace backups
│   ├── cleanup-data.sh       # Clean up old data files
│   └── [custom scripts...]
└── README.md          # This documentation
```

## 🛠️ Available Scripts

### Project Management

#### `archive-project.sh`
Archive a project from active to archived status.

```bash
# Archive a specific project
./tools/scripts/archive-project.sh -Users-cyperx-Code-myproject

# List available projects
ls projects/active/
```

**Features:**
- Moves project conversations to archived directory
- Archives related todo files with timestamp
- Provides summary of archived data
- Error handling for missing projects

### Data Management

#### `cleanup-data.sh`
Clean up old cache files, snapshots, and empty data.

```bash
# Dry run (preview what will be cleaned)
./tools/scripts/cleanup-data.sh 30 true

# Actually clean files older than 30 days
./tools/scripts/cleanup-data.sh 30 false

# Clean files older than 7 days
./tools/scripts/cleanup-data.sh 7
```

**Features:**
- Archives old shell snapshots
- Removes old cache files
- Deletes empty todo files
- Validates JSON file integrity
- Provides cleanup summary

#### `backup-workspace.sh`
Create comprehensive backups of your workspace.

```bash
# Full backup (recommended for regular backups)
./tools/scripts/backup-workspace.sh full

# Configuration only (agents, settings, scripts)
./tools/scripts/backup-workspace.sh config

# Data only (conversations, todos)
./tools/scripts/backup-workspace.sh data

# Minimal backup (essential files only)
./tools/scripts/backup-workspace.sh minimal

# Custom backup location
./tools/scripts/backup-workspace.sh full ~/my-backups
```

**Backup Types:**
- **full**: Complete workspace excluding cache
- **config**: Configuration files and templates
- **data**: All data files and conversations
- **minimal**: Essential files only (config + active projects)

**Features:**
- Timestamped backup files
- Excludes unnecessary files (cache, logs)
- Automatic cleanup of old backups (keeps 5 most recent)
- Size reporting and summary

## 🔧 Local Tools

### Claude Executable (`local/claude`)
Local Claude Code installation for custom functionality.

### Node.js Dependencies (`local/node_modules/`)
JavaScript packages and dependencies for Claude Code extensions.

**Managing Dependencies:**
```bash
# Install new package
cd tools/local && npm install package-name

# Update dependencies
cd tools/local && npm update

# Check for security vulnerabilities
cd tools/local && npm audit
```

## 📝 Creating Custom Scripts

### Script Template
```bash
#!/bin/bash

# Script Name and Description
# Brief explanation of what the script does

set -e  # Exit on any error

# Configuration
VARIABLE=${1:-default_value}

# Main function
main() {
    echo "Starting script..."
    
    # Your script logic here
    
    echo "Script completed successfully!"
}

# Help function
show_help() {
    echo "Usage: $0 [options]"
    echo ""
    echo "Description of the script"
    echo ""
    echo "Options:"
    echo "  -h, --help    Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 example"
}

# Parse arguments
case "${1:-}" in
    -h|--help)
        show_help
        exit 0
        ;;
    *)
        main "$@"
        ;;
esac
```

### Best Practices for Custom Scripts

#### Structure
- Use clear, descriptive names
- Include help/usage information
- Add error handling with `set -e`
- Document purpose and examples

#### Safety
- Test scripts with dry-run options
- Create backups before destructive operations
- Validate inputs and file paths
- Use meaningful exit codes

#### Integration
- Place scripts in `tools/scripts/`
- Make scripts executable: `chmod +x script.sh`
- Document in this README
- Consider adding to git for version control

### Example Custom Scripts

#### Project Statistics
```bash
#!/bin/bash
# project-stats.sh - Show workspace statistics

echo "📊 Claude Workspace Statistics"
echo "============================="
echo "Active projects: $(ls -1d projects/active/*/ 2>/dev/null | wc -l)"
echo "Archived projects: $(ls -1d projects/archived/*/ 2>/dev/null | wc -l)"
echo "Total conversations: $(find projects -name "*.jsonl" | wc -l)"
echo "Todo files: $(ls -1 data/todos/*.json 2>/dev/null | wc -l)"
echo "Agent templates: $(ls -1 agents/templates/*.json 2>/dev/null | wc -l)"
```

#### Find Recent Activity
```bash
#!/bin/bash
# recent-activity.sh - Show recent workspace activity

DAYS=${1:-7}

echo "📅 Recent Activity (last $DAYS days)"
echo "=================================="
echo ""
echo "Recent conversations:"
find projects/active -name "*.jsonl" -mtime -$DAYS -exec ls -la {} \;
echo ""
echo "Recent todos:"
find data/todos -name "*.json" -mtime -$DAYS -exec ls -la {} \;
```

## 🚀 Automation Ideas

### Scheduled Tasks
Set up cron jobs for regular maintenance:

```bash
# Add to crontab (crontab -e)
# Daily cleanup at 2 AM
0 2 * * * cd ~/.claude && ./tools/scripts/cleanup-data.sh 30 false

# Weekly full backup on Sundays at 3 AM
0 3 * * 0 cd ~/.claude && ./tools/scripts/backup-workspace.sh full
```

### Git Hooks
Create git hooks for workspace events:

```bash
# .git/hooks/pre-commit
#!/bin/bash
# Run cleanup before commits
cd ~/.claude && ./tools/scripts/cleanup-data.sh 30 false
```

### Shell Aliases
Add convenient aliases to your shell:

```bash
# Add to .bashrc or .zshrc
alias claude-archive='~/.claude/tools/scripts/archive-project.sh'
alias claude-backup='~/.claude/tools/scripts/backup-workspace.sh'
alias claude-cleanup='~/.claude/tools/scripts/cleanup-data.sh'
alias claude-stats='ls -la ~/.claude/projects/active/ | wc -l; echo "active projects"'
```

## 🔍 Troubleshooting

### Script Permission Issues
```bash
# Fix script permissions
chmod +x tools/scripts/*.sh

# Check script permissions
ls -la tools/scripts/
```

### Path Issues
```bash
# Run scripts from workspace root
cd ~/.claude
./tools/scripts/script-name.sh

# Or use absolute paths
~/.claude/tools/scripts/script-name.sh
```

### Node.js Issues
```bash
# Check Node.js version
node --version

# Reinstall dependencies
cd tools/local
rm -rf node_modules
npm install
```

## 📊 Tool Usage Analytics

Track script usage and performance:

```bash
# Log script usage
echo "$(date): $0 $*" >> tools/logs/script-usage.log

# Monitor backup sizes
du -sh ~/claude-backups/* | tail -10

# Check cleanup effectiveness
du -sh data/cache/ before and after cleanup
```

## 🔗 Integration Points

### Claude Code Integration
- Scripts can be called from Claude conversations
- Use absolute paths in Claude Code sessions
- Scripts can modify workspace data safely

### External Tool Integration
- Git hooks for version control
- CI/CD pipeline integration
- Backup system integration
- Monitoring and alerting systems

## 📖 Related Documentation

- [Agent Management](../agents/README.md) - Custom agent deployment
- [Data Management](../data/README.md) - Data organization and cleanup
- [Project Management](../projects/README.md) - Project lifecycle
- [Configuration](../config/README.md) - System configuration