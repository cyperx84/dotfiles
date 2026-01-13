return {
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    keys = {
      -- MiniDiff
      { '<leader>td', function() require('mini.diff').toggle_overlay(0) end, desc = 'Toggle MiniDiff' },
      -- Session Management (mini.sessions)
      { '<leader>Ss', function()
        vim.ui.input({ prompt = 'Session name: ' }, function(input)
          if input then
            require('mini.sessions').write(input)
            vim.notify('Session saved: ' .. input, vim.log.levels.INFO)
          end
        end)
      end, desc = '[S]ession [S]ave' },
      { '<leader>Sh', function()
        vim.cmd('%bdelete')
        if vim.fn.exists(':Snacks') == 2 then
          Snacks.dashboard()
        end
      end, desc = '[S]ession [H]ome (Dashboard)' },
      { '<leader>Sn', function() require('mini.sessions').read('notes') end, desc = '[S]ession open [N]otes' },
      { '<leader>Sd', function() require('mini.sessions').read('dotfiles') end, desc = '[S]ession open [D]otfiles' },
      { '<leader>Sc', function() require('mini.sessions').read('code') end, desc = '[S]ession open [C]ode' },
      { '<leader>Sl', function() require('mini.sessions').select('read') end, desc = '[S]ession [L]oad (select)' },
      { '<leader>Sr', function()
        vim.ui.input({ prompt = 'Session name to restore: ', default = 'notes' }, function(input)
          if input then
            require('mini.sessions').read(input)
          end
        end)
      end, desc = '[S]ession [R]estore by name' },
      { '<leader>Sx', function() require('mini.sessions').select('delete') end, desc = '[S]ession delete (select)' },
      { '<leader>Sw', function()
        require('mini.sessions').write()
        vim.notify('Current session saved', vim.log.levels.INFO)
      end, desc = '[S]ession [W]rite current' },
    },
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
