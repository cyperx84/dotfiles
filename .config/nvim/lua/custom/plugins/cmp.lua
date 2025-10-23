return {
  'saghen/blink.cmp',
  dependencies = { 'rafamadriz/friendly-snippets' },
  version = '1.*',
  opts = {
    keymap = { preset = 'default' },

    appearance = {
      nerd_font_variant = 'Nerd Font Mono',
    },

    completion = { documentation = { auto_show = true }, menu = { border = 'single' }, documentation = { window = { border = 'single' } } },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
      per_filetype = {
        codecompanion = { 'codecompanion' },
      },
    },

    fuzzy = { implementation = 'prefer_rust_with_warning' },
  },
  opts_extend = { 'sources.default' },
}
