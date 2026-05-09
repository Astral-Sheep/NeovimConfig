---@param config { type?: string, args?: string[]|fun(): string[]? }
local function get_args(config)
	local args = type(config.args) == 'function' and (config.args() or {}) or config.args or {} --[[@as string[] | string ]]
	local args_str = type(args) == 'table' and table.concat(args, " ") or args --[[@as string]]

	config = vim.deepcopy(config)
	---@cast args string[]
	config.args = function()
		local new_args = vim.fn.expand(vim.fn.input("Run with args: ", args_str)) --[[@as string]]

		if config.type and config.type == 'java' then
			---@diagnostic disable-next-line: return-type-mismatch
			return new_args
		end

		return require('dap.utils').splitstr(new_args)
	end

	return config
end

return {
	{
		--- Source ---
		'mfussenegger/nvim-dap',
		desc = "Debugging support. Requires language specific adapters to be configured.",

		--- Loading ---
		dependencies = {
			'rcarriga/nvim-dap-ui',
			-- Virtual text for the debugger
			{
				'theHamsta/nvim-dap-virtual-text',
				opts = {},
			},
		},

		--- Setup ---
		config = function()
			if Config.has('mason-nvim-dap.nvim') then
				require('mason-nvim-dap').setup(Config.opts('mason-nvim-dap.nvim'))
			end

			vim.api.nvim_set_hl(0, 'DapStoppedLine', { default = true, link = 'Visual' })

			for name, sign in pairs(Config.defaults.icons.dap) do
				sign = type(sign) == 'table' and sign or { sign }
				vim.fn.sign_define(
					"Dap" .. name,
					{ text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
				)
			end

			-- Setup DAP config by VsCode launch.json file
			local vscode = require('dap.ext.vscode')
			local json = require('plenary.json')
			vscode.json_decode = function(str)
				return vim.json.decode(json.json_strop_comments(str))
			end
		end,

		--- Lazy loading ---
		keys = {
			{ '<leader>dB', function() require('dap').set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "Breakpoint Condition" },
			{ '<leader>db', function() require('dap').toggle_breakpoint() end, desc = "Toggle Breakpoint" },
			{ '<leader>dc', function() require('dap').continue() end, desc = "Run/Continue" },
			{ '<leader>da', function() require('dap').continue({ before = get_args }) end, desc = "Run with Args" },
			{ '<leader>dC', function() require('dap').run_to_cursor() end, desc = "Run to Cursor" },
			{ '<leader>dg', function() require('dap').goto() end, desc = "Go to Line (No Execute)" },
			{ '<leader>di', function() require('dap').step_into() end, desc = "Step Into" },
			{ '<leader>dj', function() require('dap').down() end, desc = "Down" },
			{ '<leader>dk', function() require('dap').up() end, desc = "Up" },
			{ '<leader>dl', function() require('dap').run_last() end, desc = "Run Last" },
			{ '<leader>do', function() require('dap').step_out() end, desc = "Step Out" },
			{ '<leader>dO', function() require('dap').step_over() end, desc = "Step Over" },
			{ '<leader>dP', function() require('dap').pause() end, desc = "Pause" },
			{ '<leader>dr', function() require('dap').repl.toggle() end, desc = "Toggle REPL" },
			{ '<leader>ds', function() require('dap').session() end, desc = "Session" },
			{ '<leader>dt', function() require('dap').terminate() end, desc = "Terminate" },
			{ '<leader>dw', function() require('dap.ui.widgets').hover() end, desc = "Widgets" },
		}
	},

	{
		--- Source ---
		'rcarriga/nvim-dap-ui',

		--- Loading ---
		dependencies = { 'nvim-neotest/nvim-nio' },

		--- Setup ---
		opts = {},
		config = function(_, opts)
			local dap = require('dap')
			local dapui = require('dapui')

			dapui.setup(opts)
			dap.listeners.after.event_initialized['dapui_config'] = function()
				dapui.open({})
			end
			dap.listeners.before.event_terminated['dapui_config'] = function()
				dapui.close({})
			end
			dap.listeners.before.event_exited['dapui_config'] = function()
				dapui.close({})
			end
		end,

		--- Lazy loading ---
		keys = {
			{ '<leader>du', function() require('dapui').toggle({}) end, desc = "DAP UI" },
			{ '<leader>de', function() require('dapui').eval() end, desc = "Eval", mode = { 'n', 'x' } },
		},
	},

	-- mason.nvim integration
	{
		--- Source ---
		'jay-babu/mason-nvim-dap.nvim',

		--- Loading ---
		dependencies = 'mason.nvim',

		--- Setup ---
		opts = {
			-- Makes a best effort to setup the various debuggers with
			-- reasonable debug configurations
			automatic_installation = true,

			-- You can provide additional configuration to the handlers,
			-- see mason-nvim-dap README for more information
			handlers = {},

			ensure_installed = {
				-- Update this to ensure that you have the debuggers for the langs you want
			},
		},
		config = function() end,

		--- Lazy loading ---
		cmd = { 'DapInstall', 'DapUninstall' },
	},
}
