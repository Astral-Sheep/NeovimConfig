local ruff = "ruff"

return {
	{
		--- Source ---
		'nvim-treesitter/nvim-treesitter',

		--- Setup ---
		opts = { ensure_installed = { 'ninja', 'python', 'rst' } },
	},
	{
		--- Source ---
		'neovim/nvim-lspconfig',

		--- Setup ---
		opts = {
			servers = {
				ruff = {
					cmd_env = { RUFF_TRACE = 'messages' },
					init_options = {
						settings = {
							logLevel = 'error',
						},
					},
				},
				ruff_lsp = {},
			},
			setup = {
				[ruff] = function()
					Snacks.util.lsp.on({ name = ruff }, function(_, client)
						-- Disable hover in favor of Pyright
						client.server_capabilities.hoverProvider = false
					end)
				end,
			},
		},
	},
	{
		--- Source ---
		'mfussenegger/nvim-dap',

		--- Loading ---
		dependencies = {
			--- Source ---
			'mfussenegger/nvim-dap-python',

			--- Setup ---
			config = function()
				require('dap-python').setup('debugpy-adapter')
			end,

			--- Lazy loading ---
			keys = {
				{ '<leader>dPt', function() require('dap-python').test_method() end, desc = "Debug Method", ft = 'python' },
				{ '<leader>dPc', function() require('dap-python').test_class() end, desc = "Debug Class", ft = 'python' },
			},
		},
	},
	{
		--- Source ---
		'linux-cultist/venv-selector.nvim',

		--- Setup ---
		opts = {
			options = {
				notify_user_on_venv_activation = true,
				override_notify = false,
			},
		},

		--- Lazy loading ---
		cmd = 'VenvSelect',
		ft = 'python',
		keys = {
			{ '<leader>cv', '<cmd>:VenvSelect<cr>', desc = "Select VirtualEnv", ft = 'python' },
		},
	},
	{
		--- Source ---
		'hrsh7th/nvim-cmp',

		--- Setup ---
		opts = function(_, opts)
			opts.auto_brackets = opts.auto_brackets or {}
			table.insert(opts.auto_brackets, 'python')
		end,
	},
	{
		--- Source ---
		'jay-babu/mason-nvim-dap.nvim',

		--- Setup ---
		opts = {
			handlers = {
				python = function() end,
			},
		},
	},
}
