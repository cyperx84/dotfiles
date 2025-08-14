# Data Management

This directory contains all Claude Code data files including todos, snapshots, and cache data.

## 📁 Structure

```
data/
├── todos/              # Task management and todo lists
├── snapshots/          # Shell session snapshots
├── cache/              # Temporary files and cached data
│   └── statsig/        # Analytics and statistics
└── README.md          # This documentation
```

## 📋 Todo Management (`todos/`)

Contains JSON files for task management across all sessions and agents.

### File Types:
- **Session todos**: `{uuid}.json` - Main session task lists
- **Agent todos**: `{uuid}-agent-{agent-id}.json` - Agent-specific tasks

### Data Format:
```json
[
  {
    "id": "unique-id",
    "content": "Task description",
    "status": "pending|in_progress|completed",
    "timestamp": "ISO-8601-datetime"
  }
]
```

### Usage Patterns:
- **Active tracking**: Current session todos
- **Agent coordination**: Multi-agent task management
- **Progress history**: Completed task records
- **Context preservation**: Task continuity across sessions

## 📸 Snapshots (`snapshots/`)

Shell session snapshots preserve command history and environment state.

### File Format:
- **Pattern**: `snapshot-{shell}-{timestamp}-{id}.sh`
- **Content**: Shell commands and environment setup
- **Purpose**: Context restoration and session continuity

### Management:
```bash
# Clean old snapshots (older than 30 days)
find data/snapshots -name "*.sh" -mtime +30 -delete

# Count snapshots by shell type
ls data/snapshots/snapshot-*.sh | cut -d'-' -f2 | sort | uniq -c
```

## 💾 Cache (`cache/`)

Temporary files, analytics, and performance data.

### Statsig Analytics (`cache/statsig/`)
- **Evaluations**: Feature flag evaluations
- **Session tracking**: User session data
- **Performance metrics**: Usage analytics
- **Stable ID**: Persistent user identification

### Cache Management:
```bash
# Clear old cache files
find data/cache -type f -mtime +7 -delete

# Check cache size
du -sh data/cache/
```

## 🔧 Data Operations

### Backup Important Data
```bash
# Create timestamped backup
tar -czf "claude-data-$(date +%Y%m%d).tar.gz" data/

# Backup only todos
tar -czf "todos-backup-$(date +%Y%m%d).tar.gz" data/todos/
```

### Data Migration
```bash
# Export todos to readable format
for file in data/todos/*.json; do
    echo "=== $(basename "$file") ===" >> todos-export.txt
    jq -r '.[] | "- [\(.status)] \(.content)"' "$file" >> todos-export.txt
done
```

### Cleanup Operations
```bash
# Remove empty todo files
find data/todos -name "*.json" -exec test ! -s {} \; -delete

# Clear temporary cache
rm -rf data/cache/temp/*

# Archive old snapshots
mkdir -p data/archive/snapshots-$(date +%Y%m)
find data/snapshots -name "*.sh" -mtime +30 -exec mv {} data/archive/snapshots-$(date +%Y%m)/ \;
```

## 📊 Data Analytics

### Todo Statistics
```bash
# Count todos by status
jq -r '.[].status' data/todos/*.json | sort | uniq -c

# Find most active sessions
ls -la data/todos/ | grep -v agent | wc -l

# Agent activity
ls -la data/todos/*agent* | cut -d'-' -f4 | sort | uniq -c | sort -nr
```

### Session Analysis
```bash
# Shell usage statistics
ls data/snapshots/snapshot-*.sh | cut -d'-' -f2 | sort | uniq -c

# Recent activity
find data/snapshots -name "*.sh" -mtime -7 | wc -l
```

### Cache Monitoring
```bash
# Cache size by category
du -sh data/cache/*/

# Statsig activity
ls -la data/cache/statsig/ | grep evaluations | wc -l
```

## 🔒 Privacy and Security

### Sensitive Data
- **Todo content**: May contain project details, credentials
- **Snapshots**: Command history with potential secrets
- **Cache**: Analytics data and user behavior

### Data Protection
```bash
# Set appropriate permissions
chmod -R 600 data/todos/
chmod -R 600 data/snapshots/
chmod -R 644 data/cache/

# Encrypt sensitive backups
gpg -c claude-data-backup.tar.gz
```

### Data Retention
- **Todos**: Keep indefinitely for project continuity
- **Snapshots**: Archive after 30-60 days
- **Cache**: Clean regularly, keep recent data only

## 🚨 Troubleshooting

### Missing Todo Data
1. Check symbolic links: `ls -la todos shell-snapshots statsig`
2. Verify data directory permissions: `ls -la data/`
3. Look for corrupted JSON: `jq . data/todos/*.json`

### Large Data Directory
1. Archive old snapshots: `mv data/snapshots/* data/archive/`
2. Clean cache files: `rm -rf data/cache/temp/*`
3. Compress backups: `gzip data/archive/*.tar`

### Snapshot Issues
1. Check shell compatibility: `head -1 data/snapshots/snapshot-*.sh`
2. Verify execution permissions: `chmod +x data/snapshots/*.sh`
3. Test snapshot restoration: `source data/snapshots/latest.sh`

## 🔄 Migration Notes

Data was reorganized from root directory for:
- **Better organization**: Related data grouped together
- **Easier backup**: Single directory for all data
- **Clear separation**: Data vs configuration vs code
- **Simplified cleanup**: Centralized data management

### Compatibility
- **Symbolic links**: Maintain compatibility with Claude Code
- **File formats**: Preserved original data structures
- **Access patterns**: No changes to Claude Code behavior

## 📖 Related Documentation

- [Project Management](../projects/README.md) - Conversation history
- [Configuration](../config/README.md) - Settings and preferences
- [Tools](../tools/README.md) - Data management scripts