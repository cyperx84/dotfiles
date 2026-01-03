return {
  'karb94/neoscroll.nvim',
  event = 'VeryLazy',
  config = function()
    require('neoscroll').setup {
      mappings = {}, -- Disable default mappings, we'll define our own
      hide_cursor = true,
      stop_eof = true,
      respect_scrolloff = true,
      cursor_scrolls_alone = true, -- Allow cursor to move even when view can't scroll
      easing_function = 'sine', -- sine, cubic, quadratic, circular
      pre_hook = nil,
      post_hook = function(info)
        -- Smart center: only zz when in the middle of the buffer
        -- Skip centering at edges OR on short files that fit on screen
        if info == 'up' or info == 'down' then
          local at_top = vim.fn.line 'w0' == 1
          local at_bottom = vim.fn.line 'w$' >= vim.fn.line '$'
          -- Only center if we can scroll both ways (truly in the middle)
          if not at_top and not at_bottom then
            vim.cmd 'normal! zz'
          end
        end
      end,
    }

    local neoscroll = require 'neoscroll'

    -- Custom keymaps - post_hook handles smart centering
    local keymap = {
      ['<C-u>'] = function()
        neoscroll.ctrl_u { duration = 100, info = 'up' }
      end,
      ['<C-d>'] = function()
        neoscroll.ctrl_d { duration = 100, info = 'down' }
      end,
      ['<C-b>'] = function()
        neoscroll.ctrl_b { duration = 250, info = 'up' }
      end,
      ['<C-f>'] = function()
        neoscroll.ctrl_f { duration = 250, info = 'down' }
      end,
    }

    local modes = { 'n', 'v', 'x' }
    for key, func in pairs(keymap) do
      vim.keymap.set(modes, key, func)
    end
  end,
}
