return {
  'ThePrimeagen/harpoon',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local mark = require 'harpoon.mark'
    local ui = require 'harpoon.ui'

    vim.keymap.set('n', '<D-S-m>', mark.add_file, {
      desc = 'Harpoon: Mark File',
    })

    vim.keymap.set('n', '<D-S-e>', ui.toggle_quick_menu, {
      desc = 'Harpoon: Toggle Menu',
    })

    local function safe_nav_file(id)
      local ok, err = pcall(ui.nav_file, id)
      if not ok then
        -- Handle E325 (swap file exists) by attempting recovery
        if err:find('E325') then
          vim.notify('Harpoon: Swap file detected, recovering...', vim.log.levels.WARN)
          -- Ignore the error and let Neovim handle it naturally
        else
          vim.notify('Harpoon: Navigation error - ' .. tostring(err), vim.log.levels.ERROR)
        end
      end
    end

    vim.keymap.set('n', '<D-S-j>', function()
      safe_nav_file(1)
    end, {
      desc = 'Harpoon File 1',
    })
    vim.keymap.set('n', '<D-S-k>', function()
      safe_nav_file(2)
    end, {
      desc = 'Harpoon File 2',
    })
    vim.keymap.set('n', '<D-S-l>', function()
      safe_nav_file(3)
    end, {
      desc = 'Harpoon File 3',
    })
    vim.keymap.set('n', '<D-S-1>', function()
      safe_nav_file(4)
    end, {
      desc = 'Harpoon File 4',
    })
    vim.keymap.set('n', '<D-S-2>', function()
      safe_nav_file(5)
    end, {
      desc = 'Harpoon File 5',
    })
    vim.keymap.set('n', '<D-S-3>', function()
      safe_nav_file(6)
    end, {
      desc = 'Harpoon File 6',
    })
    vim.keymap.set('n', '<D-S-4>', function()
      safe_nav_file(7)
    end, {
      desc = 'Harpoon File 7',
    })
    vim.keymap.set('n', '<D-S-5>', function()
      safe_nav_file(8)
    end, {
      desc = 'Harpoon File 8',
    })
  end,
}
