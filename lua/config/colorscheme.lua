---@type ColorschemeTable
return {
	kanagawa = {
		lazyopts = {
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
	},
	gruvbox = {
		lazyopts = {
			--- Source ---
			'morhetz/gruvbox',

			--- Lazy loading ---
			lazy = true,
		},
		theme_overrides = {
			['Function'] = { link = 'GruvboxAqua' },
			['Constant'] = { link = 'GruvboxAqua' },
			['Number'] = { link = 'GruvboxPurple' },
			['Character'] = { link = 'String' },
			['Boolean'] = { link = 'GruvboxRed' },
			['StorageClass'] = { link = 'GruvboxRed' },
			['Structure'] = { link = 'GruvboxYellow' },
			['Typedef'] = { link = 'GruvboxYellow' },
			['Delimiter'] = { link = 'GruvboxOrange' },

			['@variable'] = { link = 'GruvboxBlue' },
			['@type.qualifier'] = { link = 'Keyword' },
			['@keyword.directive'] = { link = 'PreProc' },
			['@keyword.import'] = { link = 'PreProc' },
			['@constant.builtin'] = { link = 'Keyword' },
			['@namespace'] = { link = 'PreProc' },

			['@constructor.cpp'] = { link = 'Function' },
			['@type.builtin.cpp'] = { link = 'Keyword' },
			['@variable.builtin.cpp'] = { link = 'Keyword' },
			['@punctuation.delimiter.cpp'] = { link = 'Delimiter' },
			['@punctuation.bracket.cpp'] = { link = 'Delimiter' },
			['@module.cpp'] = { link = 'Function' },

			['@lsp.type.namespace'] = { link = 'PreProc' },
			['@lsp.type.operator.cpp'] = { link = 'Normal' },
		}
	},
	catppuccin = {
		lazyopts = {
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
	},
	onedark = {
		lazyopts = {
			--- Source ---
			'joshdick/onedark.vim',

			--- Lazy loading ---
			lazy = true,
		},
	},
	mellifluous = {
		lazyopts = {
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
	},
	miasma = {
		lazyopts = {
			--- Source ---
			'xero/miasma.nvim',

			--- Lazy loading ---
			lazy = true,
		},
	},
	tokyonight = {
		lazyopts = {
			--- Source ---
			'folke/tokyonight.nvim',

			--- Setup ---
			lazy = true,
		},
	},
}
