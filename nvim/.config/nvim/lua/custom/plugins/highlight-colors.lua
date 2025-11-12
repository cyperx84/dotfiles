return {
	'brenoprata10/nvim-highlight-colors',
	config = function()
		require('nvim-highlight-colors').setup({
			render = 'background',
			enable_hex = true,
			enable_short_hex = true,
			enable_rgb = true,
			enable_hsl = true,
			enable_var_usage = true,
		})
	end,
}
