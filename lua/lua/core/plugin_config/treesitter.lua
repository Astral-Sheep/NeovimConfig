require('nvim-treesitter.configs').setup {
	-- A list of parser names, or "all"
	ensure_installed = {
		"arduino",
		"bash",
		"c",
		"c_sharp",
		"cpp",
		"css",
		"gdscript",
		"glsl",
		"hlsl",
		"json",
		"lua",
		"python",
		"rust",
		"typescript",
		"vim",
		"yaml",
	},

	-- Install parsers synchronously (only applied to 'ensure_installed')
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
	},
}
