require('nvim-treesitter.configs').setup {
	-- A list of parser names, or "all"
	ensure_installed = {
		"arduino",
		"bash",
		"c",
		"c_sharp",
		"cmake",
		"cpp",
		"css",
		"gdscript",
		"gitattributes",
		"glsl",
		"hlsl",
		"html",
		"java",
		"javascript",
		"json",
		"lua",
		"markdown",
		"python",
		"rust",
		"typescript",
		"vim",
		"yaml",
	},

	-- Install parsers synchronously (only applied to 'ensure_installed')
	sync_install = false,
	-- Automatically install missing parsers when entering buffer
	-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
}

-- C++ specific highlighting
vim.api.nvim_set_hl(0, "@type.qualifier.cpp", { link = "Keyword" })
vim.api.nvim_set_hl(0, "@constant.builtin.cpp", { link = "Keyword" })
vim.api.nvim_set_hl(0, "@namespace.cpp", { link = "PreProc" })
vim.api.nvim_set_hl(0, "@lsp.type.namespace.cpp", { link = "PreProc" })
