return {
	--- Source ---
	'rcarriga/nvim-notify',

	--- Setup ---
	opts = {
		background_colour = 'NotifyBackground',
		fps = 30,
		icons = {
			DEBUG = "",
    		ERROR = "",
			INFO = "",
			TRACE = "󰛿",
			WARN = "",
		},
		level = 2,
		minimum_width = 50,
		render = "default",
		stages = "slide",
		time_formats = {
			notification = "%T",
			notification_history = "%FT%T",
		},
	},
	config = function(_, opts)
		vim.notify = require('notify')
		vim.notify.setup(opts)
	end,
}
