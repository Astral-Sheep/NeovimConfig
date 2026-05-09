return {
	{
		--- Source ---
		'nvim-treesitter/nvim-treesitter',

		--- Setup ---
		opts = { ensure_installed = { 'json5' } },
	},

	-- Yaml schema support
	{
		--- Source ---
		'b0o/SchemaStore.nvim',

		--- Lazy loading ---
		lazy = true,

		--- Versioning ---
		version = false, -- last release is way too old
	},

	{
		--- Source ---
		'neovim/nvim-lspconfig',

		--- Setup ---
		opts = {
			servers = {
				jsonls = {
					before_init = function(_, new_config)
						new_config.settings.json.schemas = new_config.settings.json.schemas or {}
						vim.list_extend(new_config.settings.json.schemas, require('schemastore').json.schemas())
					end,
					settings = {
						json = {
							format = {
								enable = true,
							},
							validate = { enable = true },
						},
					},
				},
			},
		},
	},
}
