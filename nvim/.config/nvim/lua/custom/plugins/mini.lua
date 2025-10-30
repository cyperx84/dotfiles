return {
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()
      -- Session management with auto-load and auto-save
      require('mini.sessions').setup {
        -- Automatically read default session when opening Neovim without files
        autoread = false,  -- Keep false to always show dashboard on startup
        -- Automatically save current session before switching or quitting
        autowrite = true,
        -- Global sessions stored in standard location
        directory = vim.fn.stdpath 'data' .. '/sessions',
        -- Local session file name (in current working directory)
        file = 'Session.vim',
        -- Force options (be careful with these)
        force = { read = false, write = true, delete = false },
        -- Show session path after actions (helpful when learning)
        verbose = { read = true, write = true, delete = true },
      }
      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = vim.g.have_nerd_font }
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end
      -- File explorer with column view (Miller columns)
      require('mini.files').setup {
        -- Customization of shown content
        content = {
          filter = nil, -- Show all files by default
          prefix = nil, -- Use default icons
          sort = nil, -- Use default sort (directories first, then alphabetically)
        },
        -- Mappings inside the explorer
        mappings = {
          close = 'q',
          go_in = 'l',
          go_in_plus = 'L', -- Open file and close explorer
          go_out = 'h',
          go_out_plus = 'H', -- Go out and trim right
          mark_goto = "'",
          mark_set = 'm',
          reset = '<BS>',
          reveal_cwd = '@',
          show_help = 'g?',
          synchronize = '=', -- Apply file system changes
          trim_left = '<',
          trim_right = '>',
        },
        options = {
          permanent_delete = false, -- Delete permanently instead of to trash
          use_as_default_explorer = true, -- Replace netrw
        },
        windows = {
          max_number = math.huge, -- No limit on windows
          preview = true, -- Don't show preview by default
          width_focus = 50,
          width_nofocus = 15,
          width_preview = 25,
        },
      }

      require('mini.pick').setup()
      require('mini.colors').setup()
      -- Diff visualization (git changes in signcolumn)
      require('mini.diff').setup {
        view = {
          style = 'sign', -- Show changes in sign column
        },
      }
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
