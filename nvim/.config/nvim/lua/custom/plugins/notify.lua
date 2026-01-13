return {
  "rcarriga/nvim-notify",
  keys = {
    { '<leader>sl', '<cmd>Telescope notify<CR>', desc = '[S]earch Notify [L]og' },
  },
  config = function()
    require("notify").setup({
      background_colour = "#000000", -- or "NotifyBackground" if using a highlight group
      stages = "fade_in_slide_out",
      timeout = 50,
      fps = 60,
      render = "compact",
    })
    vim.notify = require("notify") -- make it the default notification system
  end,
}
