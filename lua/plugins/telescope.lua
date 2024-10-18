return {
	--- Source ---
	'nvim-telescope/telescope.nvim',

	--- Loading ---
	dependencies = {
		'nvim-lua/plenary.nvim',
	},

	--- Setup ---
	opts = {
		defaults = {
			selection_caret = "󱞩 ",
		},
	},
	config = function(_, opts)
		require('telescope').setup(opts)

		local builtin = require('telescope.builtin')
		local map = vim.keymap

		map.set('n', '<C-p>', builtin.find_files, {
			silent = true,
			desc = "Find files with Telescope",
		})
		map.set('n', '<S-p>', builtin.oldfiles, {
			silent = true,
			desc = "Display list of last opened files with Telescope",
		})
		map.set('n', '<C-f>', builtin.live_grep, {
			silent = true,
			desc = "Find character sequences in folder files",
		})
		map.set('n', '<S-f>', builtin.help_tags, {
			silent = true,
			desc = "Display list of plugin help files",
		})
	end,

	--- Lazy Loading ---
	lazy = false,

	--- Versioning ---
	branch = '0.1.x',
}
