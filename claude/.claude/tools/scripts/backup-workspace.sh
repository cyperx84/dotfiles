#!/bin/bash

# Backup Claude Workspace Script
# Creates timestamped backups of workspace data

set -e

BACKUP_TYPE=${1:-full}
BACKUP_DIR=${2:-"$HOME/claude-backups"}
TIMESTAMP=$(date +%Y%m%d-%H%M%S)

echo "Claude Workspace Backup"
echo "======================"
echo "Backup type: $BACKUP_TYPE"
echo "Backup directory: $BACKUP_DIR"
echo "Timestamp: $TIMESTAMP"
echo ""

# Create backup directory
mkdir -p "$BACKUP_DIR"

case $BACKUP_TYPE in
    "full")
        echo "📦 Creating full workspace backup..."
        BACKUP_FILE="$BACKUP_DIR/claude-workspace-full-$TIMESTAMP.tar.gz"
        
        # Exclude cache and temporary files
        tar -czf "$BACKUP_FILE" \
            --exclude="data/cache/statsig" \
            --exclude="data/snapshots" \
            --exclude=".git" \
            --exclude="node_modules" \
            --exclude="*.log" \
            .
        
        echo "✓ Full backup created: $BACKUP_FILE"
        ;;
        
    "config")
        echo "⚙️ Creating configuration backup..."
        BACKUP_FILE="$BACKUP_DIR/claude-config-$TIMESTAMP.tar.gz"
        
        tar -czf "$BACKUP_FILE" \
            config/ \
            agents/ \
            tools/scripts/ \
            .gitignore \
            README.md
        
        echo "✓ Configuration backup created: $BACKUP_FILE"
        ;;
        
    "data")
        echo "💾 Creating data backup..."
        BACKUP_FILE="$BACKUP_DIR/claude-data-$TIMESTAMP.tar.gz"
        
        tar -czf "$BACKUP_FILE" \
            --exclude="data/cache/statsig" \
            data/ \
            projects/
        
        echo "✓ Data backup created: $BACKUP_FILE"
        ;;
        
    "minimal")
        echo "📋 Creating minimal backup (config + active projects)..."
        BACKUP_FILE="$BACKUP_DIR/claude-minimal-$TIMESTAMP.tar.gz"
        
        tar -czf "$BACKUP_FILE" \
            config/ \
            agents/ \
            projects/active/ \
            data/todos/ \
            README.md
        
        echo "✓ Minimal backup created: $BACKUP_FILE"
        ;;
        
    *)
        echo "❌ Invalid backup type: $BACKUP_TYPE"
        echo ""
        echo "Usage: $0 [backup_type] [backup_directory]"
        echo ""
        echo "Backup types:"
        echo "  full     - Complete workspace (excluding cache)"
        echo "  config   - Configuration files and templates"
        echo "  data     - All data files and projects"
        echo "  minimal  - Essential files only"
        echo ""
        echo "Examples:"
        echo "  $0 full"
        echo "  $0 config ~/backups"
        echo "  $0 data"
        exit 1
        ;;
esac

# Show backup info
BACKUP_SIZE=$(du -sh "$BACKUP_FILE" | cut -f1)
echo ""
echo "📊 Backup Summary:"
echo "  File: $(basename "$BACKUP_FILE")"
echo "  Size: $BACKUP_SIZE"
echo "  Location: $BACKUP_FILE"
echo ""

# Cleanup old backups (keep last 5)
echo "🧹 Cleaning up old backups..."
cd "$BACKUP_DIR"
ls -t claude-*-*.tar.gz 2>/dev/null | tail -n +6 | xargs rm -f 2>/dev/null || true
REMAINING=$(ls -1 claude-*-*.tar.gz 2>/dev/null | wc -l)
echo "  Kept most recent $REMAINING backups"

echo ""
echo "✅ Backup completed successfully!"