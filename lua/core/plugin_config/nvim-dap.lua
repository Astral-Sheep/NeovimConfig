local dap = require('dap')
local fn = vim.fn
local lldb_path = "C:\\Program Files\\LLVM\\bin\\lldb-vscode.exe"

if (not fn.findfile(lldb_path))
then
	lldb_path = "C:\\Program Files\\LLVM\\bin\\lldb-dap.exe"
end

-- Adapters
dap.adapters.lldb = {
	name = 'lldb',
	type = 'executable',
	command = lldb_path,
}

-- Configurations
dap.configurations.cpp = {
	{
		name = "C/C++ Debug Launch",
		type = 'lldb',
		request = 'launch',
		program = function()
			return fn.input("Path to executable: ", fn.getcwd() .. "\\", 'file')
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},
	},
	{
		name = "C/C++ Debug Attach Auto",
		type = 'lldb',
		request = 'attach',
		program = function()
			return fn.input("Path to executable: ", fn.getcwd() .. "\\", 'file')
		end,
		stopOnEntry = false,
	},
}
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

-- Mapping
local map = vim.keymap
local dap_widgets = require('dap.ui.widgets')

map.set('n', 'bp', function()
	dap.toggle_breakpoint()
end)	-- bp for BreakPoint

map.set('n', '<C-B>p', function()
	dap.set_breakpoint()
end)	-- Bp for BreakPoint

map.set('n', 'lp', function()
	dap.set_breakpoint(nil, nil, fn.input("Log point message: "))
end)	-- lp for LogPoint

map.set('n', 'dc', function()
	dap.continue()
end)

map.set('n', 'sov', function()
	dap.step_over()
end)	-- sov for Step Over

map.set('n', 'si', function()
	dap.step_into()
end)	-- si for Step Into

map.set('n', 'sou', function()
	dap.step_out()
end)	-- sou for Step Out

map.set('n', 'dr', function()
	dap.repl.open()
end)	-- dr for Dap Repl

map.set('n', 'dl', function()
	dap.run_last()
end)	-- dl for Dap run Last

map.set('n', 'dh', function()
	dap_widgets.hover()
end)	-- dh for Dap Hover

map.set('n', 'dp', function()
	dap_widgets.preview()
end)	-- dp for Dap Preview

-- Highlighting
fn.sign_define('DapBreakpoint',				{ text='', texthl='DiagnosticError', linehl='', numhl='DiagnosticError' })
fn.sign_define('DapBreakpointCondition',	{ text='', texthl='DiagnosticError', linehl='', numhl='DiagnosticError' })
fn.sign_define('DapBreakpointRejected',		{ text='', texthl='DiagnosticUnderlineError', linehl='', numhl='DiagnosticUnderlineError' })
fn.sign_define('DapLogPoint',				{ text='', texthl='DiagnosticError', linehl='', numhl='DiagnosticError' })
fn.sign_define('DapStopped',				{ text='→', texthl='DiagnosticInfo', linehl='debugPC', numhl='DiagnosticInfo' })

