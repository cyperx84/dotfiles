# Agent Management System

This directory contains templates and configurations for Claude Code agents and subagents.

## 📁 Structure

```
agents/
├── subagents/          # Custom subagent definitions
├── templates/          # Reusable agent templates
└── README.md          # This documentation
```

## 🤖 Available Agent Templates

### General Purpose Agent (`general-purpose-agent.json`)
**Best for:** Complex, multi-step tasks requiring research and analysis
- **Tools:** Full tool access including web search and file operations
- **Use cases:** Open-ended research, code exploration, complex problem solving
- **When to use:** Tasks with unclear scope or requiring multiple iterations

### Code Analysis Agent (`code-analysis-agent.json`)
**Best for:** Code review, security analysis, and optimization
- **Tools:** File operations, search tools, bash commands
- **Use cases:** Security audits, performance reviews, refactoring suggestions
- **When to use:** Need detailed code analysis or quality assessment

### Documentation Agent (`documentation-agent.json`)
**Best for:** Creating comprehensive technical documentation
- **Tools:** File operations, web research, structured writing
- **Use cases:** API docs, README files, user guides, tutorials
- **When to use:** Need well-structured, professional documentation

### Setup Configuration Agent (`setup-configuration-agent.json`)
**Best for:** System configuration and environment setup
- **Tools:** System commands, file operations, research capabilities
- **Use cases:** Dev environment setup, configuration management, tool installation
- **When to use:** Setting up new environments or configuring systems

## 🛠️ Creating Custom Agents

### 1. Using Templates
```bash
# Copy template as starting point
cp agents/templates/general-purpose-agent.json agents/subagents/my-custom-agent.json

# Edit the configuration
vim agents/subagents/my-custom-agent.json
```

### 2. Agent Configuration Format
```json
{
  "name": "agent-name",
  "description": "Brief description of agent purpose",
  "type": "general-purpose|specialized",
  "domain": "optional-domain-expertise",
  "capabilities": [
    "List of what the agent can do"
  ],
  "tools": [
    "Tools available to the agent"
  ],
  "usage_examples": [
    "Example use cases"
  ],
  "best_practices": [
    "Guidelines for effective use"
  ],
  "prompt_template": "Template for prompting the agent"
}
```

### 3. Deploying Custom Agents
```bash
# Test the agent configuration
jq . agents/subagents/my-custom-agent.json

# Use in Claude Code session
# Refer to the agent when using the Task tool
```

## 🚀 Using Agents in Claude Code

### With the Task Tool
```
Use the Task tool with subagent_type parameter:
- subagent_type: "general-purpose" for research and complex tasks
- subagent_type: "code-analysis" for code review tasks
- subagent_type: "documentation" for writing documentation
- subagent_type: "setup-configuration" for system setup
```

### Agent Selection Guidelines

#### Use **General Purpose** when:
- Task scope is unclear or complex
- Need research and exploration
- Require multiple tools and iterations
- Problem-solving across different domains

#### Use **Code Analysis** when:
- Reviewing code quality or security
- Need refactoring suggestions
- Analyzing performance issues
- Generating code documentation

#### Use **Documentation** when:
- Creating user guides or API docs
- Need structured, professional writing
- Generating README files
- Writing tutorials or how-to guides

#### Use **Setup Configuration** when:
- Setting up development environments
- Configuring tools and systems
- Installing dependencies
- Managing dotfiles or system settings

## 🎯 Agent Prompt Templates

### Effective Agent Prompting
```
[Task Description] + [Context] + [Specific Requirements] + [Constraints]

Example:
"Analyze the authentication system in src/auth/ for security vulnerabilities. 
Focus on input validation and session management. 
Follow OWASP guidelines and provide specific remediation steps."
```

### Template Variables
- `{task_description}`: What you want accomplished
- `{complexity_level}`: Simple, moderate, complex
- `{specific_capabilities}`: Required agent skills
- `{file_path}`: Target files or directories
- `{analysis_type}`: Type of analysis needed
- `{audience_level}`: Target documentation audience
- `{environment/tool}`: Setup target
- `{constraints}`: Limitations or requirements

## 📊 Agent Performance Optimization

### Task Scoping
- **Narrow scope**: Use specialized agents
- **Broad scope**: Use general-purpose agent
- **Iterative tasks**: Chain multiple agent calls

### Context Management
- Provide relevant file paths and context
- Include project structure information
- Specify coding standards or conventions
- Mention relevant technologies and frameworks

### Output Quality
- Request specific deliverables
- Specify output format preferences
- Include quality criteria and standards
- Ask for examples and documentation

## 🔄 Agent Workflow Patterns

### Research → Analysis → Implementation
1. **General Purpose**: Research and planning
2. **Code Analysis**: Review and validation
3. **Documentation**: Record and explain

### Setup → Configure → Document
1. **Setup Configuration**: Environment preparation
2. **General Purpose**: Complex configuration tasks
3. **Documentation**: Setup guides and troubleshooting

### Analyze → Refactor → Test
1. **Code Analysis**: Identify issues and opportunities
2. **General Purpose**: Implement changes
3. **Code Analysis**: Validate improvements

## 📈 Best Practices

### Agent Selection
- Match agent capabilities to task requirements
- Use specialized agents for domain-specific tasks
- Chain agents for complex multi-phase work

### Task Design
- Break complex tasks into smaller, focused pieces
- Provide clear, specific instructions
- Include relevant context and constraints

### Quality Assurance
- Review agent outputs for accuracy and completeness
- Test suggestions before implementation
- Document successful agent workflows for reuse

## 🚨 Troubleshooting

### Agent Not Performing Well
1. Check task clarity and specificity
2. Verify agent capabilities match task requirements
3. Provide more context and examples
4. Consider breaking task into smaller pieces

### Choosing Wrong Agent
1. Review agent descriptions and capabilities
2. Consider task complexity and scope
3. Try general-purpose agent for unclear tasks
4. Chain multiple agents if needed

### Custom Agent Issues
1. Validate JSON syntax: `jq . agents/subagents/agent.json`
2. Check required fields are present
3. Test with simple tasks first
4. Refine based on performance

## 🔗 Related Documentation

- [Project Management](../projects/README.md) - Context for agent tasks
- [Tools](../tools/README.md) - Additional automation utilities
- [Configuration](../config/README.md) - System settings and preferences