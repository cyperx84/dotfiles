return {
  'karb94/neoscroll.nvim',
  event = 'VeryLazy',
  config = function()
    require('neoscroll').setup {
      mappings = {}, -- Disable default mappings, we'll define our own
      hide_cursor = true,
      stop_eof = true,
      respect_scrolloff = true,
      cursor_scrolls_alone = false,
      easing_function = 'sine', -- sine, cubic, quadratic, circular
      pre_hook = nil,
      post_hook = nil,
    }

    local neoscroll = require 'neoscroll'

    -- Custom keymaps with centering
    local keymap = {
      ['<C-u>'] = function()
        neoscroll.ctrl_u { duration = 100 }
        vim.cmd 'normal! zz'
      end,
      ['<C-d>'] = function()
        neoscroll.ctrl_d { duration = 100 }
        vim.cmd 'normal! zz'
      end,
      ['<C-b>'] = function()
        neoscroll.ctrl_b { duration = 250 }
      end,
      ['<C-f>'] = function()
        neoscroll.ctrl_f { duration = 250 }
      end,
    }

    local modes = { 'n', 'v', 'x' }
    for key, func in pairs(keymap) do
      vim.keymap.set(modes, key, func)
    end
  end,
}
