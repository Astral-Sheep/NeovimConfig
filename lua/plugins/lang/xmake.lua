return {
	{
		--- Source ---
		'Mythos-404/xmake.nvim',

		--- Setup ---
		opts = {
			on_save = {
				reload_project_info = true,
				lsp_compile_commands = {
					enable = true,
					output_dir = "_Binaries",
				},
			},
			lsp = {
				enable = true,
			},
			debuger = { -- I hate that there's a typo here
				rulus = { 'debug', 'releasedbg' },
				dap = {
					name = "Xmake Debug",
					type = 'codelldb',
					request = 'launch',
					cwd = '${workspaceFolder}',
					console = 'integratedTerminal',
					stopOnEntry = false,
					runInTerminal = true,
				},
			},
			dev_debug = false,
		},
		config = true,

		--- Lazy loading ---
		event = { "BufRead xmake.lua" },

		--- Versioning ---
		version = '^3',
	},
}
