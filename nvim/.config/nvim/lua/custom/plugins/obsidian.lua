-- =============================================================================
-- Obsidian.nvim Configuration
-- =============================================================================
-- Plugin: https://github.com/obsidian-nvim/obsidian.nvim
-- Requires: ripgrep (rg) for search functionality
-- =============================================================================

-- =============================================================================
-- LOCAL HELPER FUNCTIONS
-- =============================================================================

--- Show backlinks for the current note using telescope
--- Workaround: The built-in :Obsidian backlinks command has a bug where the LSP
--- references handler doesn't return results to the picker, even though the
--- underlying search works correctly. This function uses note:backlinks() directly.
--- Issue: Can be removed when upstream fixes the backlinks command
---@return nil
local function show_backlinks()
  local api = require('obsidian.api')
  local note = api.current_note(0, {})

  if not note then
    vim.notify('No note found in vault', vim.log.levels.ERROR)
    return
  end

  local backlinks = note:backlinks({ timeout = 5000 })

  if #backlinks == 0 then
    vim.notify('No backlinks found for ' .. note.id, vim.log.levels.INFO)
    return
  end

  local qf_list = {}
  for _, bl in ipairs(backlinks) do
    table.insert(qf_list, {
      filename = tostring(bl.path),
      lnum = bl.line,
      col = bl.start or 1,
      text = bl.text or '',
    })
  end

  vim.fn.setqflist(qf_list, 'r')
  vim.fn.setqflist({}, 'a', { title = 'Backlinks to ' .. note.id })
  require('telescope.builtin').quickfix({ prompt_title = 'Backlinks to ' .. note.id })
end

--- Rename the current note (updates frontmatter id/title and filename)
---@return nil
local function rename_note()
  vim.ui.input({ prompt = 'New note name: ' }, function(new_name)
    if not new_name or new_name == '' then
      return
    end

    local bufnr = vim.api.nvim_get_current_buf()
    local current_file = vim.api.nvim_buf_get_name(bufnr)
    local current_dir = vim.fn.fnamemodify(current_file, ':h')
    local new_path = current_dir .. '/' .. new_name .. '.md'

    -- Allow case-only renames on macOS (filesystem is case-insensitive)
    local is_case_only_rename = current_file:lower() == new_path:lower()
    if vim.fn.filereadable(new_path) == 1 and not is_case_only_rename then
      vim.notify('Error: File "' .. new_name .. '.md" already exists', vim.log.levels.ERROR)
      return
    end

    local save_ok, save_err = pcall(vim.cmd, 'w')
    if not save_ok then
      vim.notify('Error: Failed to save current file: ' .. tostring(save_err), vim.log.levels.ERROR)
      return
    end

    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local new_id = new_name:gsub('^%s*(.-)%s*$', '%1'):gsub('%s+', '-'):gsub('[^%w%-]', '')

    -- Update frontmatter fields
    for i = 1, #lines do
      if lines[i]:match('^id:') then
        lines[i] = 'id: ' .. new_id
      elseif lines[i]:match('^title:') then
        lines[i] = 'title: ' .. new_name
      end
    end

    local write_ok = pcall(vim.fn.writefile, lines, current_file)
    if not write_ok then
      vim.notify('Error: Failed to write file', vim.log.levels.ERROR)
      return
    end

    if current_file ~= new_path then
      vim.fn.system('mv ' .. vim.fn.shellescape(current_file) .. ' ' .. vim.fn.shellescape(new_path))
    end

    pcall(vim.cmd, 'edit ' .. vim.fn.fnameescape(new_path))
    vim.notify('Renamed to: ' .. new_name, vim.log.levels.INFO)
  end)
end

--- Toggle checkbox on multiple lines (visual mode helper)
---@param start_line integer
---@param end_line integer
---@return nil
local function toggle_checkboxes_range(start_line, end_line)
  if start_line > end_line then
    start_line, end_line = end_line, start_line
  end
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'x', false)
  for line = start_line, end_line do
    vim.api.nvim_win_set_cursor(0, { line, 0 })
    require('obsidian').util.toggle_checkbox()
  end
end

-- =============================================================================
-- MONKEY-PATCHES FOR UPSTREAM BUGS
-- =============================================================================

--- Apply fixes for obsidian.nvim picker bugs
--- Workaround: The tag picker expects entry.user_data as string, but Telescope
--- returns {tag="x"} for existing tags. This normalizes the format.
--- Issue: Can be removed when upstream fixes tag picker data handling
local function apply_tag_picker_fixes()
  local ok, mappings = pcall(require, 'obsidian.picker.mappings')
  if not ok then
    return
  end

  local orig_insert_tag = mappings.insert_tag
  local orig_tag_note = mappings.tag_note

  local function normalize_entry(entry)
    if type(entry) == 'string' then
      return { user_data = entry }
    end
    if type(entry) == 'table' and entry.user_data then
      if type(entry.user_data) == 'table' and entry.user_data.tag then
        entry.user_data = entry.user_data.tag
      end
    end
    return entry
  end

  mappings.insert_tag = function(entry)
    return orig_insert_tag(normalize_entry(entry))
  end

  mappings.tag_note = function(...)
    local entries = { ... }
    for i, entry in ipairs(entries) do
      entries[i] = normalize_entry(entry)
    end

    -- Fix: Ensure calling_bufnr is valid (broken in fresh vaults with no tags)
    local picker = require('obsidian.picker')
    if not picker.state.calling_bufnr or not vim.api.nvim_buf_is_valid(picker.state.calling_bufnr) then
      local alt_buf = vim.fn.bufnr('#')
      if alt_buf ~= -1 and vim.api.nvim_buf_is_valid(alt_buf) then
        picker.state.calling_bufnr = alt_buf
      else
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].filetype == 'markdown' then
            picker.state.calling_bufnr = buf
            break
          end
        end
      end
    end

    return orig_tag_note(unpack(entries))
  end
end

-- =============================================================================
-- PLUGIN SPECIFICATION
-- =============================================================================

return {
  'obsidian-nvim/obsidian.nvim',
  version = '*',
  lazy = true,
  ft = 'markdown',

  config = function()
    -- =========================================================================
    -- CORE SETUP
    -- =========================================================================
    require('obsidian').setup({
      -- Workspaces
      workspaces = {
        { name = 'notes', path = vim.fn.expand('~/Library/Mobile Documents/iCloud~md~obsidian/Documents/notes') },
        { name = 'snowboarding', path = vim.fn.expand('~/Library/Mobile Documents/iCloud~md~obsidian/Documents/snowboarding') },
        { name = 'cyperx', path = vim.fn.expand('~/Library/Mobile Documents/iCloud~md~obsidian/Documents/cyperx') },
      },

      -- Daily notes
      daily_notes = {
        folder = 'inbox',
        date_format = '%Y-%m-%d',
        alias_format = '%B %-d, %Y',
        default_tags = { 'daily-note' },
        template = 'daily.md',
      },

      -- Completion
      completion = {
        blink = true,
        min_chars = 2,
      },

      -- Note creation
      new_notes_location = 'current_dir',

      -- Templates
      templates = {
        folder = 'templates',
        date_format = '%Y-%m-%d',
        time_format = '%H:%M',
      },

      -- Note ID: URL-friendly slugs
      note_id_func = function(title)
        if title == nil or title == '' then
          return tostring(os.time())
        end
        return title:gsub('^%s*(.-)%s*$', '%1'):gsub('%s+', '-'):gsub('[^%w%-]', '')
      end,

      -- Frontmatter
      frontmatter = {
        enabled = function(filename)
          local documents_path = vim.fn.expand('~/Library/Mobile Documents/iCloud~md~obsidian/Documents')
          local absolute_filename = vim.fn.fnamemodify(filename, ':p')
          return absolute_filename:match('^' .. vim.pesc(documents_path)) ~= nil
        end,

        func = function(note)
          local now = os.date('%Y-%m-%d %H:%M')
          local out = {
            id = note.id,
            title = note.title or '',
            created = (note.metadata and note.metadata.created) or now,
            modified = now,
            reviewed = (note.metadata and note.metadata.reviewed) or nil,
            tags = note.tags or {},
            topics = (note.metadata and note.metadata.topics) or {},
            refs = (note.metadata and note.metadata.refs) or {},
            aliases = note.aliases or {},
            base = (note.metadata and note.metadata.base) or nil,
          }

          -- Preserve custom metadata fields
          if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
            local handled = { 'created', 'modified', 'reviewed', 'topics', 'refs', 'base' }
            for k, v in pairs(note.metadata) do
              if not vim.tbl_contains(handled, k) then
                out[k] = v
              end
            end
          end

          return out
        end,
      },

      -- Attachments
      attachments = {
        img_folder = 'assets/imgs',
        img_name_func = function()
          return os.date('%Y-%m-%d-%H%M%S')
        end,
        img_text_func = function(path)
          local filename = vim.fn.fnamemodify(path.filename, ':t')
          return string.format('![%s](assets/imgs/%s)', path.name, filename)
        end,
      },

      -- Link style: Use markdown links [text](file.md) instead of wiki [[links]]
      preferred_link_style = 'markdown',
      markdown_link_func = require('obsidian.builtin').markdown_link,
      wiki_link_func = 'use_alias_only', -- Fallback for wiki links if needed

      -- URL handling
      follow_url_func = function(url)
        vim.fn.jobstart({ 'open', url }, { detach = true })
      end,

      -- Picker (telescope)
      picker = {
        name = 'telescope.nvim',
        note_mappings = { new = '<C-x>', insert_link = '<C-l>' },
        tag_mappings = { tag_note = '<C-x>', insert_tag = '<C-l>' },
        sort_by = 'modified',
        sort_reversed = true,
      },

      -- UI (disabled in favor of render-markdown.nvim)
      ui = { enable = false },

      -- Parser
      yaml_parser = 'native',

      -- Use new command format (:Obsidian xxx)
      legacy_commands = false,
    })

    -- =========================================================================
    -- APPLY MONKEY-PATCHES
    -- =========================================================================
    vim.schedule(apply_tag_picker_fixes)

    -- =========================================================================
    -- MARKDOWN FILE SETTINGS & KEYMAPS
    -- =========================================================================
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'markdown',
      callback = function()
        local opts = { buffer = true }

        -- Buffer settings
        vim.opt_local.autoread = true
        vim.opt_local.conceallevel = 2
        vim.opt_local.concealcursor = 'nc'

        -- Snacks image rendering (delayed for treesitter)
        vim.defer_fn(function()
          local ok, snacks = pcall(require, 'snacks')
          if ok and snacks.image and snacks.image.doc then
            snacks.image.doc._attach(vim.api.nvim_get_current_buf())
          end
        end, 100)

        -- Core keymaps
        vim.keymap.set('n', 'gf', '<cmd>Obsidian follow_link<CR>', { buffer = true, desc = 'Follow link under cursor' })
        vim.keymap.set('n', '<cr>', function()
          return require('obsidian').util.smart_action()
        end, { buffer = true, expr = true, desc = 'Smart action' })

        -- Checkbox toggle
        vim.keymap.set('n', '<leader>ch', function()
          return require('obsidian').util.toggle_checkbox()
        end, vim.tbl_extend('force', opts, { desc = 'Toggle [Ch]eckbox' }))

        vim.keymap.set('n', '<leader>oc', function()
          return require('obsidian').util.toggle_checkbox()
        end, vim.tbl_extend('force', opts, { desc = '[O]bsidian Toggle [C]heckbox' }))

        vim.keymap.set('v', '<leader>oc', function()
          toggle_checkboxes_range(vim.fn.line('v'), vim.fn.line('.'))
        end, vim.tbl_extend('force', opts, { desc = '[O]bsidian Toggle [C]heckbox (Visual)' }))

        -- Note operations
        vim.keymap.set('n', '<leader>on', ':Obsidian new<CR>', vim.tbl_extend('force', opts, { desc = '[O]bsidian [N]ew note' }))
        vim.keymap.set('n', '<leader>oo', ':Obsidian open<CR>', vim.tbl_extend('force', opts, { desc = '[O]bsidian [O]pen in app' }))
        vim.keymap.set('n', '<leader>of', ':Obsidian quick_switch<CR>', vim.tbl_extend('force', opts, { desc = '[O]bsidian [F]ind note' }))
        vim.keymap.set('n', '<leader>or', rename_note, vim.tbl_extend('force', opts, { desc = '[O]bsidian [R]ename' }))

        -- Template operations
        vim.keymap.set('n', '<leader>oT', ':Obsidian new_from_template<CR>', vim.tbl_extend('force', opts, { desc = '[O]bsidian New from [T]emplate' }))
        vim.keymap.set('n', '<leader>op', ':Obsidian template<CR>', vim.tbl_extend('force', opts, { desc = '[O]bsidian Insert tem[P]late' }))

        -- Search & navigation
        vim.keymap.set('n', '<leader>os', ':Obsidian search<CR>', vim.tbl_extend('force', opts, { desc = '[O]bsidian [S]earch' }))
        vim.keymap.set('n', '<leader>ob', show_backlinks, vim.tbl_extend('force', opts, { desc = '[O]bsidian [B]acklinks' }))
        vim.keymap.set('n', '<leader>ol', ':Obsidian links<CR>', vim.tbl_extend('force', opts, { desc = '[O]bsidian [L]inks' }))
        vim.keymap.set('n', '<leader>ot', ':Obsidian tags<CR>', vim.tbl_extend('force', opts, { desc = '[O]bsidian [T]ags' }))
        vim.keymap.set('n', '<leader>oF', ':Obsidian follow_link<CR>', vim.tbl_extend('force', opts, { desc = '[O]bsidian [F]ollow link' }))
        vim.keymap.set('n', '<leader>ox', ':Obsidian toc<CR>', vim.tbl_extend('force', opts, { desc = '[O]bsidian Table of Contents' }))

        -- Daily notes
        vim.keymap.set('n', '<leader>od', ':Obsidian today<CR>', vim.tbl_extend('force', opts, { desc = '[O]bsidian [D]aily note' }))
        vim.keymap.set('n', '<leader>oy', ':Obsidian yesterday<CR>', vim.tbl_extend('force', opts, { desc = '[O]bsidian [Y]esterday' }))
        vim.keymap.set('n', '<leader>om', ':Obsidian tomorrow<CR>', vim.tbl_extend('force', opts, { desc = '[O]bsidian To[m]orrow' }))

        -- Workspace & utilities
        vim.keymap.set('n', '<leader>ow', ':Obsidian workspace<CR>', vim.tbl_extend('force', opts, { desc = '[O]bsidian Switch [W]orkspace' }))
        vim.keymap.set('n', '<leader>oi', ':Obsidian paste_img<CR>', vim.tbl_extend('force', opts, { desc = '[O]bsidian Paste [I]mage' }))

        -- Visual mode
        vim.keymap.set('v', '<leader>oe', ':Obsidian extract_note<CR>', vim.tbl_extend('force', opts, { desc = '[O]bsidian [E]xtract note' }))
        vim.keymap.set('v', '<leader>oL', ':Obsidian link<CR>', vim.tbl_extend('force', opts, { desc = '[O]bsidian [L]ink selection' }))
        vim.keymap.set('v', '<leader>oln', ':Obsidian link_new<CR>', vim.tbl_extend('force', opts, { desc = '[O]bsidian [L]ink [N]ew' }))
      end,
    })

    -- =========================================================================
    -- AUTO-RELOAD FOR EXTERNAL CHANGES
    -- =========================================================================
    vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold' }, {
      pattern = '*.md',
      callback = function()
        if vim.fn.mode() ~= 'c' then
          vim.cmd('checktime')
        end
      end,
      desc = 'Auto-reload markdown files when changed externally',
    })
  end,
}
