# Agent Quality Checklist

Use this checklist to validate agent quality before writing the final agent file.

---

## Pre-Write Validation

### Metadata Quality

- [ ] **Name**: Kebab-case format (e.g., `my-agent-name`)
- [ ] **Name**: Descriptive of purpose
- [ ] **Name**: Not already in use (check `.claude/agents/`)
- [ ] **Description**: Explains WHAT the agent does
- [ ] **Description**: Includes "Use this agent when..." triggers
- [ ] **Description**: Enables automatic agent discovery
- [ ] **Model**: Set appropriately (`inherit` or specific model)

### Context Accuracy

- [ ] **File Paths**: Every path mentioned has been verified to exist
- [ ] **Line Numbers**: All line references are accurate (if included)
- [ ] **Line Counts**: File sizes are correct
- [ ] **Component List**: All major components are included
- [ ] **No Stale References**: No paths from previous/outdated versions
- [ ] **Integration Points**: All component connections documented

### Constraints Section

- [ ] **Critical Functions**: All must-not-modify items identified
- [ ] **Dependencies**: External dependencies documented
- [ ] **Service Order**: Restart sequences documented (if applicable)
- [ ] **User Preferences**: Intentional settings marked as DO NOT CHANGE
- [ ] **Breaking Changes**: Potential breaking modifications warned

### Commands & Validation

- [ ] **Command Syntax**: All commands use correct syntax
- [ ] **Platform Compatibility**: Commands work on target platform
- [ ] **No Deprecated Options**: Commands use current options
- [ ] **Validation Commands**: Testing commands for each component
- [ ] **Health Checks**: System-wide validation included

### Completeness

- [ ] **All Components**: Major components have dedicated sections
- [ ] **Key Configurations**: Important settings documented
- [ ] **Common Issues**: Known problems and solutions included
- [ ] **Output Format**: Expected agent output structure defined
- [ ] **Methodology**: Clear step-by-step process described

---

## Quality Scoring

Rate each category 1-5, then calculate overall score.

| Category | Score (1-5) | Weight | Weighted |
|----------|-------------|--------|----------|
| Metadata Quality | [ ] | 2 | [ ] |
| Context Accuracy | [ ] | 3 | [ ] |
| Constraints | [ ] | 3 | [ ] |
| Commands | [ ] | 2 | [ ] |
| Completeness | [ ] | 2 | [ ] |
| **Total** | | **12** | [ ]/60 |

**Scoring Guide**:
- 50-60: Excellent - Ready for production
- 40-49: Good - Minor improvements possible
- 30-39: Acceptable - Should review weak areas
- <30: Needs Work - Address issues before writing

---

## Verification Commands

### Check File Exists
```bash
# Verify a referenced file exists
ls -la [file-path]

# Verify multiple files
for f in [file1] [file2] [file3]; do
  [ -f "$f" ] && echo "✓ $f" || echo "✗ $f MISSING"
done
```

### Check Line Counts
```bash
# Get line count for a file
wc -l [file-path]

# Compare against documented count
# If significantly different, update the agent
```

### Test Commands
```bash
# Test validation commands work
[validation-command]

# Should complete without error
echo $?  # 0 = success
```

### Verify Integration Points
```bash
# Check if integration functions exist
grep -n "[function-name]" [file-path]

# Verify service dependencies
which [service-name]
```

---

## Common Issues to Avoid

### Path Errors
❌ **Wrong**: `~/.config/tool/config.toml`
✅ **Right**: `tool/.config/tool/config.toml` (stow structure)

❌ **Wrong**: Absolute paths like `/Users/username/...`
✅ **Right**: Relative paths from repo root or `~/` paths

### Outdated Information
❌ **Wrong**: Referencing removed scripts (e.g., `validate_sesh.sh`)
✅ **Right**: Note removal with migration info

❌ **Wrong**: Old component names (e.g., yabai when using aerospace)
✅ **Right**: Current active components

### Missing Constraints
❌ **Wrong**: Not documenting critical functions
✅ **Right**: Every function with external dependencies listed

❌ **Wrong**: Generic "don't break things"
✅ **Right**: Specific file:line references

### Vague Instructions
❌ **Wrong**: "Check the configuration"
✅ **Right**: "Run `yabai --check-config` to validate"

❌ **Wrong**: "Update the settings"
✅ **Right**: "Edit `tool/.config/tool/config.toml`, line 45"

### Incomplete Methodology
❌ **Wrong**: "Review the code"
✅ **Right**: Step-by-step process with specific checks

---

## Final Checks

Before writing the agent file:

### 1. Read-Through Test
- [ ] Read the entire agent from start to finish
- [ ] Does it flow logically?
- [ ] Would a first-time user understand it?

### 2. Spot Check
- [ ] Pick 3 random file paths - do they exist?
- [ ] Pick 2 random commands - do they work?
- [ ] Pick 1 constraint - is it accurate?

### 3. Description Test
Ask: "Would Claude select this agent for these queries?"
- [ ] "[Domain] review" → Should trigger
- [ ] "Check [component]" → Should trigger
- [ ] "Help with [related task]" → Should trigger

### 4. Completeness Test
- [ ] Would this agent be useful TODAY?
- [ ] Is anything critical missing?
- [ ] Are there obvious gaps?

---

## Post-Write Verification

After writing the agent:

### 1. File Validation
```bash
# Check file was created
ls -la .claude/agents/[agent-name].md

# Check file size (should be substantial)
wc -l .claude/agents/[agent-name].md
```

### 2. Syntax Check
```bash
# View frontmatter
head -20 .claude/agents/[agent-name].md

# Ensure YAML is valid (no tabs, proper formatting)
```

### 3. Test Invocation
Try these prompts to see if the agent is selected:
- "[Domain] review"
- "Check [component] health"
- "[Trigger phrase from description]"

---

## Checklist Summary

```
PRE-WRITE
□ Metadata complete and descriptive
□ All file paths verified
□ Constraints documented
□ Commands tested
□ Sections complete

QUALITY SCORE: ___/60

FINAL CHECKS
□ Read-through complete
□ Spot checks passed
□ Description enables discovery
□ Nothing critical missing

POST-WRITE
□ File created successfully
□ Frontmatter valid
□ Agent can be invoked
```

---

## Quick Reference

### Minimum Requirements
- Name: kebab-case, descriptive
- Description: Purpose + "Use this agent when..."
- Model: `inherit` (unless specific reason)
- Sections: Architecture, Categories, Constraints, Validation, Output

### File Structure
```markdown
---
name: [name]
description: [description]
model: inherit
---

[Persona]

## Mission
## Repository Architecture
## [Domain] Categories
## Methodology
## Critical Constraints
## Validation Commands
## Output Format
```

### Path Format
- Stow repos: `component/.config/tool/file`
- Standard repos: `src/path/to/file`
- Line refs: `file.ext:123` or `file.ext:100-150`
