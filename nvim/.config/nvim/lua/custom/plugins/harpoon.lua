return {
  'ThePrimeagen/harpoon',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local mark = require 'harpoon.mark'
    local ui = require 'harpoon.ui'

    -- Setup Harpoon
    require('harpoon').setup({
      menu = {
        width = 60,
        height = 10,
      }
    })

    vim.keymap.set('n', '<leader>hm', mark.add_file, {
      desc = 'Harpoon: Mark File',
    })

    vim.keymap.set('n', '<leader>h', ui.toggle_quick_menu, {
      desc = 'Harpoon: Toggle Menu',
    })

    vim.keymap.set('n', '<M-1>', function()
      ui.nav_file(1)
    end, {
      desc = 'Harpoon File 1',
    })
    vim.keymap.set('n', '<M-2>', function()
      ui.nav_file(2)
    end, {
      desc = 'Harpoon File 2',
    })
    vim.keymap.set('n', '<M-3>', function()
      ui.nav_file(3)
    end, {
      desc = 'Harpoon File 3',
    })
    vim.keymap.set('n', '<M-4>', function()
      ui.nav_file(4)
    end, {
      desc = 'Harpoon File 4',
    })
    vim.keymap.set('n', '<M-5>', function()
      ui.nav_file(5)
    end, {
      desc = 'Harpoon File 5',
    })
    vim.keymap.set('n', '<M-6>', function()
      ui.nav_file(6)
    end, {
      desc = 'Harpoon File 6',
    })
  end,
}
