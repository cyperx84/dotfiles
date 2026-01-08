---
allowed-tools: mcp__nvim__get_current_buffer, Read, Edit, Write, Grep, Glob
description: Apply information from CodeCompanion to the codebase
---

Read the current Neovim buffer (CodeCompanion or other LLM conversation).

Extract the key information, solution, or approach discussed, then:

1. **Understand**: Summarize what was discussed/solved
2. **Locate**: Find where this applies in the codebase
3. **Adapt**: Modify the solution to fit existing patterns and conventions
4. **Implement**: Make the necessary changes
5. **Explain**: Describe what was changed and why

If the conversation contains code that needs to be applied, adapt it to match the project's style and integrate it properly rather than copying verbatim.
