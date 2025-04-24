return {
  "ThePrimeagen/harpoon",            -- default → v1
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local mark = require("harpoon.mark")
    local ui   = require("harpoon.ui")

    -- mark the current file
    vim.keymap.set("n", "<C-M-a>", mark.add_file, {
      desc = "Harpoon: Mark File",
    })

    -- toggle the quick-menu (no args in v1!)
    vim.keymap.set("n", "<C-M-e>", ui.toggle_quick_menu, {
      desc = "Harpoon: Toggle Menu",
    })

    -- jump to a specific slot
    vim.keymap.set("n", "<C-M-j>", function() ui.nav_file(1) end, {
      desc = "Harpoon File 1",
    })
    vim.keymap.set("n", "<C-M-k>", function() ui.nav_file(2) end, {
      desc = "Harpoon File 2",
    })
    vim.keymap.set("n", "<C-M-l>", function() ui.nav_file(3) end, {
      desc = "Harpoon File 3",
    })
    vim.keymap.set("n", "<C-M-;>", function() ui.nav_file(4) end, {
      desc = "Harpoon File 4",
    })
    vim.keymap.set("n", "<C-M-s>", function() ui.nav_file(5) end, {
      desc = "Harpoon File 5",
    })
    vim.keymap.set("n", "<C-M-d>", function() ui.nav_file(6) end, {
      desc = "Harpoon File 6",
    })
    vim.keymap.set("n", "<C-M-f>", function() ui.nav_file(7) end, {
      desc = "Harpoon File 7",
    })
  end,
}
