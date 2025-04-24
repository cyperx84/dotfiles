return {
    "GeorgesAlkhouri/nvim-aider",
    cmd = "Aider",
    -- Example key mappings for common actions:
    keys = {
      { "<leader>A/", "<cmd>Aider toggle<cr>", desc = "Toggle Aider" },
      { "<leader>As", "<cmd>Aider send<cr>", desc = "Send to Aider", mode = { "n", "v" } },
      { "<leader>Ac", "<cmd>Aider command<cr>", desc = "Aider Commands" },
      { "<leader>Ab", "<cmd>Aider buffer<cr>", desc = "Send Buffer" },
      { "<leader>A+", "<cmd>Aider add<cr>", desc = "Add File" },
      { "<leader>A-", "<cmd>Aider drop<cr>", desc = "Drop File" },
      { "<leader>Ar", "<cmd>Aider add readonly<cr>", desc = "Add Read-Only" },
      -- Example nvim-tree.lua integration if needed
      { "<leader>A+", "<cmd>AiderTreeAddFile<cr>", desc = "Add File from Tree to Aider", ft = "NvimTree" },
      { "<leader>A-", "<cmd>AiderTreeDropFile<cr>", desc = "Drop File from Tree from Aider", ft = "NvimTree" },
    },
    dependencies = {
      "folke/snacks.nvim",
      --- The below dependencies are optional
      "catppuccin/nvim",
      "nvim-tree/nvim-tree.lua",
      --- Neo-tree integration
      {
        "nvim-neo-tree/neo-tree.nvim",
        opts = function(_, opts)
          -- Example mapping configuration (already set by default)
          -- opts.window = {
          --   mappings = {
          --     ["+"] = { "nvim_aider_add", desc = "add to aider" },
          --     ["-"] = { "nvim_aider_drop", desc = "drop from aider" }
          --   }
          -- }
          require("nvim_aider.neo_tree").setup(opts)
        end,
      },
    },
    config = true,
  }
