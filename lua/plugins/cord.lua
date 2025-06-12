return {
	--- Source ---
	'vyfor/cord.nvim',

	--- Setup ---
	opts = function()
		return {
			-- editor = {
			-- 	client = 'neovim',
			-- 	tooltip = "The Superior Text Editor",
			-- 	icon = nil,
			-- },
			display = {
				theme = 'default', -- Values: default, atom or catppuccin
				flavor = 'dark', -- Values: dark, light or accent
				swap_fields = false,
				swap_icons = false,
			},
			timestamp = {
				enabled = true,
				reset_on_idle = false,
				reset_on_change = false,
			},
			idle = {
				enabled = false,
				-- timeout = 300000, -- Time in ms -> =5min
				-- show_status = true,
				-- ignore_focus = true,
				-- unidle_on_focus = true,
				-- smart_idle = true,
				-- details = "Idling",
				-- state = nil,
				-- tooltip = "💤",
				-- icon = "<custom-icon-url>",
			},
			text = {
				-- default = nil,
				-- workspace = "In {workspace}",
				-- viewing = "Viewing {filename}",
				-- editing = "Editing {filename}",
				-- file_browser = false,
				-- plugin_manager = false,
				-- lsp = "Configuring LSP in {name}",
				-- docs = "Reading {name}",
				-- vcs = "Committing changes in {name}",
				-- notes = "Taking notes in {name}",
				-- debug = "Debugging in {name}",
				-- test = "Testing in {name}",
				-- diagnostics = "Fixing problmes in {name}",
				-- games = "Playing {name}",
				-- terminal = "Running commands in {name}",
				-- dashboard = "Home",
			},
			variables = true,
			advanced = {
				workspace = {
					rootmarkers = { '.git', '*.sln', 'MakeFile', '*.godot', '*.uproject' },
					limit_to_cwd = false,
				},
			},
		}
	end,
	build = ':Cord update',

	--- Lazy loading ---
	lazy = false,
}
