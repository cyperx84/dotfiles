return {
  "ThePrimeagen/harpoon",
  config = function()
    local mark = require("harpoon.mark")
    local ui = require("harpoon.ui")

    vim.keymap.set("n", "<C-M-a>", mark.add_file, { desc = "Harpoon: Mark File" })
    vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu, { desc = "Toggle Harpoon Menu" })

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
  end,
}
