return {
	{ -- Useful lua functions for neovim
		--- Source ---
		'nvim-lua/plenary.nvim'
	},
	{ -- Autocompletion for parenthesis, brackets...
		--- Source ---
		'windwp/nvim-autopairs',

		--- Setup ---
		opts = {},

		--- Lazy Loading ---
		lazy = true,
		event = 'InsertCharPre',
	},
	{ -- Easy replacement of parentheses, brackets, quotes, ect by another surrounding pair of characters
		--- Source ---
		'tpope/vim-surround',

		--- Lazy Loading ---
		lazy = true,
		event = 'BufRead',
	},
	{ -- Comment code easily
		--- Source ---
		'tpope/vim-commentary',

		--- Lazy Loading ---
		lazy = true,
		event = 'BufRead',
	},
	{ -- Highlight trailing whitespaces
		--- Source ---
		'ntpeters/vim-better-whitespace',

		--- Lazy Loading ---
		lazy = true,
		event = 'BufRead',
	},
	{ -- Motion bindings improvements
		--- Source ---
		'easymotion/vim-easymotion',

		--- Lazy Loading ---
		lazy = false,
	},
	{
		--- Source ---
		'famiu/bufdelete.nvim',

		--- Setup ---
		config = function()
			vim.keymap.set('n', '<C-F4>', ':Bdelete<CR>:<BS>')
		end,

		--- Lazy loading ---
		lazy = false,
	},
}
