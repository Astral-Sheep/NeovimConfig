return {
	--- Source ---
	'mfussenegger/nvim-dap',

	--- Loading ---
	dependencies = {
		'rcarriga/nvim-dap-ui',
		'nvim-neotest/nvim-nio',
	},

	--- Setup ---
	config = function()
		local dap = require('dap')
		local fn = vim.fn

		-- Adapaters
		dap.adapters.lldb = {
			name = 'lldb',
			type = 'executable',
			command = 'lldb-vscode',
			args = {},
			options = {
				detached = false,
			},
		}

		-- Configurations
		local function get_exe_path()
			return fn.input({
				prompt = "Path to executable: ",
				default = fn.getcwd() .. "\\",
				completion = 'file'
			})
		end

		dap.configurations.cpp = {
			{
				name = "Launch",
				type = 'lldb',
				request = 'launch',
				program = get_exe_path,
				cwd = "${workspaceFolder}",
				stopAtBeginningOfMainSubprogram = false,
				stopOnEntry = false,
				args = {},
				runInTerminal = false,
			},
			-- {
			-- 	name = "Attach Auto",
			-- 	type = 'lldb',
			-- 	request = 'attach',
			-- 	program = getExePath,
			-- 	stopAtBeginningOfMainSubprogram = false,
			-- 	stopOnEntry = false,
			-- },
		}

		dap.configurations.c = dap.configurations.cpp

		-- Mapping
		local map = vim.keymap
		local dap_widgets = require('dap.ui.widgets')
		map.set('n', 'bp', function()
			dap.toggle_breakpoint()
		end, {
			silent = true,
			desc = "Toggle breakpoint on current line",
		})	-- bp for BreakPoint

		map.set('n', '<C-b>p', function()
			dap.set_breakpoint()
		end, {
			silent = true,
			desc = "Enable breakpoint on current line",
		})	-- bp for BreakPoint

		map.set('n', 'cp', function()
			dap.set_breakpoint(fn.input("Stop condition: "))
		end, {
			silent = true,
			desc = "Enable conditional breakpoint on current line",
		})	-- cp for Conditional breakPoint

		map.set('n', 'lp', function()
			dap.set_breakpoint(nil, nil, fn.input("Log point message: "))
		end, {
			silent = true,
			desc = "Enable breakpoint with message on current line",
		})	-- lp for LogPoint

		map.set('n', '<F4>', function()
			dap.disconnect({ terminateDebuggee = true })
		end, {
			desc = "Disconnect debugger",
		})

		map.set('n', '<F5>', function()
			dap.continue()
		end, {
			desc = "Continue program execution",
		})

		map.set('n', '<F6>', function()
			dap.restart()
		end, {
			desc = "Restart program",
		})

		map.set('n', '<F10>', function()
			dap.step_over()
		end, {
			desc = "Go to next program step",
		})

		map.set('n', '<S-F10>', function()
			dap.step_back()
		end, {
			desc = "Go to last program step",
		})

		map.set('n', '<F11>', function()
			dap.step_into()
		end, {
			desc = "Go to program step into function",
		})

		map.set('n', '<F12>', function()
			dap.step_out()
		end, {
			desc = "Go to program step outside of current function",
		})

		map.set('n', 'gt', function()
			dap.goto_()
		end, {
			desc = "Go to line under cursor",
		})	-- gt for Go To

		map.set('n', 'dr', function()
			dap.repl.open()
		end)	-- dr for Dap Repl

		map.set('n', 'dl', function()
			dap.run_last()
		end, {
			desc = "Run last debugging configuration",
		})	-- dl for Dap run Last

		map.set({ 'n', 'v' }, 'dh', function()
			dap_widgets.hover()
		end)	-- dh for Dap Hover

		map.set({ 'n', 'v' }, 'dp', function()
			dap_widgets.preview()
		end)	-- dp for Dap Preview

		-- Highlighting
		fn.sign_define('DapBreakpoint',				{ text='', texthl='DiagnosticError', linehl='', numhl='DiagnosticError' })
		fn.sign_define('DapBreakpointCondition',	{ text='', texthl='DiagnosticError', linehl='', numhl='DiagnosticError' })
		fn.sign_define('DapBreakpointRejected',		{ text='', texthl='Error', linehl='', numhl='DiagnosticError' })
		fn.sign_define('DapLogPoint',				{ text='', texthl='DiagnosticError', linehl='', numhl='DiagnosticError' })
		fn.sign_define('DapStopped',				{ text='→', texthl='DiagnosticInfo', linehl='debugPC', numhl='DiagnosticInfo' })
	end,

	--- Lazy Loading ---
	lazy = true,
	ft = { 'c', 'cpp' },
}
