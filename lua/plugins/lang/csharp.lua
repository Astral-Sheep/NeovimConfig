return {
	{
		--- Source ---
		'Hoffs/omnisharp-extended-lsp.nvim',

		--- Lazy loading ---
		lazy = true
	},

	{
		--- Source ---
		'nvim-treesitter/nvim-treesitter',

		--- Setup ---
		opts = { ensure_installed = { 'c_sharp' } },
	},

	{
		--- Source ---
		'mason-org/mason.nvim',

		--- Setup ---
		opts = { ensure_installed = { 'netcoredbg' } }
	},

	{
		'neovim/nvim-lspconfig',
		opts = {
			servers = {
				omnisharp = {
					handlers = {
						['textDocument/definition'] = function(...)
							return require('omnisharp_extended').handler(...)
						end,
					},
					keys = {
						{
							'gd',
							Config.has('telescope.nvim') and function()
								require('omnisharp_extended').telescope_lsp_definitions()
							end or function()
									require('omnisharp_extended').lsp_definitions()
							end,
							desc = "Goto Definition",
						},
					},
					enable_roslyn_analyzers = true,
					organize_imports_on_format = true,
					enable_import_completion = true,
				},
			},
		},
	},

	{
		'mfussenegger/nvim-dap',
		opts = function()
			local dap = require('dap')

			if not dap.adapters['netcoredbg'] then
				require('dap').adapters['netcoredbg'] = {
					type = 'executable',
					command = vim.fn.exepath('netcoredbg'),
					args = { '--interpreter=vscode' },
					options = {
						detached = false,
					},
				}
			end

			for _, lang in ipairs({ 'cs' }) do
				if not dap.configurations[lang] then
					dap.configurations[lang] = {
						{
							type = 'netcoredbg',
							name = "Launch file",
							request = 'launch',
							---@diagnostic disable-next-line: redundant-parameter
							program = function()
								return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/", 'file')
							end,
							cwd = "${workspaceFolder}",
						},
					}
				end
			end
		end,
	},
}
