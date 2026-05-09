return {
	recommended = {
		ft = { 'gitcommit', 'gitconfig', 'gitrebase', 'gitignore', 'gitattributes' },
	},

	--- Git diffs in sign column
	{
		--- Source ---
		'mhinz/vim-signify',

		--- Lazy loading ---
		event = 'BufRead',
	},

	-- Treesitter git support
	{
		--- Source ---
		'nvim-treesitter/nvim-treesitter',

		--- Setup ---
		opts = { ensure_installed = { 'git_config', 'gitcommit', 'git_rebase', 'gitignore', 'gitattributes' } }
	},

	-- Git autocompletion
	{
		--- Source ---
		'hrsh7th/nvim-cmp',

		--- Loading ---
		dependencies = {
			{ 'petertriho/cmp-git', opts = {} },
		},

		--- Setup ---
		opts = function(_, opts)
			table.insert(opts.sources, { name = 'git' })
		end,
	},

	-- Ensure GitUI tool is installed
	{
		--- Source ---
		'mason-org/mason.nvim',

		--- Setup ---
		opts = { ensure_installed = { 'gitui' } },

		--- Lazy loading ---
		init = function()
			-- Delete lazygit keymap for file history
			vim.api.nvim_create_autocmd('User', {
				pattern = 'LazyVimKeymaps',
				once = true,
				callback = function()
					pcall(vim.keymap.del, 'n', '<leader>gf')
					pcall(vim.keymap.del, 'n', '<leader>gl')
				end,
			})
		end,
		keys = {
			{
				'<leader>gG',
				function()
					Snacks.terminal({ 'gitui' })
				end,
				desc = "Git UI (cwd)",
			},
			{
				'<leader>gg',
				function()
					Snacks.terminal({ 'gitui' }, { cwd = Config.root.get() })
				end,
				desc = "Git UI (Root Dir)",
			},
		},
	},
}
