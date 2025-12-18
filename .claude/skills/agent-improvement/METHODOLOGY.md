# Agent Improvement Methodology

This document details the 6-phase workflow for creating and improving Claude Code agents.

## Overview

```
┌─────────────┐    ┌──────────────┐    ┌─────────────┐
│  Discovery  │ -> │ Partitioning │ -> │ Exploration │
└─────────────┘    └──────────────┘    └─────────────┘
                                              │
                                              v
┌─────────────┐    ┌──────────────┐    ┌─────────────┐
│ Validation  │ <- │  Generation  │ <- │  Synthesis  │
└─────────────┘    └──────────────┘    └─────────────┘
```

---

## Phase 1: Discovery

**Goal**: Understand current state and gather initial context.

### For Improving Existing Agents

1. **Read the existing agent file**:
   ```
   .claude/agents/[agent-name].md
   ```

2. **Analyze current state**:
   - What components are documented?
   - What file paths are referenced?
   - What constraints are listed?
   - What's potentially missing or outdated?

3. **Read project documentation**:
   - `CLAUDE.md` - Project-specific Claude guidance
   - `README.md` - Project overview and structure
   - `AGENTS.md` - Agent development guidelines (if exists)
   - `docs/` directory - Additional documentation

### For Creating New Agents

1. **Validate inputs**:
   - Agent name (kebab-case, descriptive)
   - Agent type (reviewer, workflow, guide)
   - Check agent doesn't already exist

2. **Read project documentation** (same as above)

3. **Determine agent focus**:
   - What problem will this agent solve?
   - Who will use this agent?
   - What outputs should it produce?

### Output of Phase 1

- Clear understanding of current/desired agent state
- List of documentation files read
- Initial component inventory
- Gaps to address

---

## Phase 2: Partitioning

**Goal**: Divide the codebase into logical exploration areas.

### Step 1: Analyze Repository Structure

```bash
# List top-level directories
ls -la

# Identify patterns
- Configuration directories (.config/, config/, etc.)
- Source code directories (src/, lib/, app/)
- Documentation (docs/, README files)
- Build/deploy (build/, dist/, deploy/)
- Testing (test/, tests/, __tests__/)
```

### Step 2: Detect Project Type

| Pattern | Project Type |
|---------|--------------|
| Stow directories, *rc files | Dotfiles |
| package.json, src/components | Web App (JS/TS) |
| Cargo.toml, src/lib.rs | Rust Library |
| setup.py, pyproject.toml | Python Package |
| go.mod, cmd/ | Go Application |
| Makefile, include/ | C/C++ Project |

### Step 3: Create 10+ Exploration Areas

**Minimum**: 10 areas for thorough coverage

**Adapt to project type** - see `EXPLORATION.md` for detailed area suggestions.

### Output of Phase 2

- List of 10+ exploration areas
- Brief description of each area
- Key files/patterns to look for in each

---

## Phase 3: Exploration

**Goal**: Comprehensively scan each area using parallel agents.

### Agent Configuration

```
subagent_type: Explore
run_in_background: true
```

### Prompt Template

For each exploration area, use this prompt:

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

### Execution

**CRITICAL**: Launch ALL agents in a SINGLE message with multiple Task tool calls.

Example:
```
<Task 1: Shell configs>
<Task 2: Window management>
<Task 3: Editor configs>
...
<Task 10+: Additional areas>
```

### Collecting Results

Use `TaskOutput` to collect results from all background agents:
- Wait for all agents to complete
- Aggregate findings systematically

### Output of Phase 3

- Comprehensive findings from each area
- File paths with line counts
- Configuration details
- Integration points identified
- Constraints discovered

---

## Phase 4: Synthesis

**Goal**: Aggregate exploration findings into coherent context.

### Step 1: Component Inventory

Create a complete list of all components found:
```
| Component | Files | Lines | Status |
|-----------|-------|-------|--------|
| Zsh       | 3     | 290   | Active |
| Tmux      | 5     | 234   | Active |
| ...       | ...   | ...   | ...    |
```

### Step 2: File Location Map

Document all configuration files:
```
Core Configs:
├── zsh/.zshrc                    # Shell (290 lines)
├── tmux/.tmux.conf               # Multiplexer (234 lines)
└── ...
```

### Step 3: Integration Points

Identify how components connect:
- Dependencies between components
- Shared configuration
- Event triggers (e.g., brew → SketchyBar)
- Cross-tool keybindings

### Step 4: Critical Constraints

Compile things that must NOT be modified:
- Functions with external dependencies
- Service restart sequences
- Directory structures
- User preferences

### Step 5: Validation Commands

List commands to test each component:
```bash
# Component validation
yabai --check-config
sketchybar --reload
sesh list
```

### Output of Phase 4

- Complete component inventory
- Accurate file location map
- Integration point documentation
- Constraint list
- Validation command list

---

## Phase 5: Generation

**Goal**: Create or update the agent markdown file.

### Select Template

Based on agent type:
- `reviewer` → `TEMPLATES/reviewer-agent.md`
- `workflow` → `TEMPLATES/workflow-agent.md`
- `guide` → `TEMPLATES/guide-agent.md`

### Fill Template Sections

1. **Metadata**:
   ```yaml
   ---
   name: [agent-name]
   description: [Purpose AND trigger conditions]
   model: inherit
   ---
   ```

2. **Persona**: Appropriate expert role for the domain

3. **Mission**: Clear statement of agent purpose

4. **Repository Architecture**: From synthesis (Phase 4)

5. **Category Sections**: Detailed per-component sections

6. **Constraints**: Critical "DO NOT" list

7. **Validation Commands**: Testing procedures

8. **Output Format**: Expected output structure

### Writing Guidelines

- Use specific file paths with line numbers
- Include actual configuration snippets where helpful
- Make instructions actionable, not vague
- Ensure description enables auto-discovery

### Output of Phase 5

- Complete agent markdown content
- Ready for validation

---

## Phase 6: Validation

**Goal**: Ensure agent accuracy before writing.

### Checklist

#### File Paths
- [ ] Every file path mentioned exists
- [ ] Line numbers are accurate (if referenced)
- [ ] No outdated paths from previous versions

#### Commands
- [ ] All commands use correct syntax
- [ ] Commands work on target platform
- [ ] No deprecated command options

#### Constraints
- [ ] All critical functions identified
- [ ] Service dependencies documented
- [ ] User preferences respected

#### Description
- [ ] Explains WHAT the agent does
- [ ] Explains WHEN to use the agent
- [ ] Enables automatic agent selection

#### Completeness
- [ ] All major components covered
- [ ] Integration points documented
- [ ] Validation commands included

### Verification Steps

1. **Spot-check file paths**:
   ```bash
   ls -la [referenced-path]
   ```

2. **Test commands**:
   ```bash
   # Run a sample validation command
   ```

3. **Review description**:
   - Would Claude select this agent for relevant queries?

### Output of Phase 6

- Validated agent content
- Confidence in accuracy

---

## Final Step: Write Agent

After validation passes:

1. **Write the file**:
   ```
   .claude/agents/[agent-name].md
   ```

2. **Report changes**:
   - What was added (new sections/components)
   - What was updated (corrected information)
   - What was removed (outdated content)

3. **Provide usage guidance**:
   - How to invoke the agent
   - Example queries that will trigger it
