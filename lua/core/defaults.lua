---@class ColorschemeOptions
---@field per_filetype boolean
---@field file_schemes table<string, string>

---@class ConfigDefaults
---@field colorschemes ColorschemeOptions
---@field defaults table<string, boolean>
---@field news NewsOptions
---@field icons table<string, table<string, string|string[]>>
---@field kind_filter table
return {
	colorschemes = {
		per_filetype = false,
		file_schemes = {
			default = 'kanagawa',
			c = 'gruvbox',
			cpp = 'gruvbox',
			tpp = 'gruvbox',
			cmake = 'gruvbox',
			lua = 'kanagawa',
			rust = 'catppuccin',
		}
	},
	defaults = {
		autocmds = true, -- config.autocmds
		keymaps = true, -- config.keymaps
		options = true, -- config.options
	},
	news = {
		-- When enabled, NEWS.md will be shown when changed.
		-- This only contains big new features and breaking changes.
		lazyvim = true,
		-- Same but for Neovim's news.txt
		neovim = true,
	},
	icons = {
		comments = {
			todo = " ",
			fix = " ",
			hack = " ",
			warn = " ",
			perf = " ",
			note = "󰍩 ",
			test = "󱤥 ",
		},
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
		dap = {
			stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
			breakpoint = " ",
			breakpoint_condition = " ",
			breakpoint_rejected = { " ", "DiagnosticError" },
			log_point = ".>",
		},
		diagnostics = {
			error = " ",
			warn = " ",
			hint = " ",
			info = " ",
		},
		misc = {
			indent_blankline = "▏",
			dots = "󰇘",
		},
		notifications = {
			debug = " ",
			error = " ",
			info = " ",
			trace = " ",
			warn = " ",
		},
		git = {
			added    = " ",
			modified = " ",
			removed  = " ",
		},
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
	},
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
