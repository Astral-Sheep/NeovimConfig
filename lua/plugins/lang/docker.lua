return {
	{
		--- Source ---
		'nvim-treesitter/nvim-treesitter',

		--- Setup ---
		opts = { ensure_installed = { 'dockerfile' } },
	},

	{
		--- Source ---
		'mason.nvim',

		--- Setup ---
		opts = { ensure_installed = { 'hadolint' } },
	},

	{
		--- Source ---
		'neovim/nvim-lspconfig',

		--- Setup ---
		opts = {
			servers = {
				dockerls = {},
				docker_compose_language_service = {},
			},
		},
	},
}
