#!/bin/bash

# Archive Project Script
# Moves a project from active to archived status

set -e

PROJECT_NAME="$1"
ACTIVE_DIR="projects/active"
ARCHIVE_DIR="projects/archived"

if [ -z "$PROJECT_NAME" ]; then
    echo "Usage: $0 <project-name>"
    echo "Example: $0 -Users-cyperx-Code-myproject"
    exit 1
fi

if [ ! -d "$ACTIVE_DIR/$PROJECT_NAME" ]; then
    echo "Error: Project '$PROJECT_NAME' not found in active directory"
    echo "Available projects:"
    ls -1 "$ACTIVE_DIR" 2>/dev/null || echo "  (no active projects)"
    exit 1
fi

echo "Archiving project: $PROJECT_NAME"

# Create archive directory if it doesn't exist
mkdir -p "$ARCHIVE_DIR"

# Move project to archive
mv "$ACTIVE_DIR/$PROJECT_NAME" "$ARCHIVE_DIR/"

# Move related todos to archive
TODO_DIR="data/todos"
ARCHIVE_TODO_DIR="data/archive/todos-$(date +%Y%m)"
mkdir -p "$ARCHIVE_TODO_DIR"

# Find and move related todo files
find "$TODO_DIR" -name "*$PROJECT_NAME*" -type f -exec mv {} "$ARCHIVE_TODO_DIR/" \; 2>/dev/null || true

echo "✓ Project archived successfully"
echo "✓ Project data moved to: $ARCHIVE_DIR/$PROJECT_NAME"
echo "✓ Related todos archived to: $ARCHIVE_TODO_DIR"

# Show archive summary
echo ""
echo "Archive summary:"
echo "  Conversation files: $(find "$ARCHIVE_DIR/$PROJECT_NAME" -name "*.jsonl" | wc -l)"
echo "  Todo files archived: $(find "$ARCHIVE_TODO_DIR" -name "*$PROJECT_NAME*" | wc -l)"