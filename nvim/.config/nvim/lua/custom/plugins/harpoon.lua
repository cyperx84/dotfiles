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

    vim.keymap.set('n', '<M-m>', mark.add_file, {
      desc = 'Harpoon: Mark File',
    })

    vim.keymap.set('n', '<leader>h', ui.toggle_quick_menu, {
      desc = 'Harpoon: Toggle Menu',
    })

    vim.keymap.set('n', '<M-j>', function()
      ui.nav_file(1)
    end, {
      desc = 'Harpoon File 1',
    })
    vim.keymap.set('n', '<M-k>', function()
      ui.nav_file(2)
    end, {
      desc = 'Harpoon File 2',
    })
    vim.keymap.set('n', '<M-l>', function()
      ui.nav_file(3)
    end, {
      desc = 'Harpoon File 3',
    })
    vim.keymap.set('n', '<M-u>', function()
      ui.nav_file(4)
    end, {
      desc = 'Harpoon File 4',
    })
    vim.keymap.set('n', '<M-i>', function()
      ui.nav_file(5)
    end, {
      desc = 'Harpoon File 5',
    })
    vim.keymap.set('n', '<M-o>', function()
      ui.nav_file(6)
    end, {
      desc = 'Harpoon File 6',
    })
  end,
}
