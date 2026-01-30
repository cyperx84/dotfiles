# Multi-LLM Workflow: Claude Code + CodeCompanion

> **Orchestrating multiple AI models in Neovim for prompt engineering, cross-model validation, and enhanced development.**

## Overview

This workflow combines **Claude Code** (via `claudecode.nvim`) with **CodeCompanion.nvim** to create a local multi-agent AI system:

- **Prompt Engineering**: Iterate and improve prompts with multi-model feedback
- **Cross-Model Validation**: Verify outputs across different LLMs
- **LLM-as-Judge**: Systematically evaluate and score AI responses

## Quick Reference

```
READ CODECOMPANION:     Focus buffer → ask Claude Code "read current buffer"
EVALUATE RESPONSE:      Focus buffer → /eval in Claude Code
APPLY TO CODEBASE:      Focus buffer → /bridge in Claude Code
COMPARE MODELS:         Same prompt to multiple models → /compare
```

## Core Concept

Two AI systems operate in the same Neovim environment:

| Capability | How It Works |
|------------|--------------|
| **Buffer Reading** | Claude Code reads any buffer via MCP, including CodeCompanion chat |
| **Cross-Context** | CodeCompanion has model variety; Claude Code has codebase context |
| **Orchestration** | You control the flow, deciding when to use which model |

**Key Insight**: Focus the CodeCompanion buffer before asking Claude Code to read it (use `get_current_buffer`, not `get_buffer_content`).

## Workflow Patterns

### Pattern 1: Prompt Engineering Loop

1. Write prompt in scratch buffer
2. Send to CodeCompanion (GPT-4, Gemini, etc.)
3. Focus the response buffer
4. Ask Claude Code: "Read the current buffer and evaluate the response. Suggest prompt improvements."
5. Apply improvements, repeat

### Pattern 2: Cross-Model Validation

Use when: Critical code, security-sensitive implementations, complex architectural decisions.

```
Same Question → CodeCompanion (GPT-4) → Response A
             → CodeCompanion (Gemini) → Response B
             → Claude Code            → Response C
                         ↓
             Compare & Synthesize
```

### Pattern 3: Research → Implementation Bridge

- **CodeCompanion**: "Explain different approaches to implement rate limiting"
- **Claude Code**: "Read the CodeCompanion buffer and implement the token bucket approach in our API server"

Why: CodeCompanion for exploration, Claude Code has codebase context for implementation.

## Setup

### Required Plugins

```lua
-- claudecode.nvim
{
  "anthropics/claudecode.nvim",
  config = function() require("claudecode").setup() end,
}

-- CodeCompanion.nvim
{
  "olimorris/codecompanion.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("codecompanion").setup({
      adapters = {
        openai = function()
          return require("codecompanion.adapters").extend("openai", {
            env = { api_key = "OPENAI_API_KEY" },
          })
        end,
      },
    })
  end,
}
```

### Keybindings

```lua
vim.keymap.set("n", "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>")
vim.keymap.set("n", "<leader>ca", "<cmd>CodeCompanionActions<cr>")
```

## Slash Commands

Create in `.claude/commands/`:

| Command | Purpose |
|---------|---------|
| `/eval` | Evaluate LLM response quality (Focus buffer first) |
| `/bridge` | Apply CodeCompanion info to codebase |
| `/compare` | Compare multiple LLM responses |
| `/prompt-improve` | Suggest prompt improvements |

### Example: `/eval.md`

```markdown
---
allowed-tools: mcp__nvim__get_current_buffer
description: Evaluate LLM response in current buffer
---

Read the current Neovim buffer containing an LLM conversation.

Provide a structured evaluation:
- Response Quality (X/10)
- What Worked in the Prompt
- What Could Improve
- Improved Prompt
```

## Evaluation Criteria

| Criterion | Scale | Description |
|-----------|-------|-------------|
| Accuracy | 0-10 | Factually correct? |
| Completeness | 0-10 | Addresses full request? |
| Code Quality | 0-10 | Clean, idiomatic, secure? |
| Instruction Following | 0-10 | Did what was asked? |

## Best Practices

**Do:**
- Focus buffer before asking Claude Code to read it
- Use structured output (tables, scores) for comparison
- Log experiments to track which prompts work best

**Don't:**
- Trust blindly—use cross-validation for critical code
- Forget cost—running multiple models adds up
- Ignore disagreements—investigate when models disagree

## Troubleshooting

| Problem | Solution |
|---------|----------|
| "Buffer not found" | Focus CodeCompanion buffer, use `get_current_buffer` |
| Stale buffer content | Ensure LLM finished responding, re-focus buffer |
| Context too long | Start new chat or copy specific parts to scratch buffer |

---

*License: MIT*
