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

local api = vim.api

-- Set custom highlighting when gruvbox is set
local function refresh_treesitter()
	if (vim.g.colors_name == 'gruvbox')
	then
		api.nvim_set_hl(0, 'Function',				{ link = 'GruvboxAquaBold' })
		api.nvim_set_hl(0, 'Constant', 				{ link = 'GruvboxAqua' })
		api.nvim_set_hl(0, 'Number',				{ link = 'GruvboxPurple' })
		api.nvim_set_hl(0, 'Character', 			{ link = 'String' })
		api.nvim_set_hl(0, 'Boolean',				{ link = 'GruvboxRed' })
		api.nvim_set_hl(0, 'StorageClass',			{ link = 'GruvboxRed' })
		api.nvim_set_hl(0, 'Structure',				{ link = 'GruvboxYellow' })
		api.nvim_set_hl(0, 'Typedef',				{ link = 'GruvboxYellow' })

		api.nvim_set_hl(0, '@type.qualifier',		{ link = 'Keyword' })
		api.nvim_set_hl(0, '@keyword.directive',	{ link = 'PreProc' })
		api.nvim_set_hl(0, '@keyword.import',		{ link = 'PreProc' })
		api.nvim_set_hl(0, '@constant.builtin',		{ link = 'Keyword' })
		api.nvim_set_hl(0, '@namespace',			{ link = 'PreProc' })
		api.nvim_set_hl(0, '@lsp.type.namespace',	{ link = 'PreProc' })
	end
end

api.nvim_create_autocmd('ColorScheme', {
	nested = true,
	callback = refresh_treesitter
})

refresh_treesitter()

