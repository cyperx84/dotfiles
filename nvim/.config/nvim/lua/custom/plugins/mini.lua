return {
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      require('mini.ai').setup { n_lines = 500 }
      require('mini.surround').setup()
      require('mini.sessions').setup {
        autoread = false,  -- Keep false to always show dashboard on startup
        autowrite = true,
        directory = vim.fn.stdpath 'data' .. '/sessions',
        file = 'Session.vim',
        force = { read = false, write = true, delete = false },
        verbose = { read = true, write = true, delete = true },
      }
      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = vim.g.have_nerd_font }
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end
      require('mini.files').setup {
        content = {
          filter = nil,
          prefix = nil,
          sort = nil,
        },
        mappings = {
          close = 'q',
          go_in = 'l',
          go_in_plus = 'L',
          go_out = 'h',
          go_out_plus = 'H',
          mark_goto = "'",
          mark_set = 'm',
          reset = '<BS>',
          reveal_cwd = '@',
          show_help = 'g?',
          synchronize = '=',
          trim_left = '<',
          trim_right = '>',
        },
        options = {
          permanent_delete = false,
          use_as_default_explorer = true,
        },
        windows = {
          max_number = math.huge,
          preview = true,
          width_focus = 50,
          width_nofocus = 15,
          width_preview = 25,
        },
      }

      require('mini.pick').setup()
      require('mini.colors').setup()
      require('mini.diff').setup {
        view = {
          style = 'sign',
        },
      }
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
