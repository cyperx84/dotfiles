return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    -- Define the custom spinner component with optimized animation
    local M = require('lualine.component'):extend()

    M.processing = false
    M.spinner_index = 1
    M.spinner_timer = nil

    local spinner_symbols = {
      '⠋',
      '⠙',
      '⠹',
      '⠸',
      '⠼',
      '⠴',
      '⠦',
      '⠧',
      '⠇',
      '⠏',
    }
    local spinner_symbols_len = 10

    -- Initializer
    function M:init(options)
      M.super.init(self, options)

      local group = vim.api.nvim_create_augroup('CodeCompanionHooks', {})

      vim.api.nvim_create_autocmd({ 'User' }, {
        pattern = 'CodeCompanionRequest*',
        group = group,
        callback = function(request)
          if request.match == 'CodeCompanionRequestStarted' then
            self.processing = true
            self:start_spinner()
          elseif request.match == 'CodeCompanionRequestFinished' then
            self.processing = false
            self:stop_spinner()
          end
        end,
      })
    end

    -- Start spinner animation with timer
    function M:start_spinner()
      if self.spinner_timer then
        self.spinner_timer:close()
      end

      self.spinner_timer = vim.loop.new_timer()
      self.spinner_timer:start(0, 100, vim.schedule_wrap(function()
        if self.processing then
          self.spinner_index = (self.spinner_index % spinner_symbols_len) + 1
          -- Force statusline refresh
          vim.cmd('redrawstatus')
        else
          self:stop_spinner()
        end
      end))
    end

    -- Stop spinner animation
    function M:stop_spinner()
      if self.spinner_timer then
        local ok, err = pcall(function()
          self.spinner_timer:close()
        end)
        if not ok then
          vim.notify('Error stopping spinner: ' .. err, vim.log.levels.WARN)
        end
        self.spinner_timer = nil
      end
      self.spinner_index = 1
      vim.cmd('redrawstatus')
    end

    -- Cleanup on component destruction
    function M:destroy()
      self:stop_spinner()
    end

    -- Function that runs every time statusline is updated
    function M:update_status()
      if self.processing then
        return spinner_symbols[self.spinner_index]
      else
        return nil
      end
    end

    -- Now configure lualine with the custom component
    require('lualine').setup {
      options = {
        theme = {
          normal = {
            a = { fg = '#ffffff', bg = '#1e3a8a', gui = 'bold' },
            b = { fg = '#1e3a8a', bg = '#292e42' },
            c = { fg = '#a9b1d6', bg = '#1a1b26' },
          },
          insert = {
            a = { fg = '#ffffff', bg = '#8b5cf6', gui = 'bold' },
            b = { fg = '#8b5cf6', bg = '#292e42' },
          },
          visual = {
            a = { fg = '#1a1b26', bg = '#bb9af7', gui = 'bold' },
            b = { fg = '#bb9af7', bg = '#292e42' },
          },
          replace = {
            a = { fg = '#1a1b26', bg = '#f7768e', gui = 'bold' },
            b = { fg = '#f7768e', bg = '#292e42' },
          },
          command = {
            a = { fg = '#1a1b26', bg = '#f7768e', gui = 'bold' },
            b = { fg = '#f7768e', bg = '#292e42' },
          },
          terminal = {
            a = { fg = '#1a1b26', bg = '#ff9500', gui = 'bold' },
            b = { fg = '#ff9500', bg = '#292e42' },
            c = { fg = '#a9b1d6', bg = '#1a1b26' },
          },
        },
        component_separators = { left = '│', right = '│' },
        section_separators = { left = '', right = '' },
        refresh = {
          statusline = 1000, -- Update every second for stable components
          tabline = 1000,
          winbar = 1000,
        },
        disabled_filetypes = {
          statusline = {'NvimTree', 'dashboard', 'TelescopePrompt'},
        },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = {
          { 'filename',
            path = 1,
            symbols = {
              modified = '●',
              readonly = '🔒',
              unnamed = '[No Name]',
              newfile = '[New]',
            }
          },
          -- Add breadcrumb navigation if available
          {
            function()
              local navic_ok, navic = pcall(require, 'nvim-navic')
              if navic_ok and navic.is_available() then
                return navic.get_location()
              end
              return ''
            end,
            cond = function()
              local navic_ok = pcall(require, 'nvim-navic')
              return navic_ok and require('nvim-navic').is_available()
            end,
            color = { fg = '#a9b1d6' },
          }
        },
        lualine_x = {
          -- LSP status
          {
            function()
              local clients = vim.lsp.get_clients()
              if #clients > 0 then
                return 'LSP' .. (#clients > 1 and '[' .. #clients .. ']' or '')
              end
              return ''
            end,
            color = { fg = '#7dcfff' },
          },
          { 'encoding', separator = { left = '│' } },
          { 'fileformat', separator = { left = '│' } },
          { 'filetype', separator = { left = '│' } },
          M, -- Add the spinner component here
          {
            function()
              local noice_ok, noice = pcall(require, 'noice')
              if noice_ok and noice.api.statusline.mode.has() then
                return noice.api.statusline.mode.get()
              end
              return ''
            end,
            color = { fg = '#ff9e64' },
          },
        },
        lualine_y = { 'progress', 'searchcount' },
        lualine_z = { 'location' },
      },
      extensions = { 'fugitive', 'quickfix', 'fzf', 'lazy', 'mason', 'nvim-dap-ui', 'oil', 'trouble' },
    }
  end,
}

