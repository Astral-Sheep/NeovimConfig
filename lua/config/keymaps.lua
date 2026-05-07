local function stop_snippet()
	vim.cmd('noh')
	Config.cmp.actions.snippet_stop()
	return '<esc>'
end

-- All custom keymaps are added here
return {
	['n'] = {
		{ '<C-F1>', ':q<CR>', { desc = "Close current window" } },
		{ '<CS-F1>', ':qa<CR>', { desc = "Close all windows / close Neovim" } },
		{ '<C-z>', 'u', { desc = "Undo" } },
		{ '<C-y>', '<C-r>', { desc = "Redo" } },
		{ '<C-s>', ':w<CR>', { desc = "Save" } },
		{ '<S-s>', ':w!<CR>', { desc = "Overwrite file" } },
		{ '<CS-Up>', ':res +2<CR>', { silent = true, desc = "Increase window vertical size" } },
		{ '<CS-Down>', ':res -2<CR>', { silent = true, desc = "Decrease window vertical size" } },
		{ '<CS-Left>', ':vert res +2<CR>', { silent = true, desc = "Increase window horizontal size" } },
		{ '<CS-Right>', ':vert res -2<CR>', { silent = true, desc = "Decrease window horizontal size" } },
		{ '<C-Left>', '<C-w>h', { silent = true, desc = "Go to left window" } },
		{ '<C-Right>', '<C-w>l', { silent = true, desc = "Go to right window" } },
		{ '<C-Up>', '<C-w>k', { silent = true, desc = "Go to top window" } },
		{ '<C-Down>', '<C-w>j', { silent = true, desc = "Go to bottom window" } },
		{ '<C-n>', ':vs<CR>', { desc = "Create a new window to the right of the current window" } },
		{ '<S-n>', ':sp<CR>', { desc = "Create a new window at the bottom of the current window" } },
		{ '<CS-F4>', ':bdelete<CR>', { silent = true, desc = "Close current buffer and its window if there are more than one" } },
		{ '<TAB>', ':bn<CR>', { silent = true, desc = "Go to the next buffer" } },
		{ '<S-TAB>', ':bp<CR>', { silent = true, desc = "Go to the previous buffer" } },
		{ '<S-b>', ':tabnew<CR>', { silent = true, desc = "Create a new buffer" } },
		{ '<esc>', stop_snippet, { expr = true, desc = "Escape and clear hlsearch" } },
	},
	['i'] = {
		{ 'C-z', '<u>', { desc = "Undo" } },
		{ 'C-y', '<C-r>', { desc = "Redo" } },
	},
	['t'] = {
		{ '<Esc>', '<C-\\><C-n>' }
	},
}
