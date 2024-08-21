local servers = {
	'arduino_language_server',	-- Arduino
	'asm_lsp',					-- Assembly
	'bashls',					-- Bash
	'clangd',					-- C/C++
	'cmake',					-- CMake
	'csharp_ls',				-- C#
	'cssls',					-- CSS
	-- 'gdscript',				-- GDScript
	'glsl_analyzer',			-- GLSL
	'haxe_language_server',		-- Haxe
	'html',						-- HTML
	-- 'java_language_server',	-- Java
	'jsonls',					-- JSON
	'lua_ls',					-- Lua
	'powershell_es',			-- Powershell
	'pylsp',					-- Python
	'rust_analyzer',			-- Rust
	'tsserver',					-- JavaScript/TypeScript
	'vimls',					-- VimScript
	'yamlls',					-- YAML
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
local lsp_config = require('lspconfig')

for _, lsp in pairs(servers) do
	lsp_config[lsp].setup {
		on_attach = on_attach,
		capabilities = capabilities,
	}
end
