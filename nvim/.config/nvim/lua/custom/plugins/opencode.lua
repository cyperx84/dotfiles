---@diagnostic disable: undefined-global, undefined-doc-name, missing-fields
return {
  "NickvanDyke/opencode.nvim",
  dependencies = {
    -- Recommended for `ask()` and `select()`.
    -- Required for `snacks` provider.
    ---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
    { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
  },
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      -- Your configuration, if any — see `lua/opencode/config.lua`, or "goto definition".
    }

    -- Required for `opts.events.reload`.
    vim.o.autoread = true

    -- OpenCode keymaps (using <leader>O to avoid conflicts)
    vim.keymap.set({ "n", "x" }, "<leader>Oa", function() require("opencode").ask("@this: ", { submit = true }) end, { desc = "OpenCode Ask" })
    vim.keymap.set({ "n", "x" }, "<leader>Ox", function() require("opencode").select() end,                          { desc = "OpenCode Execute action" })
    vim.keymap.set({ "n", "t" }, "<M-'>", function() require("opencode").toggle() end,                          { desc = "OpenCode Toggle" })

    vim.keymap.set({ "n", "x" }, "go",  function() return require("opencode").operator("@this ") end,        { expr = true, desc = "Add range to opencode" })
    vim.keymap.set("n",          "goo", function() return require("opencode").operator("@this ") .. "_" end, { expr = true, desc = "Add line to opencode" })
  end,
}
