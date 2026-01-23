# Multi-LLM Workflow: Claude Code + CodeCompanion in Neovim

> **A guide to orchestrating multiple AI models in a unified Neovim environment for prompt engineering, cross-model validation, and enhanced development workflows.**

## Table of Contents

- [Overview](#overview)
- [The Core Concept](#the-core-concept)
- [Prerequisites](#prerequisites)
- [Architecture](#architecture)
- [Workflow Patterns](#workflow-patterns)
- [Practical Use Cases](#practical-use-cases)
- [Setup Guide](#setup-guide)
- [Slash Commands](#slash-commands)
- [Evaluation Frameworks](#evaluation-frameworks)
- [Tips & Best Practices](#tips--best-practices)
- [Troubleshooting](#troubleshooting)
- [Future Possibilities](#future-possibilities)

---

## Overview

This document describes a powerful workflow combining **Claude Code** (running as a Neovim plugin via `claudecode.nvim`) with **CodeCompanion.nvim** to create a local multi-agent AI system. This setup enables:

- **Prompt Engineering**: Iterate and improve prompts with real-time feedback
- **Cross-Model Validation**: Verify outputs across different LLMs
- **Information Synthesis**: Leverage each model's strengths
- **LLM-as-Judge**: Evaluate and score AI responses systematically

### Why This Matters

Most developers use one AI at a time. This setup lets you:
1. Get multiple perspectives on the same problem
2. Validate critical AI outputs before using them
3. Systematically improve your prompting skills
4. Build a library of proven, tested prompts

---

## The Core Concept

### The Insight

You have **two AI systems operating in the same environment**:

```
┌─────────────────────────────────────────────────────────────────┐
│                         NEOVIM                                   │
│  ┌─────────────────────┐    ┌─────────────────────────────────┐ │
│  │   CodeCompanion     │    │        Claude Code              │ │
│  │   ───────────────   │    │        ───────────              │ │
│  │   - GPT-4           │    │   - Full codebase context       │ │
│  │   - Claude          │◄──►│   - File operations             │ │
│  │   - Gemini          │    │   - MCP tools                   │ │
│  │   - Ollama/Local    │    │   - Can READ CodeCompanion      │ │
│  │   - Any provider    │    │     buffers via MCP             │ │
│  └─────────────────────┘    └─────────────────────────────────┘ │
│                    ▲                        ▲                    │
│                    │      SHARED BUFFERS    │                    │
│                    └────────────────────────┘                    │
└─────────────────────────────────────────────────────────────────┘
                              ▲
                              │
                         YOU (Orchestrator)
```

### Key Capabilities

| Capability | How It Works |
|------------|--------------|
| **Buffer Reading** | Claude Code can read any Neovim buffer via MCP, including CodeCompanion chat buffers |
| **Cross-Context** | CodeCompanion has model variety; Claude Code has codebase context |
| **Real-Time** | Both operate in the same Neovim session simultaneously |
| **Orchestration** | You control the flow, deciding when to use which model |

---

## Prerequisites

### Required Software

```bash
# Neovim (0.9+ recommended)
brew install neovim

# Claude Code CLI
# Install from: https://claude.ai/claude-code

# Node.js (for some CodeCompanion providers)
brew install node
```

### Required Neovim Plugins

#### 1. claudecode.nvim
Claude Code integration for Neovim.

```lua
-- lazy.nvim
{
  "anthropics/claudecode.nvim",
  config = function()
    require("claudecode").setup({
      -- your config
    })
  end,
}
```

#### 2. CodeCompanion.nvim
Multi-provider LLM chat interface.

```lua
-- lazy.nvim
{
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("codecompanion").setup({
      adapters = {
        openai = function()
          return require("codecompanion.adapters").extend("openai", {
            env = { api_key = "OPENAI_API_KEY" },
          })
        end,
        anthropic = function()
          return require("codecompanion.adapters").extend("anthropic", {
            env = { api_key = "ANTHROPIC_API_KEY" },
          })
        end,
        -- Add more providers as needed
      },
    })
  end,
}
```

### API Keys

You'll need API keys for the models you want to use in CodeCompanion:
- OpenAI: `OPENAI_API_KEY`
- Anthropic: `ANTHROPIC_API_KEY`
- Google: `GEMINI_API_KEY`
- Or use local models via Ollama

---

## Architecture

### Buffer Communication

Claude Code reads CodeCompanion buffers using MCP (Model Context Protocol):

```
┌─────────────────────────────────────────────────────────────┐
│                    MCP NVIM SERVER                           │
│  ┌─────────────────────────────────────────────────────────┐│
│  │ Tools:                                                   ││
│  │  - list_nvim_buffers    → See all open buffers          ││
│  │  - get_current_buffer   → Read focused buffer content   ││
│  │  - get_buffer_content   → Read specific file buffer     ││
│  │  - update_buffer        → Write to buffer               ││
│  │  - open_file            → Open file in Neovim           ││
│  └─────────────────────────────────────────────────────────┘│
└─────────────────────────────────────────────────────────────┘
```

### Reading CodeCompanion Buffers

CodeCompanion creates special buffers with names like `[CodeCompanion] 2625607`. These are **not file paths**, so:

| Method | Works? | Notes |
|--------|--------|-------|
| `get_current_buffer` | ✅ Yes | Buffer must be focused |
| `get_buffer_content` | ❌ No | Requires real file path |
| `list_nvim_buffers` | ⚠️ Partial | Only shows file-backed buffers |

**Solution**: Focus the CodeCompanion buffer before asking Claude Code to read it.

---

## Workflow Patterns

### Pattern 1: Prompt Engineering Feedback Loop

**Goal**: Iteratively improve prompts using multi-model feedback.

```
┌──────────────────────────────────────────────────────────────┐
│                                                              │
│    ┌─────────┐     ┌──────────────┐     ┌──────────────┐    │
│    │ Write   │────►│ Test in      │────►│ Claude Code  │    │
│    │ Prompt  │     │ CodeCompanion│     │ Evaluates    │    │
│    └─────────┘     └──────────────┘     └──────────────┘    │
│         ▲                                      │             │
│         │                                      │             │
│         └──────────── Improve ◄────────────────┘             │
│                                                              │
└──────────────────────────────────────────────────────────────┘
```

**Steps**:
1. Write a prompt in a scratch buffer
2. Send to CodeCompanion (GPT-4, Gemini, etc.)
3. Focus the CodeCompanion response buffer
4. Ask Claude Code: "Read the current buffer and evaluate the response. Suggest prompt improvements."
5. Apply improvements, repeat

### Pattern 2: Cross-Model Validation

**Goal**: Verify critical outputs across multiple models.

```
Same Question ──┬──► CodeCompanion (GPT-4)  ──► Response A
                │
                ├──► CodeCompanion (Gemini) ──► Response B
                │
                └──► Claude Code            ──► Response C
                              │
                              ▼
                    Compare & Synthesize
```

**When to use**:
- Critical code that must be correct
- Security-sensitive implementations
- Complex architectural decisions
- When you're unsure about an approach

### Pattern 3: Research → Implementation Bridge

**Goal**: Use CodeCompanion for research, Claude Code for implementation.

```
CodeCompanion                          Claude Code
─────────────                          ───────────
"Explain different                     "Read the CodeCompanion
approaches to implement                buffer and implement
rate limiting in Go"                   the token bucket approach
        │                              in our API server"
        ▼                                      │
   Research Output ──────────────────────►  Implementation
   (multiple approaches,                    (with full codebase
    pros/cons, examples)                     context)
```

**Why this works**:
- CodeCompanion: Good for exploration, multiple providers
- Claude Code: Has your codebase context, can edit files

### Pattern 4: LLM-as-Judge Evaluation

**Goal**: Systematically evaluate and score AI outputs.

```lua
-- Evaluation Criteria
{
  accuracy = 0-10,      -- Is it factually correct?
  completeness = 0-10,  -- Did it address the full request?
  code_quality = 0-10,  -- Clean, idiomatic, secure?
  instruction_following = 0-10,  -- Did it do what was asked?
  efficiency = 0-10,    -- Optimal approach?
}
```

**Process**:
1. Generate response in CodeCompanion
2. Focus buffer
3. Ask Claude Code to evaluate against criteria
4. Log scores for comparison

### Pattern 5: Prompt A/B Testing

**Goal**: Compare prompt effectiveness across models.

```markdown
## Test: Code Review Prompt

### Prompt A (Baseline)
"Review this code for bugs"

### Prompt B (Improved)
"Review this code focusing on:
1. Security vulnerabilities
2. Performance issues
3. Error handling gaps
Provide specific line numbers and fixes."

### Results
| Model   | Prompt A Score | Prompt B Score |
|---------|----------------|----------------|
| GPT-4   | 6/10           | 9/10           |
| Gemini  | 5/10           | 8/10           |
| Claude  | 7/10           | 9/10           |
```

### Pattern 6: Chain-of-Thought Verification

**Goal**: Have one model verify another's reasoning.

```
Model A: Solves problem step-by-step
              │
              ▼
Model B: Verifies each step
              │
              ▼
         Catches errors before implementation
```

**Example**:
1. Ask GPT-4 (CodeCompanion): "Solve this algorithm problem, show your reasoning"
2. Ask Claude Code: "Read the solution and verify each logical step. Identify any errors."

---

## Practical Use Cases

### Use Case 1: Debugging a Stuck Problem

When you're stuck and one AI isn't helping:

```
1. Describe problem to CodeCompanion (GPT-4)
2. Get response
3. Ask Claude Code: "Read the CodeCompanion buffer.
   I tried this but it didn't work. What's missing?"
4. Claude Code has your actual code context
5. Get a more targeted solution
```

### Use Case 2: Learning New Concepts

Get multiple explanations:

```
1. Ask CodeCompanion: "Explain Rust lifetimes with examples"
2. Ask Claude Code: "Read that explanation.
   Now show me how lifetimes apply in our codebase."
3. Theory + practical application
```

### Use Case 3: Code Review Pipeline

```
1. Generate code with CodeCompanion
2. Ask Claude Code: "Read the generated code.
   Review it against our project's patterns and standards."
3. Get contextual review
```

### Use Case 4: Prompt Library Building

Systematically test and catalog prompts:

```
prompts/
├── tested/
│   ├── code-review-v3.md      # Score: 9/10
│   ├── refactoring-v2.md      # Score: 8/10
│   └── debugging-v4.md        # Score: 9/10
├── experiments/
│   └── new-approach.md        # Untested
└── retired/
    └── old-prompts.md         # Deprecated
```

### Use Case 5: Documentation Generation

```
1. CodeCompanion: "Generate API documentation for this endpoint"
2. Claude Code: "Read that documentation.
   Refine it to match our existing docs style
   and add examples from actual usage in the codebase."
```

---

## Setup Guide

### Step 1: Install Plugins

Add to your Neovim config (lazy.nvim example):

```lua
-- lua/plugins/ai.lua
return {
  -- Claude Code
  {
    "anthropics/claudecode.nvim",
    config = function()
      require("claudecode").setup()
    end,
  },

  -- CodeCompanion
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("codecompanion").setup({
        strategies = {
          chat = { adapter = "openai" },
          inline = { adapter = "openai" },
        },
        adapters = {
          openai = function()
            return require("codecompanion.adapters").extend("openai", {
              env = { api_key = "cmd:cat ~/.openai_key" },
            })
          end,
        },
      })
    end,
  },
}
```

### Step 2: Configure Keybindings

```lua
-- CodeCompanion
vim.keymap.set("n", "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>")
vim.keymap.set("n", "<leader>ca", "<cmd>CodeCompanionActions<cr>")
vim.keymap.set("v", "<leader>cc", "<cmd>CodeCompanionChat Add<cr>")

-- Quick switch between windows
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-l>", "<C-w>l")
```

### Step 3: Set Up Claude Code Slash Commands

Create evaluation commands in `.claude/commands/`:

#### `.claude/commands/eval.md`
```markdown
---
allowed-tools: mcp__nvim__get_current_buffer
description: Evaluate LLM response in current buffer
---

Read the current Neovim buffer containing an LLM conversation.

Provide a structured evaluation:

## Response Quality (X/10)
[Assessment of the response]

## What Worked in the Prompt
[Elements that led to good output]

## What Could Improve
[Specific suggestions]

## Improved Prompt
[Rewritten version]
```

#### `.claude/commands/bridge.md`
```markdown
---
allowed-tools: mcp__nvim__get_current_buffer, Read, Edit, Write, Grep, Glob
description: Apply information from CodeCompanion to codebase
---

Read the current Neovim buffer (CodeCompanion conversation).

Extract the key information or solution discussed, then:
1. Identify where it applies in the codebase
2. Implement or apply the solution appropriately
3. Explain what changes were made
```

#### `.claude/commands/compare.md`
```markdown
---
allowed-tools: mcp__nvim__get_current_buffer, mcp__nvim__list_nvim_buffers
description: Compare multiple LLM responses
---

Read the current buffer and any other CodeCompanion buffers.

Create a comparison table:

| Criteria | Response A | Response B | Winner |
|----------|------------|------------|--------|
| Accuracy | | | |
| Completeness | | | |
| Code Quality | | | |
| Clarity | | | |

**Recommendation**: [Which response to use and why]
```

### Step 4: Create Layout Workflow

Recommended Neovim layout:

```
┌─────────────────────────────────────────────────────────────┐
│  Code/Work Buffer                │  CodeCompanion Chat     │
│                                  │                         │
│                                  │  ## User                │
│                                  │  Your prompt here       │
│                                  │                         │
│                                  │  ## Assistant           │
│                                  │  LLM response here      │
│                                  │                         │
├──────────────────────────────────┴─────────────────────────┤
│  Claude Code Terminal (if using terminal mode)             │
│  Or: Claude Code running in background                     │
└─────────────────────────────────────────────────────────────┘
```

### Step 5: Workflow Keybindings (Optional)

Add to your Neovim config for quick workflow access:

```lua
-- Quick focus CodeCompanion and trigger Claude Code eval
vim.keymap.set("n", "<leader>ce", function()
  -- Focus the CodeCompanion window (adjust as needed)
  vim.cmd("wincmd l")
  -- Notify user to run eval in Claude Code
  print("CodeCompanion focused. Run /eval in Claude Code.")
end, { desc = "Prep for Claude Code evaluation" })
```

---

## Slash Commands

### Available Commands

| Command | Purpose | Usage |
|---------|---------|-------|
| `/eval` | Evaluate LLM response | Focus CodeCompanion buffer, run in Claude Code |
| `/bridge` | Apply CodeCompanion info to codebase | After research in CodeCompanion |
| `/compare` | Compare multiple responses | When A/B testing |
| `/prompt-improve` | Suggest prompt improvements | For prompt engineering |

### Creating Custom Commands

Template for new commands:

```markdown
---
allowed-tools: mcp__nvim__get_current_buffer, [other tools]
description: Brief description
---

[Instructions for Claude Code]

[Structured output format]
```

---

## Evaluation Frameworks

### Standard Evaluation Criteria

```markdown
## Evaluation Rubric

### Accuracy (0-10)
- 10: Completely correct, no errors
- 7-9: Minor issues, mostly correct
- 4-6: Some significant errors
- 1-3: Mostly incorrect
- 0: Completely wrong

### Completeness (0-10)
- 10: Addresses all aspects of the request
- 7-9: Covers most aspects
- 4-6: Partial coverage
- 1-3: Minimal coverage
- 0: Doesn't address the request

### Code Quality (0-10)
- 10: Production-ready, follows best practices
- 7-9: Good quality, minor improvements possible
- 4-6: Functional but needs work
- 1-3: Poor quality, major issues
- 0: Unusable

### Instruction Following (0-10)
- 10: Exactly what was asked
- 7-9: Close to request, minor deviations
- 4-6: Partially follows instructions
- 1-3: Significant misunderstanding
- 0: Ignores instructions

### Efficiency (0-10)
- 10: Optimal solution
- 7-9: Good approach
- 4-6: Works but suboptimal
- 1-3: Inefficient
- 0: Problematic approach
```

### Prompt Evaluation Template

```markdown
## Prompt Analysis

### Clarity Score: X/10
[Is the prompt unambiguous?]

### Specificity Score: X/10
[Does it provide enough context?]

### Structure Score: X/10
[Is it well-organized?]

### Issues Identified
1. [Issue 1]
2. [Issue 2]

### Improved Version
```
[Rewritten prompt]
```

### Why This Is Better
[Explanation]
```

---

## Tips & Best Practices

### Do's

1. **Focus the buffer first**: Always ensure CodeCompanion buffer is focused before asking Claude Code to read it

2. **Be specific in evaluations**: "Evaluate this response" is weak. "Evaluate for security vulnerabilities and suggest fixes" is strong.

3. **Use structured output**: Ask for tables, scores, specific formats for easier comparison

4. **Log your experiments**: Keep track of which prompts work best

5. **Leverage context differences**:
   - CodeCompanion: Model variety, quick experiments
   - Claude Code: Codebase context, file operations

### Don'ts

1. **Don't trust blindly**: Use cross-validation for critical code

2. **Don't over-engineer**: Start simple, add complexity as needed

3. **Don't ignore disagreements**: When models disagree, investigate why

4. **Don't forget cost**: Running multiple models adds up

### Efficiency Tips

1. **Batch similar evaluations**: Test multiple prompts in one session

2. **Create templates**: Reuse evaluation structures

3. **Use quick models for iteration**: Test with faster/cheaper models first

4. **Cache good responses**: Save exemplary outputs for reference

---

## Troubleshooting

### "Buffer not found" Error

**Problem**: Claude Code can't read the CodeCompanion buffer.

**Solution**:
1. Make sure the CodeCompanion buffer is **focused** (active window)
2. Use `get_current_buffer` not `get_buffer_content`
3. CodeCompanion buffers have special names like `[CodeCompanion] 123456`, not file paths

### CodeCompanion Buffer Not in List

**Problem**: `list_nvim_buffers` doesn't show CodeCompanion.

**Explanation**: This is expected. `list_nvim_buffers` only shows file-backed buffers. CodeCompanion uses special scratch buffers.

**Solution**: Focus the buffer and use `get_current_buffer`.

### Stale Buffer Content

**Problem**: Claude Code reads old content.

**Solution**:
1. Ensure the conversation is complete (LLM finished responding)
2. Re-focus the buffer
3. Ask Claude Code to read again

### Context Too Long

**Problem**: CodeCompanion conversation is too long for Claude Code to process.

**Solution**:
1. Start a new CodeCompanion chat for evaluation
2. Copy specific parts to a scratch buffer
3. Ask for evaluation of specific responses, not entire history

---

## Future Possibilities

### Automation Ideas

1. **Auto-evaluation pipeline**: Script that automatically sends CodeCompanion output to Claude Code for evaluation

2. **Prompt testing framework**: Automated A/B testing across models with scoring

3. **Quality gates**: Require multi-model consensus before committing code

4. **Learning system**: Track which prompts work best and suggest improvements

### Integration Opportunities

1. **Telescope integration**: Fuzzy find through prompt library

2. **Git hooks**: Run evaluations before commits

3. **CI/CD integration**: Multi-model review in pull requests

4. **Metrics dashboard**: Track prompt performance over time

### Advanced Workflows

1. **Recursive improvement**: Model A improves Model B's output, repeat

2. **Ensemble responses**: Combine best parts from multiple models

3. **Specialized agents**: Different models for different tasks (security review, performance, style)

4. **Training data generation**: Use validated outputs to fine-tune local models

---

## Appendix

### Quick Reference Card

```
┌─────────────────────────────────────────────────────────────┐
│                    QUICK REFERENCE                          │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  READ CODECOMPANION:                                        │
│    1. Focus CodeCompanion buffer                            │
│    2. Ask Claude Code: "read current buffer"                │
│                                                             │
│  EVALUATE RESPONSE:                                         │
│    Focus buffer → /eval in Claude Code                      │
│                                                             │
│  IMPROVE PROMPT:                                            │
│    Focus buffer → "evaluate and improve my prompt"          │
│                                                             │
│  APPLY TO CODEBASE:                                         │
│    Focus buffer → /bridge in Claude Code                    │
│                                                             │
│  COMPARE MODELS:                                            │
│    Same prompt to multiple models → /compare                │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### Sample Prompts for Evaluation

**Basic Evaluation**:
```
Read the current buffer and evaluate the LLM response.
Rate it 1-10 and explain your reasoning.
```

**Detailed Evaluation**:
```
Read the current buffer. Evaluate the response on:
1. Accuracy (0-10)
2. Completeness (0-10)
3. Code quality (0-10)
4. Following instructions (0-10)

Provide specific examples for each score.
Suggest improvements to the original prompt.
```

**Prompt Improvement**:
```
Read the current buffer. Focus on the USER's prompt.
Identify weaknesses and rewrite it to get better results.
Explain what you changed and why.
```

**Cross-Validation**:
```
Read the current buffer. This was generated by GPT-4.
Verify the claims and code for correctness.
Note any errors or concerns.
```

---

## Contributing

This workflow is experimental. If you develop new patterns or improvements:

1. Test thoroughly
2. Document your findings
3. Share with the community

---

*Last Updated: January 2026*
*License: MIT*

---

## Author

**cyperx** - [GitHub Profile](https://github.com/cyperx84)

For issues or contributions, visit the [dotfiles repository](https://github.com/cyperx84/dotfiles).
