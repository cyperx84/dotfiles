#!/usr/bin/env python3
"""
Extract tags from Obsidian vault YAML frontmatter.
Usage: python extract-tags.py [action] [tag]
Actions:
  list - List all unique tags
  find <tag> - Find files containing a specific tag
"""

import sys
from pathlib import Path
import re

VAULT_PATH = Path.home() / "Library/Mobile Documents/iCloud~md~obsidian/Documents/notes"


def extract_tags_from_content(content):
    """Extract tags from YAML frontmatter using simple parsing."""
    if not content.startswith('---'):
        return []

    lines = content.split('\n')
    in_frontmatter = False
    in_tags_section = False
    tags = []

    for i, line in enumerate(lines):
        # First ---
        if i == 0 and line.strip() == '---':
            in_frontmatter = True
            continue

        # Second ---
        if in_frontmatter and line.strip() == '---':
            break

        if not in_frontmatter:
            continue

        # Found tags: line
        if line.strip().startswith('tags:'):
            in_tags_section = True
            # Check for inline array format: tags: [tag1, tag2]
            inline_match = re.search(r'tags:\s*\[(.*?)\]', line)
            if inline_match:
                tag_str = inline_match.group(1)
                tags = [t.strip().strip('"\'') for t in tag_str.split(',') if t.strip()]
                break
            continue

        # Tag list item
        if in_tags_section and line.startswith('  - '):
            tag = line[4:].strip()  # Remove "  - " prefix
            if tag and not tag.startswith('['):  # Skip non-tag list items
                tags.append(tag)
            continue

        # End of tags section (new YAML key)
        if in_tags_section and line and line[0].isalpha() and ':' in line:
            break

    return tags


def get_all_tags():
    """Get all unique tags from all markdown files in vault."""
    tags = set()

    for md_file in VAULT_PATH.rglob('*.md'):
        try:
            content = md_file.read_text(encoding='utf-8')
            file_tags = extract_tags_from_content(content)
            tags.update(file_tags)
        except Exception:
            # Skip files that can't be read
            pass

    return sorted(tags)


def find_files_with_tag(target_tag):
    """Find all files containing a specific tag."""
    files = []

    for md_file in VAULT_PATH.rglob('*.md'):
        try:
            content = md_file.read_text(encoding='utf-8')
            file_tags = extract_tags_from_content(content)

            if target_tag in file_tags:
                files.append(md_file.relative_to(VAULT_PATH))
        except Exception:
            pass

    return sorted(files)


def main():
    if len(sys.argv) < 2:
        print("Usage: extract-tags.py [list|find] [tag]", file=sys.stderr)
        sys.exit(1)

    action = sys.argv[1]

    if action == 'list':
        tags = get_all_tags()
        for tag in tags:
            print(tag)

    elif action == 'find':
        if len(sys.argv) < 3:
            print("Usage: extract-tags.py find <tag>", file=sys.stderr)
            sys.exit(1)

        target_tag = sys.argv[2]
        files = find_files_with_tag(target_tag)
        for file in files:
            print(file)

    else:
        print(f"Unknown action: {action}", file=sys.stderr)
        sys.exit(1)


if __name__ == '__main__':
    main()
