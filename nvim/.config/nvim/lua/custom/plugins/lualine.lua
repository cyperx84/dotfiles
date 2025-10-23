return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    -- Define the custom spinner component first
    local M = require('lualine.component'):extend()

    M.processing = false
    M.spinner_index = 1

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
          elseif request.match == 'CodeCompanionRequestFinished' then
            self.processing = false
          end
        end,
      })
    end

    -- Function that runs every time statusline is updated
    function M:update_status()
      if self.processing then
        self.spinner_index = (self.spinner_index % spinner_symbols_len) + 1
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
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'diff', 'diagnostics' },
        lualine_c = { { 'filename', path = 1 } },
        lualine_x = {
          { 'fileformat', 'filetype' },
          M, -- Add the spinner component here
          {
            require('noice').api.statusline.mode.get,
            cond = require('noice').api.statusline.mode.has,
            color = { fg = '#ff9e64' },
          },
        },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
      extensions = { 'fugitive', 'quickfix', 'fzf', 'lazy', 'mason', 'nvim-dap-ui', 'oil', 'trouble' },
    }
  end,
}

