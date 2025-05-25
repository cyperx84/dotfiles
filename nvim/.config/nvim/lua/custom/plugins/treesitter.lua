return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      ensure_installed = {
        'javascript',
        'typescript',
        'c',
        'lua',
        'vim',
        'vimdoc',
        'query',
        'jq',
        'dockerfile',
        'json',
        'html',
        'go',
        'tsx',
        'bash',
        'ruby',
        'markdown',
        'markdown_inline',
        'astro',
        'yaml',
      },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
