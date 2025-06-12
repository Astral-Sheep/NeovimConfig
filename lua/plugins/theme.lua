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
		lazy = true,
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
	{
		--- Source ---
		'shaunsingh/nord.nvim',

		--- Lazy loading ---
		lazy = true,
	},
	{
		--- Source ---
		'catppuccin/nvim',
		name = "catppuccin",

		--- Setup ---
		opts = {
			flavour = 'macchiato',
			background = {
				light = 'latte',
				dark = 'macchiato',
			},
		},

		--- Lazy loading ---
		lazy = true,
	},
	{
		--- Source ---
		'ramojus/mellifluous.nvim',

		--- Setup ---
		opts = {
			transparent_background = {
				enabled = false,
			}
		},

		--- Lazy loading ---
		lazy = true,
	},
	{
		--- Source ---
		'xero/miasma.nvim',

		--- Lazy loading ---
		lazy = true,
	},
	{
		--- Source ---
		'diegoulloao/neofusion.nvim',

		--- Setup ---
		opts = {
			terminal_colors = true,
			undercurl = true,
			underline = true,
			bold = true,
			italic = {
				strings = true,
				emphasis = true,
				comments = true,
				operators = false,
				folds = true,
			},
			strikethrough = true,
			invert_selection = false,
			invert_signs = false,
			invert_tabline = false,
			invert_intend_guides = false,
			inverse = true,
			palette_overrides = {},
			overrides = {},
			dim_inactive = false,
			transparent_mode = false,
		},

		--- Lazy loading ---
		lazy = true,
	},
}
