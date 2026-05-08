local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.uv.fs_stat(lazypath) then
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

require('lazy').setup({
	spec = {
		-- Add LazyVim and import its plugins
		-- { "LazyVim/LazyVim", import = "lazyvim.plugins" },
		-- import/override with your plugins
		{ import = 'plugins' },
	},
	defaults = {
		-- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
		-- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
		lazy = false,
		-- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
		-- have outdated releases, which may break your Neovim install.
		version = false, -- always use the latest git commit
		-- version = "*", -- try installing the latest stable version for plugins that support semver
	},
	install = {
		-- Install missing plugins on startup. This doesn't increase startup time
		missing = true,
		-- Try to load one of these colorschemes when starting an installation during startup
		colorscheme = { 'tokyonight' }
	},
	checker = {
		enabled = true, -- Check for plugin updates periodically
		notify = false, -- Notify on update
		frequency = 604800 -- Check for updates every week
	}, -- Automatically check for plugin updates
	change_detection = {
		enabled = true, -- Automatically check for config file changes and reload the ui
		notify = true, -- Get a notification when changes are found
	},
	performance = {
		rtp = {
			-- disable some rtp plugins
			disabled_plugins = {
				'gzip',
				-- "matchit",
				-- "matchparen",
				-- "netrwPlugin",
				'tarPlugin',
				'tohtml',
				'tutor',
				'zipPlugin',
			},
		},
	},
	profiling = {
		loader = true, -- Enable extra stats on the debug tab related to the loader cache. Additionally gathers stats about all package.loader
		require = true, -- Track each new require in the Lazy profiling tab
	},
})
