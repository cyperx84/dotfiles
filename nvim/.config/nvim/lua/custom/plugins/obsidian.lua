return {
  'epwalsh/obsidian.nvim',
  version = '*',
  lazy = true,
  ft = 'markdown',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    require('obsidian').setup {
      workspaces = {
        -- {
        --   name = 'buf-parent',
        --   path = function()
        --     return assert(vim.fs.dirname(vim.api.nvim_buf_get_name(0)))
        --   end,
        -- },
        {
          name = 'ObsidianVault',
          path = '~/Library/Mobile Documents/iCloud~md~obsidian/Documents/notes',
        },
                {
          name = 'ai',
          path = '~/Library/Mobile Documents/iCloud~md~obsidian/Documents/ai/',
        },

      },
      completion = {
        nvim_cmp = true,
        min_chars = 2,
        new_note_search = true,
      },
      new_notes_location = 'notes_subdir',
      -- note_id_func = function(title)
      --   return (title:gsub(" ", "%%20"))
      -- end,
      note_id_func = function(title)
        if title == nil or title == "" then
          return tostring(os.time()) -- fallback to timestamp
        end
        local slug = title
          :gsub('^%s*(.-)%s*$', '%1') -- trim
          :gsub('%s+', '-') -- spaces → dashes
          :gsub('[^%w%-]', '') -- strip punctuation / symbols
          :lower() -- lower‑case
        return slug
      end,
      note_frontmatter_func = function(note)
        local out = { id = note.id, tags = note.tags }

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
      },
      picker = {
        -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
        name = 'telescope.nvim',
        -- Optional, configure key mappings for the picker. These are the defaults.
        -- Not all pickers support all mappings.
        note_mappings = {
          -- Create a new note from your query.
          new = '<C-x>',
          -- Insert a link to the selected note.
          insert_link = '<C-l>',
        },
        tag_mappings = {
          -- Add tag(s) to current note.
          tag_note = '<C-x>',
          -- Insert a tag at the current location.
          insert_tag = '<C-l>',
        },
      },

      -- templates = {
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
    }

    -- Conceal setup for markdown
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'markdown',
      callback = function()
        vim.opt_local.conceallevel = 2
        vim.opt_local.concealcursor = 'nc'
      end,
    })
  end,
}
