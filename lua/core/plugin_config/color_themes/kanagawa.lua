require('kanagawa').setup({
	compile = false,
	undercurl = true,
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
})

