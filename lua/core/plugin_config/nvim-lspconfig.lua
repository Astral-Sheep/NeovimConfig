local servers = {
	-- 'arduino_language_server',  -- Arduino
	-- 'asm_lsp',                  -- Assembly
	'bashls',                   -- Bash
	'clangd',                   -- C/C++
	'cmake',                    -- CMake
	'csharp_ls',                -- C#
	-- 'cssls',                    -- CSS
	-- 'gdscript',                 -- GDScript
	-- 'gdshader_lsp',             -- GDSL
	'glsl_analyzer',            -- GLSL
	-- 'haxe_language_server',     -- Haxe
	-- 'html',                     -- HTML
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

local on_attach = function(_, _)
	local map = vim.keymap
	local lsp = vim.lsp
	map.set('n', '<c-r><c-r>', lsp.buf.rename, {})
	map.set('n', '<leader>ca', lsp.buf.code_action, {})

	map.set('n', 'gd', lsp.buf.definition, {})
	map.set('n', 'gi', lsp.buf.implementation, {})
	map.set('n', 'gr', require('telescope.builtin').lsp_references, {})
	map.set('n', 'gh', lsp.buf.hover, {})
end

require('mason').setup()
require('mason-lspconfig').setup({
	ensure_installed = servers
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local configs = {
	lua_ls = {
		on_attach = on_attach,
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
	default = {
		on_attach = on_attach,
		capabilities = capabilities,
	}
}

local lsp_config = require('lspconfig')

for _, lsp in pairs(servers) do
	if (configs[lsp] ~= nil) then
		lsp_config[lsp].setup(configs[lsp])
	else
		lsp_config[lsp].setup(configs['default'])
	end
-- if (lsp == 'lua_ls') then
-- 	lsp_config[lsp].setup {
-- 		on_attach = on_attach,
-- 			capabilities = capabilities,
-- 			settings = {
-- 				Lua = {
-- 					diagnostics = {
-- 						globals = {
-- 							'vim',

-- 							-- Premake globals, remove them if you don't have premake
-- 							-- Functions
-- 							'workspace',
-- 							'configurations',
-- 							'project',
-- 							'kind',
-- 							'language',
-- 							'targetdir',
-- 							'targetname',
-- 							'objdir',
-- 							'files',
-- 							'removefiles',
-- 							'filter',
-- 							'defines',
-- 							'removedefines',
-- 							'symbols',
-- 							'optimize',
-- 							'filename',
-- 							'location',
-- 							'links',
-- 							'libdirs',
-- 							'flags',
-- 							'platforms',
-- 							'removeplatforms',
-- 							'configmap',
-- 							'includedirs',
-- 							'pchheader',
-- 							'pchsource',
-- 							'buildoptions',
-- 							'linkoptions',
-- 							'newoption',
-- 							'newaction',
-- 							'iif',
-- 							'include',
-- 							'includeexternal',
-- 							'printf',
-- 							'verbosef',
-- 							'system',
-- 							'architecture',
-- 							-- Variables
-- 							'_ACTION',
-- 							'_ARGS',
-- 							'_MAIN_SCRIPT_DIR',
-- 							'_MAIN_SCRIPT',
-- 							'_OPTIONS',
-- 							'_OS',
-- 							'_PREMAKE_COMMAND',
-- 							'_PREMAKE_DIR',
-- 							'_PREMAKE_VERSION',
-- 							'_WORKING_DIR',
-- 						}
-- 					}
-- 				}
-- 			}
-- 		}
-- 	else
-- 		lsp_config[lsp].setup {
-- 			on_attach = on_attach,
-- 			capabilities = capabilities,
-- 		}
-- 	end
end
