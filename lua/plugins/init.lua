if vim.fn.has('nvim-0.11.2') == 0 then
	vim.api.nvim_echo({
		{ "LazyVim requires Neovim >= 0.11.2\n", "ErrorMsg" },
		{ "For more info, see: https://github.com/LazyVim/LazyVim/issues/6421\n", "Comment" },
		{ "Press any key to exit", "MoreMsg" },
	}, true, {})
	vim.fn.getchar()
	vim.cmd([[quit]])
	return {}
end

return {
	{ 'folke/lazy.nvim', version = '*' },
	{
		--- Source ---
		'folke/snacks.nvim',

		--- Loading ---
		priority = 1000,

		--- Setup ---
		opts = {},
		config = function(_, opts)
			local notify = vim.notify
			require('snacks').setup(opts)

			if Config.has('noice.nvim') then
				vim.notify = notify
			end
		end,

		--- Lazy loading ---
		lazy = false,
	},
}
