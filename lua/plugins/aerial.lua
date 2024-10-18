return {
	--- Source ---
	'stevearc/aerial.nvim',

	--- Loading ---
	dependencies = {
		'nvim-treesitter/nvim-treesitter',
		'nvim-tree/nvim-web-devicons',
	},

	--- Setup ---
	opts = {
		on_attach = function(bufnr)
			-- Jump forwards/backwards with ',' and ';'
			vim.keymap.set('n', ',', ':AerialPrev<CR>', {
				buffer = bufnr,
				silent = true,
				desc = "Go to previous function",
			})
			vim.keymap.set('n', ';', ':AerialNext<CR>', {
				buffer = bufnr,
				silent = true,
				desc = "Go to next function",
			})
		end,
	},
	config = function(_, opts)
		require('aerial').setup(opts)
		-- You probably also want to set a keymap to toggle aerial
		vim.keymap.set('n', '<C-m>', ':AerialToggle!<CR>')
	end,

	--- Lazy Loading ---
	lazy = true,
	event = 'BufRead',
}
