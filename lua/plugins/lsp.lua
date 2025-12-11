local servers = {
	-- 'arduino_language_server',  -- Arduino
	-- 'asm_lsp',                  -- Assembly
	'bashls',                   -- Bash
	'clangd',                   -- C/C++
	'cmake',                    -- CMake
	'csharp_ls',                -- C#
	'cssls',                    -- CSS
	-- 'gdscript',                 -- GDScript
	-- 'gdshader_lsp',             -- GDSL
	'glsl_analyzer',            -- GLSL
	-- 'haxe_language_server',     -- Haxe
	'html',                     -- HTML
	-- 'java_language_server',     -- Java
	'jsonls',                   -- JSON
	-- 'kotlin_language_server',   -- Kotlin
	'lua_ls',                   -- Lua
	'powershell_es',            -- Powershell
	'pylsp',                    -- Python
	'rust_analyzer',            -- Rust
	'ts_ls',                    -- JavaScript/TypeScript
	'vimls',                    -- VimScript
	'yamlls',                   -- YAML
}

return {
	{
		--- Source ---
		'williamboman/mason.nvim',

		--- Setup ---
		opts = {},

		--- Lazy Loading ---
		lazy = true,
	},
	{
		--- Source ---
		'williamboman/mason-lspconfig.nvim',

		--- Setup ---
		opts = {
			ensure_installed = servers,
			automatic_enable = true,
		},

		--- Lazy Loading ---
		lazy = true,
	},
	{
		--- Source ---
		'neovim/nvim-lspconfig',

		--- Loading ---
		dependencies = {
			'williamboman/mason.nvim',
			'williamboman/mason-lspconfig.nvim',
			'nvim-cmp',
		},

		--- Setup ---
		config = function(_, opts)
			local capabilities = require('cmp_nvim_lsp').default_capabilities()

			vim.api.nvim_create_autocmd('LspAttach', {
				callback = function(_, _)
					local map = vim.keymap
					local lsp = vim.lsp

					map.set('n', '<C-r><C-r>', lsp.buf.rename, {
						silent = true,
						desc = "Rename symbol under cursor",
					})
					map.set('n', '<leader>ca', lsp.buf.code_action, {
						silent = true,
						desc = "Display code actions",
					})

					map.set('n', 'gd', lsp.buf.type_definition, {
						silent = true,
						desc = "Go to symbol definition",
					})
					map.set('n', 'gi', lsp.buf.implementation, {
						silent = true,
						desc = "Go to symbol implementation",
					})
					map.set('n', 'gr', require('fzf-lua').lsp_references, {
						silent = true,
						desc = "Display symbols references in folder",
					})
					map.set('n', 'gh', lsp.buf.signature_help, {
						silent = true,
						desc = "Display symbol info",
					})
				end
			})

			local configs = {
				default = {
					capabilities = capabilities,
				},
				lua_ls = {
					capabilities = capabilities,
					settings = {
						Lua = {
							diagnostics = {
								globals = {
									'vim',

									-- Premake globals, remove them if you don't have premake
									-- Functions
									'workspace',
									'configurations',
									'project',
									'kind',
									'language',
									'targetdir',
									'targetname',
									'objdir',
									'files',
									'removefiles',
									'filter',
									'defines',
									'removedefines',
									'symbols',
									'optimize',
									'filename',
									'location',
									'links',
									'libdirs',
									'flags',
									'platforms',
									'removeplatforms',
									'configmap',
									'includedirs',
									'pchheader',
									'pchsource',
									'buildoptions',
									'linkoptions',
									'newoption',
									'newaction',
									'iif',
									'include',
									'includeexternal',
									'printf',
									'verbosef',
									'system',
									'architecture',
									-- Variables
									'_ACTION',
									'_ARGS',
									'_MAIN_SCRIPT_DIR',
									'_MAIN_SCRIPT',
									'_OPTIONS',
									'_OS',
									'_PREMAKE_COMMAND',
									'_PREMAKE_DIR',
									'_PREMAKE_VERSION',
									'_WORKING_DIR',
								}
							}
						}
					}
				},
			}

			vim.lsp.config('*', configs['default'])

			for _, lsp in pairs(servers) do
				if configs[lsp] ~= nil then
					vim.lsp.config[lsp] = configs[lsp]
					vim.lsp.enable(lsp)
				end
			end

			vim.highlight.priorities.semantic_tokens = 95
		end,

		--- Lazy loading ---
		lazy = true,
		ft = { 'dosbatch', 'c', 'cpp', 'tpp', 'cs', 'css', 'cmake', 'glsl', 'html', 'javascript', 'json', 'lua', 'ps1', 'python', 'rust', 'typescript', 'vim', 'yaml' }
	},
}
