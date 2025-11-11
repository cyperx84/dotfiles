return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  opts = {
    routes = {
      {
        filter = { event = 'notify', find = 'No information available' },
        opts = { skip = true },
      },
      {
        filter = { event = 'notify', find = 'Native terminal opened' },
        opts = { skip = true },
      },
    },
    presets = {
      lsp_doc_border = true,
    },
  },
  dependencies = {
    'MunifTanjim/nui.nvim',
    'rcarriga/nvim-notify',
  },
}
