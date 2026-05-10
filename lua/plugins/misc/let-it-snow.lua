return {
	--- Source ---
	'marcussimonsen/let-it-snow.nvim',

	--- Loading ---
	cond = function()
		-- Enable only during north hemisphere winter
		local month = tonumber(os.date('%m'))
		return month >= 11 or month <= 1
	end,

	--- Setup ---
	opts = {
		delay = 200, -- Delay between updates
	},
	config = function(_, opts)
		local lis = require('let-it-snow')
		lis.setup(opts)

		-- Make snow fall on buffer read
		vim.api.nvim_create_autocmd('BufReadPost', {
			callback = function()
				require('let-it-snow').let_it_snow()
			end,
		})

		lis.let_it_snow()
	end,

	--- Lazy loading ---
	event = 'BufEnter',
	keys = {
		{ '<leader>hs', function() require('let-it-snow').let_it_snow() end, desc = "Let It Snow" },
		{ '<leader>hS', function() require('let-it-snow').let_it_snow_stop() end, desc = "Let It Snow Stop" },
	},
}
