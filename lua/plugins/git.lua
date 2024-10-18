return {
	{ -- Git commands
		--- Source ---
		'tpope/vim-fugitive',

		--- Lazy Loading ---
		lazy = false,
	},
	{
		--- Source ---
		'mhinz/vim-signify',

		--- Lazy Loading ---
		lazy = true,
		event = 'BufRead',
	},
}
