# Project Management

This directory organizes all Claude Code conversation history and project-specific data.

## 📁 Structure

```
projects/
├── active/              # Currently active projects
├── archived/           # Completed/archived projects
└── README.md          # This documentation
```

## 🚀 Active Projects

The `active/` directory contains ongoing project conversations. Each project directory is named using the encoded path format and contains:

- **`.jsonl` files**: Conversation history in JSON Lines format
- **Session data**: Complete conversation context and history
- **Multiple sessions**: Different conversation threads per project

### Current Active Projects:
- **-Users-cyperx--claude/**: Claude workspace development
- **-Users-cyperx-Code/**: General coding projects
- **-Users-cyperx-Code-agents-instructors/**: Agent development work
- **-Users-cyperx-Code-bolt-diy/**: DIY Bolt project
- **-Users-cyperx-dotfiles/**: Dotfiles configuration
- **-Users-cyperx-Library-Mobile-Documents-iCloud-md-obsidian-Documents-notes/**: Note-taking system

## 📦 Archived Projects

The `archived/` directory stores completed or inactive projects for reference. Move projects here when:
- Development is complete
- Project is on indefinite hold
- Workspace cleanup is needed

## 🔄 Project Lifecycle

### Starting New Project
1. Navigate to project directory
2. Run `claude code` to start session
3. Conversation automatically saved to `projects/active/`

### Active Development
- Multiple conversation files per project
- Each `.jsonl` file represents a session
- Full conversation context preserved

### Archiving Project
```bash
# Move completed project to archive
mv projects/active/project-name projects/archived/

# Or use the convenience script (if available)
./tools/scripts/archive-project.sh project-name
```

## 📊 Data Format

### JSON Lines (.jsonl) Files
Each conversation session is stored as a JSON Lines file where each line contains:
```json
{"type": "message", "role": "user", "content": "...", "timestamp": "..."}
{"type": "message", "role": "assistant", "content": "...", "timestamp": "..."}
{"type": "tool_call", "tool": "...", "parameters": {...}, "timestamp": "..."}
```

### File Naming Convention
- Format: `{uuid}.jsonl`
- UUID identifies unique conversation session
- Multiple UUIDs per project = multiple conversation threads

## 🗂️ Project Organization Strategies

### By Development Phase
```bash
projects/active/my-project/     # Active development
projects/archived/my-project/   # Completed/paused
```

### By Project Type
- **Code projects**: Application development, scripts
- **Configuration**: Dotfiles, system setup
- **Documentation**: Notes, knowledge management
- **Research**: Exploration, proof of concepts

## 🔍 Finding Conversations

### By Project Path
```bash
# Find conversations for specific project
find projects/active -name "*project-name*" -type d

# List all sessions for a project
ls projects/active/project-name/
```

### By Content
```bash
# Search conversation content
grep -r "search term" projects/active/
```

### By Date
```bash
# Find recent conversations
find projects/active -name "*.jsonl" -mtime -7
```

## 🛠️ Management Tools

### Archive Old Projects
```bash
# Move projects older than 30 days to archive
find projects/active -type d -mtime +30 -exec mv {} projects/archived/ \;
```

### Cleanup Empty Sessions
```bash
# Remove empty conversation files
find projects/ -name "*.jsonl" -size 0 -delete
```

### Export Conversations
```bash
# Convert JSONL to readable format
jq -r '.content' projects/active/project/session.jsonl > conversation.txt
```

## 📈 Project Statistics

Track project activity and conversation volume:

```bash
# Count active projects
ls -1d projects/active/*/ | wc -l

# Count total conversations
find projects/active -name "*.jsonl" | wc -l

# Find most active project
find projects/active -name "*.jsonl" | cut -d'/' -f3 | sort | uniq -c | sort -nr | head -1
```

## 🔒 Privacy and Security

### Sensitive Data
- Conversation history may contain sensitive information
- Be cautious when sharing or backing up projects
- Consider using `.gitignore` for private projects

### Data Retention
- Keep archived projects for reference
- Regularly backup important conversations
- Consider encrypted storage for sensitive projects

## 🚨 Troubleshooting

### Missing Conversations
1. Check both `active/` and `archived/` directories
2. Verify file permissions: `chmod -R 644 projects/`
3. Look for corrupted `.jsonl` files: `jq . file.jsonl`

### Large File Sizes
1. Archive old projects: `mv projects/active/old projects/archived/`
2. Compress archives: `tar -czf project.tar.gz projects/archived/project/`
3. Split large conversations into multiple sessions

### Project Not Appearing
1. Check directory naming matches path encoding
2. Verify `.jsonl` files exist and aren't empty
3. Restart Claude Code to refresh project list

## 🔗 Related Tools

- [Data Management](../data/README.md) - Todo and snapshot organization
- [Tools Scripts](../tools/README.md) - Project automation utilities
- [Configuration](../config/README.md) - Project-specific settings