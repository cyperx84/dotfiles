return {
  "xiyaowong/transparent.nvim",
  lazy = false, -- DO NOT lazy-load this
  config = function()
    require("transparent").setup({
      groups = {
        'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
        'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String',
        'Function', 'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr',
        'NonText', 'SignColumn', 'CursorLine', 'CursorLineNr', 'StatusLine',
        'StatusLineNC', 'EndOfBuffer',
      },
      extra_groups = {},
      exclude_groups = {},
    })

    vim.cmd("TransparentEnable")
  end,
}
