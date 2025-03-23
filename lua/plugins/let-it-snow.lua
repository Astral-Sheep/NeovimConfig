return {
	--- Source ---
	'marcussimonsen/let-it-snow.nvim',

	--- Loading ---
	cond = function()
		-- Enable only in december
		return os.date('%m') == '12' or os.date('%m') == '1'
	end,

	--- Setup ---
	opts = {
		delay = 200, -- Delay between updates
	},
	config = function(_, opts)
		require('let-it-snow').setup(opts)

		vim.api.nvim_create_autocmd('BufReadPost', {
			callback = function()
				vim.cmd('LetItSnow')
			end
		})
		-- vim.api.nvim_create_autocmd('BufDelete', {
		-- 	callback = function()
		-- 		vim.cmd('EndHygge')
		-- 	end
		-- })

		vim.cmd('LetItSnow')
	end,

	--- Lazy loading ---
	lazy = true,
	event = 'BufEnter',
}
