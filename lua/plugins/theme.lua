return {
	{
		--- Source ---
		'rebelot/kanagawa.nvim',

		--- Loading ---
		priority = 1000,

		--- Setup ---
		opts = {
			compile = false,
			undercurl = false,
			commentStyle = { italic = false },
			functionStyle = {},
			keywordStyle = { italic = false },
			statementStyle = { bold = true, },
			typeStyle = {},
			transparent = false,
			dimInactive = false,
			terminalColors = true,
			colors = {
				palette = {},
				theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
			},
			overrides = function(_)
				return {}
			end,
			theme = "wave",
			background = {
				dark = "wave",
				light = "lotus",
			},
		},

		--- Lazy loading ---
		lazy = false,
	},
	{
		--- Source ---
		'morhetz/gruvbox',

		--- Lazy loading ---
		lazy = true,
	},
	{
		--- Source ---
		'joshdick/onedark.vim',

		--- Lazy loading ---
		lazy = true,
	},
}
