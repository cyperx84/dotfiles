---@diagnostic disable: undefined-global

return {
  'ravitemer/mcphub.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  build = 'npm install -g mcp-hub@latest',
  cmd = 'MCPHub',
  keys = {
    { '<leader>m', '<cmd>MCPHub<CR>', desc = 'MCPHub' },
  },
  config = function()
    require('mcphub').setup {
      port = 37373,
      config = vim.fn.expand '~/.config/mcphub/servers.json',
      auto_approve = true,
      extensions = {
        codecompanion = {
          show_result_in_chat = true,
          make_vars = true,
          make_slash_commands = true,
        },
      },
      ui = {
        window = {
          width = 0.8,
          height = 0.8,
          border = 'rounded',
          relative = 'editor',
          zindex = 50,
        },
      },
      log = {
        level = vim.log.levels.WARN,
        to_file = false,
        prefix = 'MCPHub',
      },
    }
  end,
}
