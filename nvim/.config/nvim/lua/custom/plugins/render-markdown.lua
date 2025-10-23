return {
  'MeanderingProgrammer/render-markdown.nvim',
  lazy = true,
  ft = 'markdown',
  priority = 1000, -- Load after treesitter
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'echasnovski/mini.icons',
  },
  config = function()
    vim.api.nvim_set_hl(0, 'RenderMarkdownH1', { fg = '#FF5555', bold = true })
    vim.api.nvim_set_hl(0, 'RenderMarkdownH2', { fg = '#F1FA8C', bold = true })
    vim.api.nvim_set_hl(0, 'RenderMarkdownH3', { fg = '#50FA7B', bold = true })
    vim.api.nvim_set_hl(0, 'RenderMarkdownH4', { fg = '#BD93F9', bold = true })
    vim.api.nvim_set_hl(0, 'RenderMarkdownH5', { fg = '#8BE9FD', bold = true })
    vim.api.nvim_set_hl(0, 'RenderMarkdownH6', { fg = '#FF79C6', bold = true })

    vim.api.nvim_set_hl(0, 'RenderMarkdownCodeBlock', { bg = '#121212', fg = '#C0CAF5', bold = true })
    vim.api.nvim_set_hl(0, 'RenderMarkdownInlineCode', { bg = '#121212', fg = '#C0CAF5', bold = true })
    require('render-markdown').setup {
      heading = {
        border = false,
        border_virtual = false,
        border_prefix = false,
        above = '',
        below = '',
        backgrounds = {
          'RenderMarkdownH1',
          'RenderMarkdownH2',
          'RenderMarkdownH3',
          'RenderMarkdownH4',
          'RenderMarkdownH5',
          'RenderMarkdownH6',
        }, -- No background colors for headings
        foregrounds = {
          'RenderMarkdownH1',
          'RenderMarkdownH2',
          'RenderMarkdownH3',
          'RenderMarkdownH4',
          'RenderMarkdownH5',
          'RenderMarkdownH6',
        },
        width = 'block',
        left_pad = 2,
        right_pad = 2,
        min_width = 80,
        icons = { ' ', ' ', ' ', ' ', ' ', ' ' },
      },
      code = {
        enabled = true,
        sign = true,
        style = 'full',
        position = 'left',
        language_pad = 0,
        disable_background = { 'diff' },
        width = 'full',
        left_pad = 1,
        right_pad = 1,
        min_width = 0,
        border = 'thin',
        highlight = 'RenderMarkdownCodeBlock',
        highlight_inline = 'RenderMarkdownInlineCode',
      },
      latex = { enabled = false },
      completions = { blink = { enabled = true } },
    }
  end,
}
