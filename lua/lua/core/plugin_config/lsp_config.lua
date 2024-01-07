local servers = {
	'arduino_language_server',	-- Arduino
	'asm_lsp',					-- Assembly
	'bashls',					-- Bash
	'clangd',					-- C/C++
	'cmake',					-- CMake
	'csharp_ls',				-- C#
	'cssls',					-- CSS
	-- 'gdscript',					-- GDScript
	-- 'glslls',					-- GLSL
	'haxe_language_server',		-- Haxe
	'html',						-- HTML
	-- 'java_language_server',		-- Java
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
	vim.keymap.set('n', '<c-r><c-r>', vim.lsp.buf.rename, {})
	vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})

	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
	vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, {})
	vim.keymap.set('n', 'gh', vim.lsp.buf.hover, {})
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
