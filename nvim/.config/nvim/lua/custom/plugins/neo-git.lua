return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
    "echasnovski/mini.pick",
  },
  keys = {
    { "<leader>gg", "<cmd>Neogit kind=floating<CR>", desc = "Floating" },
    { "<leader>gG", "<cmd>Neogit kind=split<CR>", desc = "Auto" },
    { "<leader>gb", "<cmd>Neogit branch kind=auto<CR>", desc = "Branch" },
    { "<leader>gB", "<cmd>Neogit branch_config kind=auto<CR>", desc = "Branch Config" },
    { "<leader>gc", "<cmd>Neogit commit kind=auto<CR>", desc = "Commit" },
    { "<leader>gd", "<cmd>Neogit diff kind=auto<CR>", desc = "Diff" },
    { "<leader>gl", "<cmd>Neogit log kind=auto<CR>", desc = "Log" },
    { "<leader>gs", "<cmd>Neogit stash kind=auto<CR>", desc = "Stash" },
    { "<leader>gm", "<cmd>Neogit merge kind=auto<CR>", desc = "Merge" },
    { "<leader>gP", "<cmd>Neogit pull<CR>", desc = "Pull" },
    { "<leader>gp", "<cmd>Neogit push<CR>", desc = "Push" },
  },
}
