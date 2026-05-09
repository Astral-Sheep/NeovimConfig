return {
	-- Add C/C++ to treesitter
	{
		--- Source ---
		'nvim-treesitter/nvim-treesitter',

		--- Setup ---
		opts = { ensure_installed = { 'c', 'cpp' } },
	},

	{
		--- Source ---
		'p00f/clangd_extensions.nvim',

		--- Setup ---
		opts = {
			inlay_hints = {
				inline = false,
			},
			ast = {
				role_icons = {
					type = "",
					declaration = "",
					expression = "",
					specifier = "",
					statement = "",
					["template argument"] = "",
				},
				kind_icons = {
					Compound = "",
					Recovery = "",
					TranslationUnit = "",
					PackExpansion = "",
					TemplateTypeParm = "",
					TemplateTemplateParm = "",
					TemplateParamObject = "",
				},
			},
		},

		--- Lazy loading ---
		ft = { 'c', 'cpp', 'objc', 'objcpp' },
	},

	{
		'neovim/nvim-lspconfig',
		opts = {
			servers = {
				clangd = {
					keys = {
						{ '<leader>ch', '<cmd>LspClangdSwitchSourceHeader<cr>', desc = "Switch Source/Header (C/C++)" },
					},
					root_markers = {
						"compile_commands.json",
						"compile_flags.txt",
						"configure.ac", -- AutoTools
						"Makefile",
						"configure.in",
						"config.h.in",
						"meson.build",
						"meson_options.txt",
						"build.ninja",
						".git",
					},
					capabilities = {
						offsetEncoding = { 'utf-16' },
					},
					cmd = {
						'clangd',
						'--background-index',
						'--clang-tidy',
						'--header-insertion=iwyu',
						'--completion-style=detailed',
						'--function-arg-placeholders',
						'--fallback-style=llvm',
					},
					init_options = {
						usePlaceholders = true,
						completeUnimported = true,
						clangdFileStatus = true,
					},
				},
			},
		},
	},

	{
		--- Source ---
		'hrsh7th/nvim-cmp',

		--- Setup ---
		opts = function(_, opts)
			opts.sorting = opts.sorting or {}
			opts.sorting.comparators = opts.sorting.comparators or {}
			table.insert(opts.sorting.comparators, 1, require('clangd_extensions.cmp_scores'))
		end,
	},

	{
		'mfussenegger/nvim-dap',

		--- Loading ---
		dependencies = {
			-- Ensure C/C++ debugger is installed
			'mason-org/mason.nvim',
			optional = true,
			opts = { ensure_installed = { 'codelldb' } },
		},

		--- Setup ---
		opts = function()
			local dap = require('dap')

			if not dap.adapters['codelldb'] then
				require('dap').adapters['codelldb'] = {
					type = 'server',
					host = 'localhost',
					port = '${port}',
					executable = {
						command = 'codelldb',
						args = {
							'--port',
							'${port}',
						},
					},
				}
			end

			for _, lang in ipairs({ 'c', 'cpp' }) do
				dap.configurations[lang] = {
					{
						type = 'codelldb',
						request = 'launch',
						name = "Launch file",
						program = function()
							return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", 'file')
						end,
						cwd = '${workspaceFolder}',
					},
					{
						type = 'codelldb',
						request = 'attach',
						name = "Attach to process",
						pid = require('dap.utils').pick_process,
						cwd = '${workspaceFolder}',
					},
				}
			end
		end,
	}
}
