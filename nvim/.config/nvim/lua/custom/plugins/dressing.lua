return {
  'stevearc/dressing.nvim',
  event = 'VeryLazy',
  config = function()
    require('dressing').setup {
      input = {
        enabled = true,
        default_prompt = 'Input',
        border = 'rounded',
        relative = 'cursor',
      },
      select = {
        enabled = true,
        backend = { 'telescope', 'builtin' },
        telescope = require('telescope.themes').get_dropdown(),
      },
    }
  end,
}
