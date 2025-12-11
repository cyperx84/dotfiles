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
    vim.api.nvim_set_hl(0, 'RenderMarkdownH1', { fg = '#FB2C36', bold = true })
    vim.api.nvim_set_hl(0, 'RenderMarkdownH2', { fg = '#FF692A', bold = true })
    vim.api.nvim_set_hl(0, 'RenderMarkdownH3', { fg = '#50FA7B', bold = true })
    vim.api.nvim_set_hl(0, 'RenderMarkdownH4', { fg = '#BD93F9', bold = true })
    vim.api.nvim_set_hl(0, 'RenderMarkdownH5', { fg = '#0000FF', bold = true })
    vim.api.nvim_set_hl(0, 'RenderMarkdownH6', { fg = '#9F9FA9', bold = true })

    -- Code block background only (let treesitter handle syntax colors)
    vim.api.nvim_set_hl(0, 'RenderMarkdownCode', { bg = '#121212' })
    vim.api.nvim_set_hl(0, 'RenderMarkdownCodeInline', { bg = '#1a1a1a' })
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
        style = 'full', -- 'full' = background on whole block, 'normal' = treesitter highlighting
        position = 'left',
        language_pad = 0,
        disable_background = { 'diff' },
        width = 'full',
        left_pad = 1,
        right_pad = 1,
        min_width = 0,
        border = 'thin',
        highlight = 'RenderMarkdownCode', -- Background color only
        highlight_inline = 'RenderMarkdownCodeInline',
      },
      latex = { enabled = false },
      completions = { blink = { enabled = true } },
    }
  end,
}
