return {
  'mfussenegger/nvim-dap-python',
  ft = 'python',
  dependancies = {
    'mfussenegger/nvim-dap',
  },
  config = function()
    require('dap-python').setup '~/.virtualenvs/debugpy/bin/python'
  end,
}
