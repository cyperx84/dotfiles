# Documentation Website Structure

> **Purpose**: Website-ready documentation structure for dotfiles repository
> **Last Updated**: 2025-11-15
> **Status**: Implementation Plan

## 🏗️ Proposed Website Structure

### Navigation Hierarchy

```
Home (README.md)
├── Getting Started
│   ├── Installation Guide
│   ├── Quick Start
│   └── First Steps
│
├── Components
│   ├── Window Management
│   │   ├── Aerospace (Primary)
│   │   ├── Yabai (Legacy/Alternative)
│   │   └── Window Manager Switching Guide
│   ├── Terminal Environment
│   │   ├── Ghostty
│   │   ├── Tmux
│   │   └── Zsh
│   ├── Development Tools
│   │   ├── Neovim
│   │   ├── Git Configuration
│   │   └── MCP Integration
│   └── Input Management
│       ├── Kanata
│       └── Karabiner-Elements
│
├── Reference
│   ├── Keybindings
│   │   ├── Window Management (Aerospace)
│   │   ├── Terminal & Session Management
│   │   ├── Neovim Keybinds
│   │   └── Quick Reference Card
│   ├── Components Deep Dive
│   └── Configuration Files
│
├── Workflows
│   ├── Session Management
│   ├── File Navigation
│   ├── Git Development
│   └── Window Management
│
├── Maintenance
│   ├── Troubleshooting
│   ├── Validation Scripts
│   ├── Service Management
│   └── Updates & Migrations
│
└── AI Assistant Guides
    ├── Claude Code Integration
    ├── Agent Development
    └── Statusline Reference
```

## 📄 Document Mapping

### Current → Website Structure

| Current File | Website Section | Category |
|--------------|----------------|----------|
| `README.md` | Home / Getting Started | Landing Page |
| `CLAUDE.md` | AI Assistant Guides | Developer Reference |
| `AGENTS.md` | AI Assistant Guides | Developer Reference |
| `WM_SWITCHING.md` | Components → Window Management | Configuration |
| `docs/COMPONENTS.md` | Components / Reference | Core Docs |
| `docs/KEYBINDS.md` | Reference → Keybindings | Quick Reference |
| `docs/NEOVIM_KEYBINDS.md` | Reference → Keybindings | Neovim Specific |
| `docs/WORKFLOW_GUIDES.md` | Workflows | Integration Guides |
| `docs/MAINTENANCE.md` | Maintenance | Operations |
| `docs/CLAUDE_STATUSLINE.md` | AI Assistant Guides | Developer Reference |
| `docs/DOCUMENTATION_STRATEGY.md` | Meta (About Docs) | Internal |

## 🎯 Website-Friendly Features

### 1. Frontmatter for Static Site Generators

All markdown files should include:

```yaml
---
title: "Document Title"
description: "Brief description for SEO"
category: "Component|Reference|Workflow|Maintenance"
tags: ["aerospace", "window-management", "macos"]
last_updated: "2025-11-15"
weight: 10  # For navigation ordering
---
```

### 2. Navigation Structure

**Recommended Static Site Generator**: VitePress, Docusaurus, or MkDocs

**Navigation Config Example** (VitePress):
```javascript
sidebar: {
  '/guide/': [
    {
      text: 'Getting Started',
      items: [
        { text: 'Installation', link: '/guide/installation' },
        { text: 'Quick Start', link: '/guide/quick-start' }
      ]
    },
    {
      text: 'Components',
      items: [
        { text: 'Window Management', link: '/components/window-management' },
        { text: 'Terminal Environment', link: '/components/terminal' }
      ]
    }
  ]
}
```

### 3. Cross-Reference Strategy

**Internal Links**: Use relative paths
```markdown
See [Aerospace Configuration](../components/aerospace.md) for details.
```

**Component References**: Use anchor links
```markdown
Configure [SketchyBar integration](components.md#sketchybar) first.
```

### 4. Search Optimization

**Algolia DocSearch Integration**:
- Index all markdown files
- Weight by document category
- Include code blocks in search
- Keyboard shortcut: `Cmd+K` or `/`

## 📱 Responsive Design Considerations

### Mobile-Friendly Formatting

1. **Tables**: Use overflow-x for wide tables
2. **Code Blocks**: Horizontal scroll with syntax highlighting
3. **Navigation**: Collapsible sidebar for mobile
4. **Search**: Prominent search bar at top

### Dark Mode Support

- Follow system preference by default
- Manual toggle in navigation
- Syntax highlighting themes for both modes

## 🔖 URL Structure

```
dotfiles.domain.com/
├── /                           # Home (README)
├── /guide/
│   ├── /installation           # Installation guide
│   ├── /quick-start            # Quick start
│   └── /switching-wm           # WM_SWITCHING.md
├── /components/
│   ├── /aerospace              # Aerospace section
│   ├── /yabai                  # Yabai (legacy)
│   ├── /ghostty                # Ghostty config
│   ├── /tmux                   # Tmux setup
│   └── /neovim                 # Neovim config
├── /reference/
│   ├── /keybinds               # Main keybinds
│   ├── /neovim-keybinds        # Neovim keybinds
│   └── /components-detail      # COMPONENTS.md
├── /workflows/
│   ├── /session-management     # Session workflows
│   ├── /file-navigation        # File workflows
│   └── /window-management      # Window workflows
├── /maintenance/
│   ├── /troubleshooting        # Troubleshooting guide
│   ├── /validation             # Validation scripts
│   └── /updates                # Update procedures
└── /ai-guides/
    ├── /claude-code            # CLAUDE.md
    ├── /agents                 # AGENTS.md
    └── /statusline             # CLAUDE_STATUSLINE.md
```

## 🎨 Visual Enhancements

### Recommended Additions

1. **Component Badges**:
   ```markdown
   ![Status](https://img.shields.io/badge/status-active-green)
   ![Platform](https://img.shields.io/badge/platform-macOS-blue)
   ```

2. **Mermaid Diagrams**:
   ```markdown
   ```mermaid
   graph LR
     A[Aerospace] --> B[SketchyBar]
     A --> C[Window Focus]
     B --> D[Space Display]
   ```
   ```

3. **Admonitions/Callouts**:
   ```markdown
   ::: warning
   Aerospace and Yabai cannot run simultaneously
   :::

   ::: tip
   Use `Shift+Ctrl+h/j/k/l` for window focus
   :::
   ```

4. **Code Tabs** (for alternatives):
   ```markdown
   ::: code-group
   ```bash [Aerospace]
   killall AeroSpace && open -a AeroSpace
   ```

   ```bash [Yabai]
   brew services restart yabai
   ```
   :::
   ```

## 📊 Analytics & Metrics

### Recommended Tracking

1. **Page Views**: Most visited documentation pages
2. **Search Terms**: What users search for
3. **Scroll Depth**: Which sections are read
4. **External Links**: Most clicked external resources

## 🚀 Deployment Strategy

### Build Process

1. **Pre-build**: Validate all internal links
2. **Build**: Generate static site
3. **Post-build**: Optimize images, minify assets
4. **Deploy**: GitHub Pages, Netlify, or Vercel

### CI/CD Pipeline

```yaml
# .github/workflows/docs-deploy.yml
name: Deploy Docs
on:
  push:
    branches: [main]
    paths: ['docs/**', 'README.md', 'CLAUDE.md']
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Build docs
        run: npm run docs:build
      - name: Deploy
        uses: peaceiris/actions-gh-pages@v3
```

## 📝 Documentation Standards

### Consistent Formatting

1. **Headings**: Use sentence case, not title case
2. **Code Blocks**: Always specify language
3. **Lists**: Use consistent bullet styles
4. **Tables**: Align columns for readability
5. **Links**: Use descriptive text, not "click here"

### Accessibility

1. **Alt Text**: All images need descriptions
2. **Headings**: Proper hierarchy (h1 → h2 → h3)
3. **Contrast**: Ensure readable color combinations
4. **Keyboard Nav**: All interactive elements accessible

## 🔄 Migration Checklist

- [ ] Add frontmatter to all docs
- [ ] Update cross-references to new structure
- [ ] Create component-specific pages
- [ ] Add navigation configuration
- [ ] Set up search indexing
- [ ] Configure deployment pipeline
- [ ] Test mobile responsiveness
- [ ] Validate all internal links
- [ ] Add visual enhancements (badges, diagrams)
- [ ] Set up analytics tracking

## 📚 Future Enhancements

1. **Interactive Demos**: Embedded terminal examples
2. **Video Walkthroughs**: Screen recordings for complex workflows
3. **Versioning**: Document changes across dotfiles versions
4. **Community**: Comments, feedback forms
5. **Translations**: Multi-language support (if needed)

---

*This structure provides a scalable, maintainable foundation for a comprehensive dotfiles documentation website.*
