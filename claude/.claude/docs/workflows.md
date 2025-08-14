# Common Workflows

Collection of proven workflows and patterns for using your Claude workspace effectively.

## 🚀 Project Workflows

### Starting a New Project

#### 1. Basic Project Setup
```bash
# Navigate to project directory
cd ~/Code/my-new-project

# Start Claude Code
claude code

# Project automatically appears in projects/active/
```

#### 2. Project with Custom Configuration
```bash
# Create project-specific settings (optional)
echo '{"projectType": "web-app", "framework": "react"}' > CLAUDE.md

# Start with specific requirements
claude code --resume  # Continue previous session if exists
```

### Active Development Workflow

#### Daily Development Cycle
1. **Morning Setup:**
   ```
   - Start Claude in project directory
   - Review yesterday's todos: "Show me outstanding tasks"
   - Check recent changes: "What did we work on last?"
   ```

2. **Development Work:**
   ```
   - Use agents for specialized tasks
   - Keep detailed todo lists
   - Document decisions and solutions
   ```

3. **End of Day:**
   ```
   - Archive completed todos
   - Document next steps
   - Consider backing up if significant progress made
   ```

#### Multi-Agent Workflow
```
1. Research Phase:
   - Use general-purpose agent for exploration
   - "Research best practices for implementing authentication in React"

2. Planning Phase:
   - Create detailed todo list
   - "Break down the authentication implementation into specific tasks"

3. Implementation Phase:
   - Use code-analysis agent for reviews
   - "Review this authentication code for security issues"

4. Documentation Phase:
   - Use documentation agent
   - "Create API documentation for the authentication endpoints"
```

### Project Completion Workflow

#### 1. Final Review
```bash
# Use code-analysis agent for final review
"Perform a comprehensive security and quality review of the entire codebase"

# Generate final documentation
"Create comprehensive README and documentation for deployment"
```

#### 2. Archiving
```bash
# Archive the project
./tools/scripts/archive-project.sh -Users-$(whoami)-Code-my-project

# Create project snapshot
./tools/scripts/backup-workspace.sh minimal
```

## 🤖 Agent Usage Patterns

### Research and Discovery Workflow

#### Deep Research Pattern
```
1. Initial Query:
   Agent: general-purpose
   Task: "Research modern approaches to {technology/problem}"

2. Focused Analysis:
   Agent: general-purpose  
   Task: "Compare the top 3 approaches and provide detailed pros/cons"

3. Implementation Research:
   Agent: general-purpose
   Task: "Find specific implementation examples and code patterns"

4. Decision Documentation:
   Agent: documentation
   Task: "Document the research findings and final technology choice"
```

#### Code Exploration Pattern
```
1. Codebase Overview:
   Agent: general-purpose
   Task: "Analyze the structure and architecture of this codebase"

2. Specific Component Analysis:
   Agent: code-analysis
   Task: "Analyze the {component} for potential improvements"

3. Implementation Planning:
   Agent: general-purpose
   Task: "Plan the implementation approach for {new feature}"
```

### Development Workflow Patterns

#### Feature Development Pattern
```
1. Planning:
   - Use general-purpose agent for initial research
   - Break down into tasks with todo list
   - Document approach and architecture decisions

2. Implementation:
   - Code the feature with regular agent consultation
   - Use code-analysis agent for ongoing reviews
   - Maintain todo list progress

3. Testing and Review:
   - Use code-analysis agent for comprehensive review
   - Test implementation thoroughly
   - Update documentation

4. Documentation:
   - Use documentation agent for user-facing docs
   - Update code comments and internal documentation
```

#### Bug Investigation Pattern
```
1. Problem Analysis:
   Agent: general-purpose
   Task: "Analyze this bug report and identify potential causes"

2. Code Investigation:
   Agent: code-analysis
   Task: "Review {suspicious files} for issues related to {bug}"

3. Solution Development:
   Agent: general-purpose
   Task: "Develop a fix for {identified issue}"

4. Testing and Validation:
   Agent: code-analysis
   Task: "Review the fix to ensure it doesn't introduce new issues"
```

### Configuration Management Patterns

#### Environment Setup Pattern
```
1. Requirements Analysis:
   Agent: setup-configuration
   Task: "Help set up development environment for {project type}"

2. Configuration:
   Agent: setup-configuration
   Task: "Configure {tools/frameworks} with best practices"

3. Documentation:
   Agent: documentation
   Task: "Create setup documentation for other developers"

4. Validation:
   Agent: general-purpose
   Task: "Test the setup process and identify any issues"
```

## 📊 Data Management Workflows

### Regular Maintenance

#### Weekly Cleanup Routine
```bash
# Every Sunday
./tools/scripts/cleanup-data.sh 7 false    # Clean week-old data
./tools/scripts/backup-workspace.sh full   # Full backup

# Review and archive old projects
ls projects/active/
# Manually archive completed projects:
./tools/scripts/archive-project.sh project-name
```

#### Monthly Archive Routine
```bash
# First of each month
./tools/scripts/cleanup-data.sh 30 false   # Clean month-old data

# Archive inactive projects (older than 30 days)
find projects/active -mtime +30 -type d -name "-Users-*" | while read project; do
    echo "Archiving old project: $(basename "$project")"
    ./tools/scripts/archive-project.sh "$(basename "$project")"
done

# Create comprehensive backup
./tools/scripts/backup-workspace.sh full ~/monthly-backups/
```

### Backup Strategies

#### Development Backup Strategy
```bash
# Before major changes
./tools/scripts/backup-workspace.sh minimal

# Daily incremental (via cron)
./tools/scripts/backup-workspace.sh data

# Weekly full backup (via cron)
./tools/scripts/backup-workspace.sh full
```

#### Project Milestone Strategy
```bash
# At project milestones
./tools/scripts/backup-workspace.sh full ~/project-milestones/$(date +%Y%m%d)-milestone/

# Before major refactoring
./tools/scripts/backup-workspace.sh data ~/pre-refactor-backup/
```

## 🔄 Integration Workflows

### Git Integration

#### Version Control Pattern
```bash
# Initialize project with Claude workspace
cd ~/Code/new-project
git init
echo "# Project with Claude Code\n\nSee .claude/ for AI development history" > README.md

# Add Claude-specific .gitignore entries
echo ".claude/data/cache/" >> .gitignore
echo ".claude/shell-snapshots/" >> .gitignore

# Commit project setup
git add .
git commit -m "Initial project setup with Claude Code integration"
```

#### Development Branch Strategy
```bash
# Start feature work
git checkout -b feature/new-feature
claude code  # Start development

# Regular commits with Claude context
git add .
git commit -m "Implement feature X

Developed with assistance from Claude Code.
See .claude/projects/active/ for development conversation history."

# Merge when complete
git checkout main
git merge feature/new-feature
```

### CI/CD Integration

#### Pre-commit Hooks
```bash
# .git/hooks/pre-commit
#!/bin/bash
cd ~/.claude
./tools/scripts/cleanup-data.sh 7 false
./tools/scripts/backup-workspace.sh config
```

#### Pipeline Integration
```yaml
# .github/workflows/claude-backup.yml
name: Claude Workspace Backup
on:
  push:
    branches: [main]
jobs:
  backup:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Backup Claude workspace
        run: |
          ~/.claude/tools/scripts/backup-workspace.sh config
          # Upload to artifact storage or cloud backup
```

## 🎯 Productivity Patterns

### Focus Session Workflow

#### Deep Work Pattern
```
1. Session Planning (5 minutes):
   - Review project status and todos
   - Set 2-3 specific goals for the session
   - Choose primary agent for the work type

2. Focused Development (45-90 minutes):
   - Work on single feature/problem
   - Use chosen agent for consistent context
   - Update todos as you progress

3. Review and Planning (10 minutes):
   - Review what was accomplished
   - Update project documentation
   - Plan next session goals
```

#### Context Switching Pattern
```
When switching between projects:
1. Archive current session todos
2. Back up current project state
3. Navigate to new project directory
4. Start new Claude session
5. Review project context and todos
```

### Learning and Experimentation

#### Technology Exploration Pattern
```
1. Create Experiment Directory:
   mkdir ~/Code/experiments/technology-name
   cd ~/Code/experiments/technology-name

2. Research Phase:
   claude code
   "Research {technology} and create a learning plan"

3. Hands-on Learning:
   "Guide me through implementing a basic {technology} example"
   "Explain the key concepts as we build"

4. Documentation:
   "Create a summary document of what we learned"

5. Archive:
   ./tools/scripts/archive-project.sh experiment-name
```

## 📈 Optimization Workflows

### Performance Monitoring

#### Workspace Performance
```bash
# Monitor workspace size
du -sh ~/.claude/

# Track growth over time
echo "$(date): $(du -sh ~/.claude/ | cut -f1)" >> ~/.claude/size-tracking.log

# Analyze largest components
du -sh ~/.claude/*/ | sort -hr
```

#### Agent Effectiveness Tracking
```bash
# Track agent usage patterns
grep -r "subagent_type" data/todos/ | cut -d'"' -f4 | sort | uniq -c | sort -nr

# Review successful workflows
grep -A5 -B5 "completed" data/todos/*.json | head -50
```

### Workflow Optimization

#### Template Development
```
Create reusable templates for common tasks:
1. Document successful workflows
2. Create agent prompt templates
3. Develop standard project structures
4. Share successful patterns with team
```

#### Automation Opportunities
```bash
# Identify repetitive tasks
history | grep claude | sort | uniq -c | sort -nr

# Create custom scripts for frequent operations
# Add to tools/scripts/ directory
# Document in tools/README.md
```

## 🔗 Advanced Integration

### IDE Integration
- Use Claude Code alongside your preferred IDE
- Keep Claude terminal open for AI assistance
- Reference Claude conversations in code comments
- Use Claude for code reviews before commits

### Team Collaboration
- Share agent templates and workflows
- Create team-specific documentation agents
- Use standardized project structures
- Document team coding standards with Claude's help

### Continuous Learning
- Regularly review and refine workflows
- Experiment with new agent combinations
- Document lessons learned
- Share insights with the community

## 📋 Workflow Checklists

### Daily Development Checklist
- [ ] Start Claude in project directory
- [ ] Review previous session notes and todos
- [ ] Set goals for current session
- [ ] Choose appropriate agents for tasks
- [ ] Update todos as work progresses
- [ ] Document key decisions and solutions
- [ ] Archive completed todos
- [ ] Plan next session

### Weekly Maintenance Checklist
- [ ] Run cleanup script
- [ ] Archive completed projects
- [ ] Create backup
- [ ] Review agent effectiveness
- [ ] Update documentation
- [ ] Plan upcoming work

### Project Completion Checklist
- [ ] Final code review with code-analysis agent
- [ ] Complete documentation with documentation agent
- [ ] Create project summary
- [ ] Archive project
- [ ] Create final backup
- [ ] Update team knowledge base