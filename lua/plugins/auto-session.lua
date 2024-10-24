return {
	--- Source code ---
	'rmagatti/auto-session',

	--- Setup ---
	opts = {
		auto_restore = false,
		auto_restore_last_session = false,
	},
	config = function(_, opts)
		require('auto-session').setup(opts)
		vim.o.sessionoptions='buffers,curdir,folds,help,localoptions,tabpages,terminal,winpos,winsize'
	end,

	--- Lazy loading ---
	lazy = false,
}
