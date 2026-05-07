-- Terminal mappings
local function term_nav(dir)
	---@param self snacks.terminal
	return function(self)
		return self:is_floating() and "<c-" .. dir .. ">" or vim.schedule(function()
			vim.cmd.wincmd(dir)
		end)
	end
end

return {
	-- Snacks utils
	{
		--- Source ---
		'snacks.nvim',

		--- Setup ---
		opts = {
			bigfile = { enabled = true },
			quickfile = { enabled = true },
			terminal = {
				win = {
					keys = {
						nav_h = { "<C-h>", term_nav("h"), desc = "Go to left window", expr = true, mode = 't' },
						nav_j = { "<C-j>", term_nav("j"), desc = "Go to lower window", expr = true, mode = 't' },
						nav_k = { "<C-k>", term_nav("k"), desc = "Go to upper window", expr = true, mode = 't' },
						nav_l = { "<C-l>", term_nav("l"), desc = "Go to right window", expr = true, mode = 't' },
						hide_slash = { "<C-/>", "hide", desc = "Hide terminal", mode = 't' },
						hide_underscore = { "<C-_>", "hide", desc = "which_key_ignore", mode = 't' },
					},
				},
			},
		},

		--- Lazy loading ---
		keys = {
			{ "<leader>.", function() Snacks.scratch() end, desc = "Toggle scratch buffer" },
			{ "<leader>S", function() Snacks.scratch.select() end, desc = "Select scratch buffer" },
			{ "<leader>dps", function() Snacks.profiler.scratch() end, desc = "Profiler scratch buffer" },
		},
	},

	-- Session management. This saves your session in the background,
	-- keeping track of open buffers, window arrangement, and more.
	-- You can restore sessions when returning through the dashboard.
	{
		--- Source ---
		'folke/persistence.nvim',

		--- Setup ---
		opts = {},

		--- Lazy loading ---
		event = 'BufReadPre',
		keys = {
			{ "<leader>qs", function() require('persistence').load() end, desc = "Restore session" },
			{ "<leader>qS", function() require('persistence').select() end, desc = "Select session" },
			{ "<leader>ql", function() require('persistence').load({ last = true }) end, desc = "Restore last session" },
			{ "<leader>qd", function() require('persistence').stop() end, desc = "Don't save current session" },
		},
	},

	-- Library used by other plugins
	{ 'nvim-lua/plenary.nvim', lazy = true },
}
