# Codebase Exploration Guide

This document provides guidance for partitioning codebases into exploration areas and detecting project types.

## Dynamic Codebase Detection

### Step 1: Analyze Top-Level Structure

```bash
ls -la
```

Look for:
- Directory patterns (src/, lib/, app/, config/)
- Configuration files (package.json, Cargo.toml, etc.)
- Documentation (README.md, docs/)
- Dotfiles patterns (stow directories, *rc files)

### Step 2: Identify Project Type

| Indicator Files | Project Type |
|----------------|--------------|
| `package.json`, `node_modules/` | Node.js/JavaScript |
| `Cargo.toml`, `src/lib.rs` | Rust |
| `go.mod`, `go.sum` | Go |
| `pyproject.toml`, `setup.py` | Python |
| `Gemfile`, `*.rb` | Ruby |
| `pom.xml`, `build.gradle` | Java |
| `Makefile`, `CMakeLists.txt` | C/C++ |
| Stow dirs, `.*rc` files | Dotfiles |
| `docker-compose.yml` | Containerized App |
| `.github/workflows/` | CI/CD Enabled |

### Step 3: Detect Framework/Stack

| Indicators | Framework |
|------------|-----------|
| `next.config.js` | Next.js |
| `vite.config.*` | Vite |
| `angular.json` | Angular |
| `vue.config.js` | Vue.js |
| `django`, `settings.py` | Django |
| `flask`, `app.py` | Flask |
| `fastapi` | FastAPI |
| `rails` | Ruby on Rails |

---

## Exploration Areas by Project Type

### Dotfiles Repository

**10+ Exploration Areas:**

1. **Shell Configuration**
   - Files: `.zshrc`, `.bashrc`, `.profile`
   - Focus: Aliases, functions, environment variables, keybindings
   - Integration: FZF, syntax highlighting, autosuggestions

2. **Terminal Emulator**
   - Files: ghostty/config, alacritty.yml, kitty.conf
   - Focus: Font, colors, keybindings, performance
   - Integration: Shell, multiplexer

3. **Terminal Multiplexer**
   - Files: `.tmux.conf`, tmux scripts
   - Focus: Prefix key, plugins, theming, session management
   - Integration: Shell, vim-tmux-navigator

4. **Editor/IDE**
   - Files: nvim/init.lua, .vimrc, vscode settings
   - Focus: Plugins, keymaps, LSP, themes
   - Integration: Terminal, git, AI tools

5. **Window Management**
   - Files: aerospace.toml, yabairc, i3config
   - Focus: Layouts, keybindings, gaps, rules
   - Integration: Status bar, hotkey daemon

6. **Status Bar/Menu Bar**
   - Files: sketchybarrc, polybar, waybar
   - Focus: Plugins, styling, integrations
   - Integration: Window manager, system info

7. **Input Management**
   - Files: karabiner.json, kanata.kbd
   - Focus: Remapping, layers, home row mods
   - Integration: System-wide

8. **Git Configuration**
   - Files: .gitconfig, git hooks
   - Focus: Aliases, credentials, signing
   - Integration: Editor, shell aliases

9. **Package Management**
   - Files: Brewfile, package lists
   - Focus: Dependencies, auto-update
   - Integration: Shell functions

10. **Session Management**
    - Files: sesh.toml, tmuxinator configs
    - Focus: Project sessions, previews
    - Integration: Tmux, FZF

11. **Prompt/Theming**
    - Files: starship.toml, p10k.zsh
    - Focus: Segments, colors, icons
    - Integration: Shell, git

12. **Documentation**
    - Files: README.md, CLAUDE.md, docs/
    - Focus: Structure, accuracy, completeness
    - Integration: All components

---

### Web Application (JavaScript/TypeScript)

**10+ Exploration Areas:**

1. **Frontend Components**
   - Directory: src/components/, app/
   - Focus: Component structure, props, state
   - Integration: Styling, routing

2. **Pages/Routes**
   - Directory: pages/, app/, routes/
   - Focus: Routing logic, layouts, middleware
   - Integration: Components, API

3. **State Management**
   - Files: store/, context/, redux/
   - Focus: Actions, reducers, selectors
   - Integration: Components, API

4. **API Layer**
   - Directory: api/, services/, lib/
   - Focus: Endpoints, fetching, caching
   - Integration: State, backend

5. **Backend/Server**
   - Directory: server/, api routes
   - Focus: Handlers, middleware, auth
   - Integration: Database, frontend

6. **Database/Models**
   - Directory: models/, prisma/, drizzle/
   - Focus: Schema, migrations, queries
   - Integration: API, validation

7. **Authentication**
   - Files: auth/, middleware/auth
   - Focus: Sessions, tokens, providers
   - Integration: API, frontend

8. **Configuration**
   - Files: .env*, config/, next.config.js
   - Focus: Environment, build settings
   - Integration: All layers

9. **Testing**
   - Directory: __tests__/, test/, cypress/
   - Focus: Unit, integration, e2e
   - Integration: All components

10. **Build/Deploy**
    - Files: Dockerfile, CI configs, vercel.json
    - Focus: Build process, deployment
    - Integration: All source

11. **Styling**
    - Directory: styles/, components/*.css
    - Focus: Theme, components, utilities
    - Integration: Components

12. **Types/Validation**
    - Files: types/, schemas/, zod/
    - Focus: Type definitions, validation
    - Integration: API, forms

---

### Library/Package

**10+ Exploration Areas:**

1. **Core Functionality**
   - Directory: src/core/, lib/
   - Focus: Main exports, logic
   - Integration: Public API

2. **Public API**
   - Files: src/index.ts, exports
   - Focus: What users import
   - Integration: Core, types

3. **Internal Utilities**
   - Directory: src/utils/, src/internal/
   - Focus: Helper functions
   - Integration: Core

4. **Type Definitions**
   - Files: types/, *.d.ts
   - Focus: Public types, generics
   - Integration: API, docs

5. **Testing**
   - Directory: test/, __tests__/
   - Focus: Coverage, edge cases
   - Integration: All source

6. **Documentation**
   - Directory: docs/, README.md
   - Focus: API docs, examples
   - Integration: Public API

7. **Examples**
   - Directory: examples/, demo/
   - Focus: Usage patterns
   - Integration: Public API

8. **Build Configuration**
   - Files: tsconfig.json, rollup.config.js
   - Focus: Outputs, targets
   - Integration: Source

9. **CI/CD**
   - Directory: .github/workflows/
   - Focus: Testing, publishing
   - Integration: Tests, build

10. **Dependencies**
    - Files: package.json, lock files
    - Focus: Runtime, dev, peer
    - Integration: Build, tests

---

## Agent Prompt Templates

### General Exploration Prompt

```
Thoroughly explore [AREA] in this repository:

1. List all files related to [AREA]
2. Read key configuration files completely
3. Document:
   - File locations with line counts
   - Key settings and patterns
   - Integration points with other components
   - Critical constraints or warnings
   - Important functions or configurations to preserve

Return a comprehensive summary with specific file references and line numbers where applicable.
```

### Focused Exploration Prompts

**For Shell/Terminal:**
```
Explore shell configuration in this repository:

1. Find all shell config files (.zshrc, .bashrc, etc.)
2. Document:
   - Custom functions (name, purpose, line numbers)
   - Aliases (complete list)
   - Keybindings
   - Plugin integrations
   - Environment variables
   - Critical functions that should NOT be modified

Return with specific file:line references.
```

**For Editor Configuration:**
```
Explore editor/IDE configuration in this repository:

1. Find all editor config files (nvim/, .vimrc, vscode/)
2. Document:
   - Plugin list with purposes
   - Custom keymaps
   - LSP configuration
   - Theme/appearance settings
   - File type settings
   - AI integrations

Return with file paths and line counts.
```

**For Window Management:**
```
Explore window management configuration:

1. Find window manager configs (aerospace, yabai, i3, etc.)
2. Document:
   - Layout settings
   - Keybindings (complete list)
   - Workspace rules
   - Application-specific rules
   - Integration with status bar
   - Service management commands

Return with accurate file paths and line numbers.
```

---

## Parallel Execution Guidelines

### Minimum Agents: 10

For comprehensive coverage, always launch at least 10 exploration agents.

### Launch Pattern

```
Task 1: [Area 1] - run_in_background: true
Task 2: [Area 2] - run_in_background: true
...
Task 10+: [Area N] - run_in_background: true
```

**CRITICAL**: Launch ALL in a SINGLE message.

### Collecting Results

After launching, use `TaskOutput` to collect each agent's findings:

```
TaskOutput(task_id: agent_1_id)
TaskOutput(task_id: agent_2_id)
...
```

### Handling Large Codebases

If a codebase is very large:
1. Increase to 15-20 exploration areas
2. Make areas more specific
3. Focus on configuration over source code

### Handling Small Codebases

If a codebase is small:
1. Still use 10 agents for thoroughness
2. Some areas may have minimal findings (that's OK)
3. Document what's NOT present as well
