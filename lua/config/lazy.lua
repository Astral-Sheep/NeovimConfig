-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
	local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })

	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end

vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)

-- Setup lazy.nvim
require('lazy').setup({
	spec = {
		-- Import your plugins
		{ import = "plugins" },
	},
	install = {
		-- Install missing plugins on startup. This doesn't increase startup time
		missing = true,
		-- Try to load one of these colorschenes when starting an installation during startup
		colorscheme = { 'kanagawa' }
	},
	ui = {
		border = 'rounded', -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|. ('none', 'single', 'double', 'rounded', 'solid', 'shadow')
		title = 'Lazy Status', ---@type string only works when border is not 'none'
		title_pos = 'center', ---@type 'center' | 'left' | 'right'
		icons = {
			cmd = " ",
			config = "",
			event = " ",
			favorite = " ",
			ft = " ",
			init = " ",
			import = " ",
			keys = " ",
			lazy = "󰒲 ",
			loaded = "●",
			not_loaded = "○",
			plugin = " ",
			runtime = " ",
			require = "󰢱 ",
			source = " ",
			start = " ",
			task = "✔ ",
			list = {
				"●",
				"➜",
				"★",
				"‒",
			},
		},
	},
	checker = {
		enabled = false, -- Automatically check for plugin updates
		notify = false, -- Get a notification when new updates are found
		frequency = 604800 -- Check for updates every week
	},
	change_detection = {
		enabled = true, -- Automatically check for config file changes and reload the ui
		notify = true, -- Get a notification when changes are found
	},
	profiling = {
		loader = false, -- Enables extra stats on the debug tab related to the loader cache. Additionally gathers stats about all package.loaders
		require = false, -- Track each new require in the Lazy profiling tab
	},
})
