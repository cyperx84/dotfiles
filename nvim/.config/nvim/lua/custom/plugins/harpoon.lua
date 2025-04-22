return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  requires = { {"nvim-lua/plenary.nvim"} },
  config = function()
    local mark = require("harpoon.mark")
    local ui = require("harpoon.ui")

    vim.keymap.set("n", "<C-M-a>", mark.add_file, { desc = "Harpoon: Mark File" })
    vim.keymap.set("n", "<C-M-e>", ui.toggle_quick_menu, { desc = "Toggle Harpoon Menu" })

    vim.keymap.set("n", "<C-M-j>", function()
      ui.nav_file(1)
    end, { desc = "Harpoon File 1" })
    vim.keymap.set("n", "<C-M-k>", function()
      ui.nav_file(2)
    end, { desc = "Harpoon File 2" })
    vim.keymap.set("n", "<C-M-l>", function()
      ui.nav_file(3)
    end, { desc = "Harpoon File 3" })
    vim.keymap.set("n", "<C-M-h>", function()
      ui.nav_file(4)
    end, { desc = "Harpoon File 4" })
    vim.keymap.set("n", "<C-M-s>", function()
      ui.nav_file(5)
    end, { desc = "Harpoon File 5" })
    vim.keymap.set("n", "<C-M-d>", function()
      ui.nav_file(6)
    end, { desc = "Harpoon File 6" })
    vim.keymap.set("n", "<C-M-f>", function()
      ui.nav_file(7)
    end, { desc = "Harpoon File 7" })
  end,
}
