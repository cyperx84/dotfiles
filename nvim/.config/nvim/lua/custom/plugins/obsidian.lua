return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("obsidian").setup({
      workspaces = {
        {
          name = "buf-parent",
          path = function()
            return assert(vim.fs.dirname(vim.api.nvim_buf_get_name(0)))
          end,
        },
        {
          name = "ObsidianVault",
          path = "/Users/cyperx/vaults/brain",
        },
        {
          name = "CodeVault",
          path = "/Users/cyperx/vaults/code-vault",
        },
        {
          name = "IncludeVault",
          path = "/Users/cyperx/vaults/include-vault",
        },
        {
          name = "MusicVault",
          path = "/Users/cyperx/vaults/music-vault",
        },
        {
          name = "SnowVault",
          path = "/Users/cyperx/vaults/snow-vault",
        },
      },
      completion = {
        default = true,
        nvim_cmp = true,
        min_chars = 2,
        new_note_search = true,
      },
      new_notes_location = "notes_subdir",
      -- note_id_func = function(title)
      --   return (title:gsub(" ", "%%20"))
      -- end,
      note_id_func = function(title)
        local slug = title
          :gsub("^%s*(.-)%s*$", "%1")   -- trim
          :gsub("%s+", "-")            -- spaces → dashes
          :gsub("[^%w%-]", "")         -- strip punctuation / symbols
          :lower()                     -- lower‑case
        return slug
      end,
      note_frontmatter_func = function(note)
        local out = { id = note.id, aliases = note.aliases, tags = note.tags }

        if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
          for k, v in pairs(note.metadata) do
            out[k] = v
          end
        end

        return out
      end,
      mappings = {
        -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
        ['gf'] = {
          action = function()
            return require('obsidian').util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true },
        },
        -- Toggle check-boxes.
        ['<leader>ch'] = {
          action = function()
            return require('obsidian').util.toggle_checkbox()
          end,
          opts = { buffer = true },
        },
      },      -- templates = {
      --   subdir = "Templates",
      --   date_format = "%Y-%m-%d",
      --   time_format = "%H:%M",
      --   tags = "",
      --   substitutions = {
      --     yesterday = function()
      --       return os.date("%Y-%m-%d", os.time() - 86400)
      --     end,
      --     tomorrow = function()
      --       return os.date("%Y-%m-%d", os.time() + 86400)
      --     end,
      --   },
      -- },

      ui = {
        enable = false, -- using render-markdown.nvim instead
      },
    })

    -- Conceal setup for markdown
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "markdown",
      callback = function()
        vim.opt_local.conceallevel = 2
        vim.opt_local.concealcursor = "nc"
      end,
    })
  end,
}
