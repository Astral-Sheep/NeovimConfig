return {
	--- Source ---
	'nvim-tree/nvim-tree.lua',

	--- Setup ---
	config = function()
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		require('nvim-tree').setup()

		vim.keymap.set('n', '<C-b>', ':NvimTreeFindFileToggle<CR>')
	end,

	--- Lazy Loading ---
	lazy = false,
}
