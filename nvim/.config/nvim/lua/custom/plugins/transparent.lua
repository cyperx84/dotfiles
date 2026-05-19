-- transparent.nvim's toggle() calls vim.cmd.colorscheme() which triggers hi-clear,
-- wiping milli.nvim's MilliSplash_* groups. Milli's hl_cache holds stale names and
-- never recreates them, so the animation loses all color.
-- Fix: manage transparency directly with nvim_set_hl — never call colorscheme.

local on = true
local saved = {}
local groups = {
  'Normal', 'NormalNC', 'LineNr', 'NonText', 'SignColumn',
  'CursorLine', 'CursorLineNr', 'StatusLine', 'StatusLineNC', 'EndOfBuffer',
}

local function set(transparent)
  on = transparent
  vim.g.transparent_enabled = transparent
  for _, g in ipairs(groups) do
    if transparent then
      local hl = vim.api.nvim_get_hl(0, { name = g, link = false })
      hl.bg, hl.ctermbg = nil, nil
      vim.api.nvim_set_hl(0, g, hl)
    elseif saved[g] then
      vim.api.nvim_set_hl(0, g, saved[g])
    end
  end
end

return {
  "xiyaowong/transparent.nvim",
  lazy = false,
  keys = {
    { '<leader>tt', function() set(not on) end, desc = 'Transparent Toggle' },
  },
  config = function()
    for _, g in ipairs(groups) do
      saved[g] = vim.api.nvim_get_hl(0, { name = g, link = false })
    end
    set(true)
  end,
}
