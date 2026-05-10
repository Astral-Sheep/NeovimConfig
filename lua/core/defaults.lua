---@class ColorschemeOptions
---@field file_schemes table<string, string>

---@class ConfigDefaults
---@field colorschemes ColorschemeOptions
---@field defaults table<string, boolean>
---@field news NewsOptions
---@field icons table<string, table>
---@field kind_filter table
return {
	colorschemes = {
		---@type table<string, string>
		file_schemes = {
			default = 'tokyonight',
			c = 'gruvbox',
			cpp = 'gruvbox',
			tpp = 'gruvbox',
			cmake = 'gruvbox',
			lua = 'tokyonight',
			rust = 'catppuccin',
		},
	},
	---@type table<string, boolean>
	defaults = {
		autocmds = true, -- config.autocmds
		keymaps = true, -- config.keymaps
		options = true, -- config.options
	},
	---@type table<string, boolean>
	news = {
		-- When enabled, Neovim's news.txt will be shown when changed.
		-- This only contains big new features and breaking changes.
		neovim = true,
	},
	icons = {
		---@table<string, string>
		comments = {
			todo = " ",
			fix = " ",
			hack = " ",
			warn = " ",
			perf = " ",
			note = "󰍩 ",
			test = "󱤥 ",
		},
		---@table<string, string>
		dashboard = {
			configuration = " ",
			file_explorer = " ",
			find_file = " ",
			find_text = " ",
			lazy = "󰒲 ",
			new_file = " ",
			quit = " ",
			recent_files = " ",
			restore_session = " ",
		},
		---@table<string, string|string[]>
		dap = {
			stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
			breakpoint = " ",
			breakpoint_condition = " ",
			breakpoint_rejected = { " ", "DiagnosticError" },
			log_point = ".>",
		},
		---@table<string, string>
		diagnostics = {
			error = " ",
			warn = " ",
			hint = " ",
			info = " ",
		},
		---@table<string, string>
		ft = {
			octo = " ",
			gh = " ",
			['markdown.gh'] = " ",
		},
		---@table<string, string>
		git = {
			added    = " ",
			modified = " ",
			removed  = " ",
		},
		---@table<string, string>
		kinds = {
			Array         = " ",
			Boolean       = "󰨙 ",
			Class         = " ",
			Codeium       = "󰘦 ",
			Color         = " ",
			Control       = " ",
			Collapsed     = " ",
			Constant      = "󰏿 ",
			Constructor   = " ",
			Copilot       = " ",
			Enum          = " ",
			EnumMember    = " ",
			Event         = " ",
			Field         = " ",
			File          = " ",
			Folder        = " ",
			Function      = "󰊕 ",
			Interface     = " ",
			Key           = " ",
			Keyword       = " ",
			Method        = "󰊕 ",
			Module        = " ",
			Namespace     = "󰦮 ",
			Null          = " ",
			Number        = "󰎠 ",
			Object        = " ",
			Operator      = " ",
			Package       = " ",
			Property      = " ",
			Reference     = " ",
			Snippet       = "󱄽 ",
			String        = " ",
			Struct        = "󰆼 ",
			Supermaven    = " ",
			TabNine       = "󰏚 ",
			Text          = " ",
			TypeParameter = " ",
			Unit          = " ",
			Value         = " ",
			Variable      = "󰀫 ",
		},
		---@table<string, string>
		misc = {
			indent_blankline = "▏",
			dots = "󰇘",
		},
		---@table<string, string>
		notifications = {
			debug = " ",
			error = " ",
			info = " ",
			trace = " ",
			warn = " ",
		},
	},
	---@type table<string, string[]|boolean>
	kind_filter = {
		default = {
			"Class",
			"Constructor",
			"Enum",
			"Field",
			"Function",
			"Interface",
			"Method",
			"Module",
			"Namespace",
			"Package",
			"Property",
			"Struct",
			"Trait",
		},
		markdown = false,
		help = false,
		-- you can specify a different filter for each filetype
		lua = {
			"Class",
			"Constructor",
			"Enum",
			"Field",
			"Function",
			"Interface",
			"Method",
			"Module",
			"Namespace",
			-- "Package", -- remove package since luals uses it for control flow structures
			"Property",
			"Struct",
			"Trait",
		},
	},
}
