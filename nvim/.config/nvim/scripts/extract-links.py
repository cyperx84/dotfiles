#!/usr/bin/env python3
"""
Extract wiki-links and backlinks from Obsidian vault.
Usage:
  python extract-links.py links <file>         - Get outgoing links from file
  python extract-links.py backlinks <file>     - Get backlinks to file
  python extract-links.py all-links            - Get all wiki-links in vault
"""

import sys
import re
from pathlib import Path
from collections import defaultdict

VAULT_PATH = Path.home() / "Library/Mobile Documents/iCloud~md~obsidian/Documents/notes"

# Regex patterns for wiki-links
WIKI_LINK_PATTERN = re.compile(r'\[\[([^\]|#]+)(?:[|#][^\]]*)?\]\]')


def normalize_link(link):
    """Normalize a link for comparison (remove .md extension, strip whitespace)."""
    link = link.strip()
    if link.endswith('.md'):
        link = link[:-3]
    return link


def extract_links_from_file(file_path):
    """Extract all wiki-links from a file."""
    try:
        content = file_path.read_text(encoding='utf-8')
        links = []

        # Find all [[wiki-links]]
        for match in WIKI_LINK_PATTERN.finditer(content):
            link = match.group(1).strip()
            if link:
                links.append(normalize_link(link))

        return list(set(links))  # Return unique links
    except Exception:
        return []


def resolve_link_to_file(link_text):
    """Try to resolve a link text to an actual file in the vault."""
    # Try exact match with .md
    exact_file = VAULT_PATH / f"{link_text}.md"
    if exact_file.exists():
        return exact_file.relative_to(VAULT_PATH)

    # Try case-insensitive search
    for md_file in VAULT_PATH.rglob('*.md'):
        if md_file.stem.lower() == link_text.lower():
            return md_file.relative_to(VAULT_PATH)

    # Try searching in subdirectories
    for md_file in VAULT_PATH.rglob('*.md'):
        if normalize_link(md_file.stem) == normalize_link(link_text):
            return md_file.relative_to(VAULT_PATH)

    return None


def get_outgoing_links(file_path):
    """Get all outgoing links from a specific file."""
    if not file_path.exists():
        return []

    links = extract_links_from_file(file_path)

    # Try to resolve each link to an actual file
    results = []
    for link in links:
        resolved = resolve_link_to_file(link)
        if resolved:
            results.append({
                'link_text': link,
                'target_file': str(resolved),
                'exists': True
            })
        else:
            results.append({
                'link_text': link,
                'target_file': None,
                'exists': False
            })

    return results


def get_backlinks(target_file):
    """Find all files that link to the target file."""
    target_path = VAULT_PATH / target_file
    if not target_path.exists():
        return []

    # Possible link texts that could refer to this file
    target_stem = target_path.stem
    possible_links = {
        normalize_link(target_stem),
        normalize_link(target_file),
        normalize_link(str(target_file))
    }

    backlinks = []

    # Search all markdown files
    for md_file in VAULT_PATH.rglob('*.md'):
        if md_file == target_path:
            continue  # Skip the target file itself

        links = extract_links_from_file(md_file)

        # Check if any links match our target
        for link in links:
            normalized = normalize_link(link)
            if normalized in possible_links:
                relative_path = md_file.relative_to(VAULT_PATH)
                backlinks.append({
                    'source_file': str(relative_path),
                    'link_text': link
                })
                break  # Only add each file once

    return backlinks


def get_all_links():
    """Get all wiki-links in the vault."""
    all_links = set()

    for md_file in VAULT_PATH.rglob('*.md'):
        links = extract_links_from_file(md_file)
        all_links.update(links)

    return sorted(all_links)


def main():
    if len(sys.argv) < 2:
        print("Usage: extract-links.py [links|backlinks|all-links] [file]", file=sys.stderr)
        sys.exit(1)

    action = sys.argv[1]

    if action == 'links':
        if len(sys.argv) < 3:
            print("Usage: extract-links.py links <file>", file=sys.stderr)
            sys.exit(1)

        file_path = VAULT_PATH / sys.argv[2]
        results = get_outgoing_links(file_path)

        # Output format: link_text|target_file|exists
        for result in results:
            target = result['target_file'] if result['target_file'] else result['link_text']
            exists = 'exists' if result['exists'] else 'missing'
            print(f"{result['link_text']}|{target}|{exists}")

    elif action == 'backlinks':
        if len(sys.argv) < 3:
            print("Usage: extract-links.py backlinks <file>", file=sys.stderr)
            sys.exit(1)

        target_file = sys.argv[2]
        results = get_backlinks(target_file)

        # Output format: source_file|link_text
        for result in results:
            print(f"{result['source_file']}|{result['link_text']}")

    elif action == 'all-links':
        links = get_all_links()
        for link in links:
            print(link)

    else:
        print(f"Unknown action: {action}", file=sys.stderr)
        sys.exit(1)


if __name__ == '__main__':
    main()
