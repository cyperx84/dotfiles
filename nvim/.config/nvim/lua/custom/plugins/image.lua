return {
  {
    'vhyrro/luarocks.nvim',
    priority = 1001, -- this plugin needs to run before anything else
    opts = {
      rocks = { 'magick' },
    },
  },
  -- Disabled: New obsidian.nvim v3.14+ requires snacks.nvim for image rendering
  -- {
  --   '3rd/image.nvim',
  --   enabled = false,
  -- },
  {
    'HakonHarnes/img-clip.nvim',
    keys = {
      { '<leader>pi', '<cmd>PasteImage<CR>', desc = 'Paste Image' },
    },
    opts = {
      filetypes = {
        codecompanion = {
          prompt_for_file_name = false,
          template = '[Image]($FILE_PATH)',
          use_absolute_path = true,
        },
      },
    },
  },
}
