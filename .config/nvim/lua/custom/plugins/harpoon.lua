return {
  'ThePrimeagen/harpoon',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local mark = require 'harpoon.mark'
    local ui = require 'harpoon.ui'

    vim.keymap.set('n', '<M-a>', mark.add_file, {
      desc = 'Harpoon: Mark File',
    })

    vim.keymap.set('n', '<M-e>', ui.toggle_quick_menu, {
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

    vim.keymap.set('n', '<M-j>', function()
      safe_nav_file(1)
    end, {
      desc = 'Harpoon File 1',
    })
    vim.keymap.set('n', '<M-k>', function()
      safe_nav_file(2)
    end, {
      desc = 'Harpoon File 2',
    })
    vim.keymap.set('n', '<M-l>', function()
      safe_nav_file(3)
    end, {
      desc = 'Harpoon File 3',
    })
    vim.keymap.set('n', '<M-h>', function()
      safe_nav_file(4)
    end, {
      desc = 'Harpoon File 4',
    })
    vim.keymap.set('n', '<M-g>', function()
      safe_nav_file(5)
    end, {
      desc = 'Harpoon File 5',
    })
    vim.keymap.set('n', '<M-f>', function()
      safe_nav_file(6)
    end, {
      desc = 'Harpoon File 6',
    })
    vim.keymap.set('n', '<M-d>', function()
      safe_nav_file(7)
    end, {
      desc = 'Harpoon File 7',
    })
    vim.keymap.set('n', '<M-s>', function()
      safe_nav_file(8)
    end, {
      desc = 'Harpoon File 8',
    })
  end,
}
