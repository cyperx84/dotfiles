return {
  "rcarriga/nvim-notify",
  config = function()
    require("notify").setup({
      background_colour = "#000000", -- or "NotifyBackground" if using a highlight group
      -- add any other settings you want
    })
    vim.notify = require("notify") -- make it the default notification system
  end,
}
