# Customization Guide

Complete guide for customizing your Claude workspace to match your development style and requirements.

## 🎨 Visual Customization

### Status Line Customization

#### Custom Directory Icons
Modify the status line in `config/settings.json` to add custom icons:

```json
{
  "statusLine": {
    "type": "command",
    "command": "input=$(cat); dir=$(echo \"$input\" | jq -r '.workspace.current_dir'); model=$(echo \"$input\" | jq -r '.model.display_name'); printf '\\033[1;32m󰯈\\033[0m \\033[1;33m%s\\033[0m \\033[1;36m%s\\033[0m' \"$(basename \"$dir\" | sed 's/^notes$/󰠮/g' | sed 's/^Code$/󰨞/g' | sed 's/^my-project$/󰎯/g')\" \"$model\""
  }
}
```

#### Common Directory Icons
```bash
# Web development
sed 's/^frontend$/󰜈/g'
sed 's/^backend$/󰒋/g'
sed 's/^api$/󰘳/g'

# Languages
sed 's/^python$/󰌠/g'
sed 's/^javascript$/󰌞/g'
sed 's/^typescript$/󰛦/g'
sed 's/^rust$/󱘗/g'
sed 's/^go$/󰟓/g'

# Frameworks
sed 's/^react$/󰜈/g'
sed 's/^vue$/󰡄/g'
sed 's/^angular$/󰚸/g'
sed 's/^django$/󰹩/g'

# Tools
sed 's/^docker$/󰡨/g'
sed 's/^kubernetes$/󱃾/g'
sed 's/^terraform$/󱁢/g'
```

#### Alternative Status Line Formats

**Minimal Status:**
```json
{
  "statusLine": {
    "type": "simple",
    "template": "{model} in {workspace.name}"
  }
}
```

**Detailed Status:**
```json
{
  "statusLine": {
    "type": "command",
    "command": "input=$(cat); dir=$(echo \"$input\" | jq -r '.workspace.current_dir'); model=$(echo \"$input\" | jq -r '.model.display_name'); time=$(date +'%H:%M'); printf '\\033[1;32m󰯈\\033[0m \\033[1;33m%s\\033[0m \\033[1;36m%s\\033[0m \\033[1;90m%s\\033[0m' \"$(basename \"$dir\")\" \"$model\" \"$time\""
  }
}
```

### Color Themes
Customize colors in the status line command:

```bash
# Color codes
\033[1;31m  # Bright Red
\033[1;32m  # Bright Green  
\033[1;33m  # Bright Yellow
\033[1;34m  # Bright Blue
\033[1;35m  # Bright Magenta
\033[1;36m  # Bright Cyan
\033[1;37m  # Bright White
\033[1;90m  # Bright Black (Gray)
\033[0m     # Reset
```

## 🤖 Agent Customization

### Creating Specialized Agents

#### Domain-Specific Agent Template
```json
{
  "name": "web-security-agent",
  "description": "Specialized agent for web application security analysis",
  "type": "specialized",
  "domain": "cybersecurity",
  "capabilities": [
    "Security vulnerability scanning",
    "OWASP compliance checking",
    "Penetration testing guidance",
    "Security best practices",
    "Code security review"
  ],
  "tools": [
    "Read", "Grep", "Glob", "Edit", "Bash", "WebFetch"
  ],
  "security_focus": [
    "Input validation",
    "Authentication flaws", 
    "Authorization issues",
    "XSS vulnerabilities",
    "SQL injection",
    "CSRF protection"
  ],
  "frameworks": [
    "OWASP Top 10",
    "CWE/SANS Top 25",
    "NIST Cybersecurity Framework"
  ],
  "prompt_template": "Analyze {target} for security vulnerabilities focusing on {security_areas}. Apply {security_framework} guidelines and provide specific remediation steps with code examples."
}
```

#### Project-Type Specific Agents

**React Development Agent:**
```json
{
  "name": "react-dev-agent",
  "description": "Specialized React development assistant",
  "type": "specialized",
  "domain": "react-development",
  "capabilities": [
    "React best practices",
    "Performance optimization",
    "Testing strategies",
    "State management",
    "Component architecture"
  ],
  "tools": ["Read", "Edit", "MultiEdit", "Bash", "Grep", "Glob"],
  "react_expertise": [
    "Hooks optimization",
    "Component lifecycle",
    "Performance profiling",
    "Testing with Jest/RTL",
    "State management patterns"
  ],
  "prompt_template": "Help with React development for {component/feature}. Focus on {react_concept} following modern React best practices and {specific_requirements}."
}
```

**DevOps Agent:**
```json
{
  "name": "devops-agent",
  "description": "Infrastructure and deployment specialist",
  "type": "specialized",
  "domain": "devops",
  "capabilities": [
    "Infrastructure as code",
    "CI/CD pipeline design",
    "Container orchestration",
    "Monitoring and logging",
    "Security hardening"
  ],
  "tools": ["Bash", "Read", "Write", "Edit", "WebFetch"],
  "devops_areas": [
    "Docker containerization",
    "Kubernetes deployment",
    "Terraform infrastructure",
    "GitHub Actions",
    "AWS/Azure/GCP"
  ],
  "prompt_template": "Help with {devops_task} for {environment}. Focus on {specific_technology} following {cloud_provider} best practices."
}
```

### Agent Prompt Engineering

#### Effective Prompt Templates
```json
{
  "context_rich_template": "You are a {role} working on {project_type}. The current task is {task}. Consider {constraints} and follow {standards}. Provide {output_format} with {detail_level}.",
  
  "iterative_template": "This is step {step_number} of {total_steps} in {process_name}. Previous context: {previous_results}. Current objective: {current_objective}.",
  
  "review_template": "Review {artifact_type} for {review_criteria}. Rate {rating_scale} and provide {feedback_format}. Focus on {priority_areas}."
}
```

#### Prompt Variables System
Create a variables file for consistent prompting:

```json
{
  "variables": {
    "project_types": ["web-app", "api", "cli-tool", "library"],
    "review_criteria": ["security", "performance", "maintainability", "scalability"],
    "output_formats": ["markdown", "json", "code-comments", "documentation"],
    "detail_levels": ["summary", "detailed", "comprehensive", "executive"]
  }
}
```

## 📁 Project Structure Customization

### Custom Project Templates

#### Create Project Template Directory
```bash
mkdir -p tools/templates/projects
```

#### Web Application Template
```bash
# tools/templates/projects/web-app.sh
#!/bin/bash
PROJECT_NAME="$1"
mkdir -p "$PROJECT_NAME"/{src,tests,docs,config}
touch "$PROJECT_NAME"/README.md
echo "# $PROJECT_NAME" > "$PROJECT_NAME"/README.md
echo '{"projectType": "web-app", "framework": "react"}' > "$PROJECT_NAME"/CLAUDE.md
```

#### API Project Template
```bash
# tools/templates/projects/api.sh
#!/bin/bash
PROJECT_NAME="$1"
mkdir -p "$PROJECT_NAME"/{src/{routes,models,middleware},tests,docs}
touch "$PROJECT_NAME"/{README.md,requirements.txt,.env.example}
echo '{"projectType": "api", "framework": "fastapi"}' > "$PROJECT_NAME"/CLAUDE.md
```

### Directory Organization Schemes

#### By Feature (Domain-Driven)
```
src/
├── auth/
├── user-management/
├── payment/
├── reporting/
└── shared/
```

#### By Layer (Traditional)
```
src/
├── controllers/
├── models/
├── views/
├── services/
└── utils/
```

#### By Component (Component-Based)
```
src/
├── components/
├── hooks/
├── contexts/
├── utils/
└── styles/
```

## 🛠️ Tool Customization

### Custom Utility Scripts

#### Project Statistics Script
```bash
#!/bin/bash
# tools/scripts/project-stats.sh

PROJECT_DIR="$1"
if [ -z "$PROJECT_DIR" ]; then
    PROJECT_DIR="."
fi

echo "📊 Project Statistics for $(basename "$PROJECT_DIR")"
echo "=============================================="
echo ""
echo "📁 File Counts:"
find "$PROJECT_DIR" -name "*.js" -o -name "*.ts" -o -name "*.jsx" -o -name "*.tsx" | wc -l | xargs echo "  TypeScript/JavaScript files:"
find "$PROJECT_DIR" -name "*.py" | wc -l | xargs echo "  Python files:"
find "$PROJECT_DIR" -name "*.md" | wc -l | xargs echo "  Markdown files:"
echo ""
echo "📈 Code Metrics:"
find "$PROJECT_DIR" -name "*.js" -o -name "*.ts" -o -name "*.jsx" -o -name "*.tsx" -o -name "*.py" | xargs wc -l | tail -1 | xargs echo "  Total lines of code:"
echo ""
echo "🗂️ Directory Structure:"
tree -L 2 "$PROJECT_DIR" 2>/dev/null || find "$PROJECT_DIR" -type d -maxdepth 2
```

#### Environment Setup Script
```bash
#!/bin/bash
# tools/scripts/setup-dev-env.sh

PROJECT_TYPE="$1"
PROJECT_NAME="$2"

case "$PROJECT_TYPE" in
    "react")
        npx create-react-app "$PROJECT_NAME" --template typescript
        cd "$PROJECT_NAME"
        echo '{"projectType": "react", "framework": "create-react-app"}' > CLAUDE.md
        ;;
    "fastapi")
        mkdir "$PROJECT_NAME"
        cd "$PROJECT_NAME"
        python -m venv venv
        source venv/bin/activate
        pip install fastapi uvicorn
        echo '{"projectType": "api", "framework": "fastapi"}' > CLAUDE.md
        ;;
    "golang")
        mkdir "$PROJECT_NAME"
        cd "$PROJECT_NAME"
        go mod init "$PROJECT_NAME"
        echo '{"projectType": "cli", "language": "go"}' > CLAUDE.md
        ;;
esac

claude code
```

### IDE Integration Scripts

#### VS Code Integration
```bash
#!/bin/bash
# tools/scripts/open-in-vscode.sh

PROJECT_PATH="$1"
if [ -z "$PROJECT_PATH" ]; then
    PROJECT_PATH="."
fi

# Open in VS Code
code "$PROJECT_PATH"

# Also start Claude Code in terminal
gnome-terminal --working-directory="$PROJECT_PATH" -e "claude code" &
```

#### Vim Integration
```bash
# tools/scripts/vim-claude-session.sh
#!/bin/bash

# Create tmux session with vim and claude
SESSION_NAME="dev-$(basename $(pwd))"

tmux new-session -d -s "$SESSION_NAME"
tmux split-window -h
tmux select-pane -t 0
tmux send-keys 'vim .' Enter
tmux select-pane -t 1  
tmux send-keys 'claude code' Enter
tmux attach-session -t "$SESSION_NAME"
```

## 📊 Data Customization

### Custom Todo Management

#### Priority-Based Todo System
```json
{
  "id": "task-id",
  "content": "Task description",
  "status": "pending|in_progress|completed",
  "priority": "high|medium|low",
  "tags": ["frontend", "bug-fix"],
  "estimated_hours": 2,
  "actual_hours": 1.5,
  "created_at": "ISO-8601-datetime",
  "due_date": "ISO-8601-date"
}
```

#### Category-Based Organization
```bash
# tools/scripts/organize-todos.sh
#!/bin/bash

TODO_DIR="data/todos"
ORGANIZED_DIR="data/todos-organized"

mkdir -p "$ORGANIZED_DIR"/{high-priority,medium-priority,low-priority,completed}

for file in "$TODO_DIR"/*.json; do
    priority=$(jq -r '.[0].priority // "medium"' "$file")
    status=$(jq -r '.[0].status' "$file")
    
    if [ "$status" = "completed" ]; then
        cp "$file" "$ORGANIZED_DIR/completed/"
    else
        cp "$file" "$ORGANIZED_DIR/${priority}-priority/"
    fi
done
```

### Custom Backup Strategies

#### Selective Backup Script
```bash
#!/bin/bash
# tools/scripts/selective-backup.sh

BACKUP_TYPE="$1"
CUSTOM_DIR="$2"

case "$BACKUP_TYPE" in
    "code-only")
        tar -czf "backup-code-$(date +%Y%m%d).tar.gz" \
            --exclude="node_modules" \
            --exclude="venv" \
            --exclude=".git" \
            --exclude="data/cache" \
            projects/active/ agents/subagents/ tools/scripts/
        ;;
    "config-sync") 
        rsync -av config/ "$CUSTOM_DIR/claude-config/"
        rsync -av agents/templates/ "$CUSTOM_DIR/claude-agents/"
        ;;
    "project-specific")
        PROJECT="$CUSTOM_DIR"
        tar -czf "backup-${PROJECT}-$(date +%Y%m%d).tar.gz" \
            "projects/active/$PROJECT" \
            "data/todos/*$PROJECT*"
        ;;
esac
```

## 🔌 Integration Customization

### Git Integration

#### Custom Git Hooks
```bash
# .git/hooks/pre-commit
#!/bin/bash

# Run Claude workspace cleanup before commits
cd ~/.claude
./tools/scripts/cleanup-data.sh 7 false > /dev/null

# Add Claude context to commit if available
CLAUDE_CONTEXT=$(find data/todos -name "*.json" -mtime -1 | head -1)
if [ -n "$CLAUDE_CONTEXT" ]; then
    echo "Recent Claude work context available in .claude/"
fi
```

#### Commit Message Templates
```bash
# .gitmessage template
# feat|fix|docs|style|refactor|test|chore: brief description

# What and why (not how):
# - 

# Claude Code assistance:
# - Agent used: 
# - Key insights: 

# Breaking changes:
# - 

# Closes #issue
```

### External Tool Integration

#### Slack Notifications
```bash
#!/bin/bash
# tools/scripts/notify-slack.sh

WEBHOOK_URL="your-slack-webhook-url"
MESSAGE="$1"

curl -X POST -H 'Content-type: application/json' \
    --data "{\"text\":\"Claude Workspace: $MESSAGE\"}" \
    "$WEBHOOK_URL"
```

#### Email Reports
```bash
#!/bin/bash
# tools/scripts/weekly-report.sh

REPORT_FILE="/tmp/claude-weekly-report.txt"

echo "Claude Workspace Weekly Report" > "$REPORT_FILE"
echo "=============================" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

echo "Active Projects:" >> "$REPORT_FILE"
ls -1 projects/active/ >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

echo "Completed Tasks This Week:" >> "$REPORT_FILE"
find data/todos -name "*.json" -mtime -7 -exec jq -r '.[] | select(.status=="completed") | .content' {} \; >> "$REPORT_FILE"

# Send email (configure mail command)
mail -s "Claude Workspace Weekly Report" your-email@domain.com < "$REPORT_FILE"
```

## 🎛️ Environment-Specific Customization

### Development Environment
```json
{
  "dev": {
    "statusLine": {
      "showDebugInfo": true,
      "verboseOutput": true
    },
    "agents": {
      "defaultTimeout": 300,
      "debugMode": true
    },
    "tools": {
      "enableExperimentalScripts": true
    }
  }
}
```

### Production Environment
```json
{
  "prod": {
    "statusLine": {
      "minimal": true,
      "showOnlyEssentials": true
    },
    "agents": {
      "restrictedMode": true,
      "auditLogging": true
    },
    "security": {
      "requireApprovalForScripts": true,
      "encryptBackups": true
    }
  }
}
```

### Team Environment
```json
{
  "team": {
    "agents": {
      "sharedTemplates": "team-shared/agents/",
      "standardPrompts": true
    },
    "projects": {
      "namingConvention": "team-project-format",
      "requireDocumentation": true
    },
    "backup": {
      "centralLocation": "/shared/claude-backups/",
      "retentionPolicy": "90-days"
    }
  }
}
```

## 📝 Documentation Customization

### Custom Documentation Templates

#### API Documentation Template
```markdown
# {API_NAME} API Documentation

## Overview
{API_DESCRIPTION}

## Authentication
{AUTH_METHOD}

## Endpoints

### {ENDPOINT_NAME}
- **Method:** {HTTP_METHOD}
- **URL:** `{BASE_URL}{ENDPOINT_PATH}`
- **Description:** {ENDPOINT_DESCRIPTION}

#### Request
```json
{REQUEST_EXAMPLE}
```

#### Response
```json
{RESPONSE_EXAMPLE}
```

#### Error Codes
- `{ERROR_CODE}`: {ERROR_DESCRIPTION}
```

#### Project README Template
```markdown
# {PROJECT_NAME}

{PROJECT_DESCRIPTION}

## 🚀 Quick Start

### Prerequisites
{PREREQUISITES}

### Installation
```bash
{INSTALLATION_COMMANDS}
```

### Usage
```bash
{USAGE_EXAMPLES}
```

## 🧪 Development

This project was developed with assistance from Claude Code.

### Agent Usage
- **Primary Agent:** {AGENT_TYPE}
- **Key Workflows:** {WORKFLOWS_USED}

### Development Setup
```bash
{DEV_SETUP_COMMANDS}
```

## 📋 Architecture

{ARCHITECTURE_DESCRIPTION}

## 🤝 Contributing

{CONTRIBUTION_GUIDELINES}

## 📄 License

{LICENSE_INFO}
```

## 🔄 Advanced Customization

### Custom Agent Behavior Modifiers
```json
{
  "behavior_modifiers": {
    "conservative": {
      "description": "More careful, thorough analysis",
      "prompt_additions": ["double-check all assumptions", "provide alternative approaches"]
    },
    "innovative": {
      "description": "Experimental, cutting-edge solutions", 
      "prompt_additions": ["consider latest technologies", "suggest creative alternatives"]
    },
    "production-ready": {
      "description": "Focus on stability and maintainability",
      "prompt_additions": ["emphasize error handling", "include monitoring considerations"]
    }
  }
}
```

### Dynamic Configuration
```bash
#!/bin/bash
# tools/scripts/dynamic-config.sh

ENVIRONMENT="$1"
PROJECT_TYPE="$2"

# Generate environment-specific configuration
jq ".environments.$ENVIRONMENT + .project_types.$PROJECT_TYPE" \
   config/dynamic-config-base.json > config/settings.local.json

echo "Configuration updated for $ENVIRONMENT environment, $PROJECT_TYPE project type"
```

This customization system allows you to tailor every aspect of your Claude workspace to match your specific development needs, team requirements, and personal preferences.