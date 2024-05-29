require('telescope').setup{
	defaults = {
		selection_caret = "󱞩 ",
	},
}

local builtin = require('telescope.builtin')
local map = vim.keymap

map.set('n', '<C-p>', builtin.find_files, {})
map.set('n', '<S-p>', builtin.oldfiles, {})
map.set('n', '<C-f>', builtin.live_grep, {})
map.set('n', '<S-f>', builtin.help_tags, {})

