return {
	--- Source ---
	'vyfor/cord.nvim',

	--- Setup ---
	opts = {
		-- editor = {
		-- 	client = 'neovim',
		-- 	tooltip = "The Superior Text Editor",
		-- 	icon = nil,
		-- },
		display = {
			---@type 'default' | 'atom' | 'catppuccin' | 'minecraft' | 'void' | 'classic'
			theme = 'default',
			---@type 'dark' | 'light' | 'accent'
			flavor = 'dark',
			---@type 'full' | 'editor' | 'asset' | 'auto'
			view = 'full', -- Control what shows up as the large and small images
			swap_fields = false, -- Show workspace name before filename
			swap_icons = false, -- Use editor icon as large image
		},
		timestamp = {
			enabled = true, -- Show elapsed time in presence
			reset_on_idle = false, -- Reset timestamp when entering idle state
			reset_on_change = false, -- Reset timestamp when presence changes
			shared = false, -- Synchronize timestamps between clients
		},
		idle = {
			enabled = false, -- Enable idle status detection
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
		-- text = {
		-- 	workspace = "In {workspace}",
		-- 	viewing = "Viewing {filename}",
		-- 	editing = "Editing {filename}",
		-- 	file_browser = "Browsing files in {name}",
		-- 	plugin_manager = "Managin plugins in {name}",
		-- 	lsp = "Configuring LSP in {name}",
		-- 	docs = "Reading {name}",
		-- 	vcs = "Committing changes in {name}",
		-- 	notes = "Taking notes in {name}",
		-- 	debug = "Debugging in {name}",
		-- 	test = "Testing in {name}",
		-- 	diagnostics = "Fixing problems in {name}",
		-- 	games = "Playing {name}",
		-- 	terminal = "Running commands in {name}",
		-- 	dashboard = "Home",
		-- },
		buttons = {
			{
				label = function(opts)
					return opts.repo_url and "View Repository" or "Website"
				end,
				url = function(opts)
					return opts.repo_url or "https://example.com"
				end,
			},
		},
		-- assets = {
		-- 	['.rs'] = {
		-- 		icon = "rust", -- Asset name or URL
		-- 		tooltip = "Rust", -- Hover text
		-- 		text = "Writing in Rust", -- Override entire text
		-- 	},
		-- 	netrw = {
		-- 		name = "Netrw", -- Override asset name only
		-- 		type = "file_browser", -- Set asset type
		-- 	},
		-- },
		-- Define custom variables for use in string templates. Functions can be
		-- used to dynamically generate values. If `true`, uses the default options
		-- table, if `table`, extends the default table, if `false`, disables
		-- custom variables
		-- ---@type table | boolean | nil
		-- variables = true,
	},
	build = ':Cord update',

	--- Lazy loading ---
	event = 'VeryLazy',
}
