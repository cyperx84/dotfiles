return {
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      require('mini.files').setup()
      require('mini.pick').setup()

      -- require('mini.animate').setup {
      --   cursor = {
      --     enable = true,
      --     -- Optional: Customize timing and path for cursor animation
      --     timing = require('mini.animate').gen_timing.linear({ duration = 100, unit = 'total' }),
      --     path = require('mini.animate').gen_path.line(),
      --   },
      --   scroll = { enable = false },
      --   resize = {
      --     enable = true,
      --     -- Optional: Customize timing for resize animation
      --     -- timing = require('mini.animate').gen_timing.linear({ duration = 50, unit = 'total' }),
      --   },
      --   open = {
      --     enable = true,
      --     -- Optional: Customize timing for window open animation
      --     -- timing = require('mini.animate').gen_timing.linear({ duration = 200, unit = 'total' }),
      --   },
      --   close = {
      --     enable = true,
      --     -- Optional: Customize timing for window close animation
      --     -- timing = require('mini.animate').gen_timing.linear({ duration = 200, unit = 'total' }),
      --   },
      -- }

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
