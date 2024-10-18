return {
	--- Source ---
	'LunarVim/bigfile.nvim',

	--- Setup ---
	opts = {
		filesize = 2, -- size of the file in MiB, the plugin round file sizes to the closes MiB
		pattern = { "*" }, -- autocmd pattern or function see <### Overriding the detection of big files>
		features = {
			'lsp', -- detaches the lsp client from buffer
			'treesitter', -- disables treesitter for the buffer
			'indent_blankline', -- disables 'lukas-reineke/indent-blankline.nvim' for the buffer
			'syntax', -- ':syntax off' for the buffer
			'filetype', -- 'filetype = ""' for the buffer
			'vimopts', -- 'swapfile = false' 'foldmethod = "manual"' 'undolevels = -1' 'undoreload = 0' 'list = false' for the buffer
			'matchparen', -- ':NoMatchParen' globally, currently this feature will stay disabled, even after you close the big file
		},
	},
}
