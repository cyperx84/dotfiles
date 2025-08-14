#!/bin/bash

# Cleanup Data Script
# Removes old cache files, empty files, and organizes data

set -e

DAYS_OLD=${1:-30}
DRY_RUN=${2:-false}

echo "Claude Workspace Data Cleanup"
echo "============================="
echo "Removing files older than $DAYS_OLD days"
echo "Dry run: $DRY_RUN"
echo ""

# Function to run command or just show it
run_or_show() {
    if [ "$DRY_RUN" = "true" ]; then
        echo "[DRY RUN] $*"
    else
        echo "Running: $*"
        "$@"
    fi
}

# Clean old snapshots
echo "🧹 Cleaning old snapshots..."
OLD_SNAPSHOTS=$(find data/snapshots -name "*.sh" -mtime +$DAYS_OLD 2>/dev/null | wc -l)
if [ "$OLD_SNAPSHOTS" -gt 0 ]; then
    echo "  Found $OLD_SNAPSHOTS old snapshot files"
    if [ "$DRY_RUN" != "true" ]; then
        mkdir -p "data/archive/snapshots-$(date +%Y%m)"
        find data/snapshots -name "*.sh" -mtime +$DAYS_OLD -exec mv {} "data/archive/snapshots-$(date +%Y%m)/" \;
        echo "  ✓ Moved to archive"
    fi
else
    echo "  No old snapshots found"
fi

# Clean cache files
echo ""
echo "🧹 Cleaning cache files..."
CACHE_SIZE=$(du -sh data/cache 2>/dev/null | cut -f1)
echo "  Current cache size: $CACHE_SIZE"

# Clean old statsig evaluations
OLD_EVALS=$(find data/cache/statsig -name "*.evaluations.*" -mtime +7 2>/dev/null | wc -l)
if [ "$OLD_EVALS" -gt 0 ]; then
    echo "  Found $OLD_EVALS old evaluation files"
    run_or_show find data/cache/statsig -name "*.evaluations.*" -mtime +7 -delete
fi

# Remove empty todo files
echo ""
echo "🧹 Cleaning empty todo files..."
EMPTY_TODOS=$(find data/todos -name "*.json" -size 0 2>/dev/null | wc -l)
if [ "$EMPTY_TODOS" -gt 0 ]; then
    echo "  Found $EMPTY_TODOS empty todo files"
    run_or_show find data/todos -name "*.json" -size 0 -delete
else
    echo "  No empty todo files found"
fi

# Check for corrupted JSON files
echo ""
echo "🧹 Checking for corrupted JSON files..."
CORRUPTED=0
for file in data/todos/*.json; do
    if [ -f "$file" ] && ! jq empty "$file" >/dev/null 2>&1; then
        echo "  ⚠️  Corrupted JSON: $file"
        CORRUPTED=$((CORRUPTED + 1))
    fi
done

if [ "$CORRUPTED" -eq 0 ]; then
    echo "  ✓ All JSON files are valid"
else
    echo "  Found $CORRUPTED corrupted files (manual review needed)"
fi

# Summary
echo ""
echo "📊 Cleanup Summary:"
echo "  Cache size: $(du -sh data/cache 2>/dev/null | cut -f1)"
echo "  Active projects: $(ls -1d projects/active/*/ 2>/dev/null | wc -l)"
echo "  Archived projects: $(ls -1d projects/archived/*/ 2>/dev/null | wc -l)"
echo "  Todo files: $(ls -1 data/todos/*.json 2>/dev/null | wc -l)"
echo "  Snapshot files: $(ls -1 data/snapshots/*.sh 2>/dev/null | wc -l)"

if [ "$DRY_RUN" = "true" ]; then
    echo ""
    echo "This was a dry run. To actually perform cleanup:"
    echo "  $0 $DAYS_OLD false"
fi