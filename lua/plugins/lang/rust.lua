local diagnostics = vim.g.lazyvim_rust_diagnostics or 'rust-analyzer'

return {
	-- LSP for Cargo.toml
	{
		--- Source ---
		'Saecki/crates.nvim',

		--- Setup ---
		opts = {
			completion = {
				crates = {
					enabled = true,
				},
			},
			lsp = {
				enabled = true,
				actions = true,
				completion = true,
				hover = true,
			},
		},

		--- Lazy loading ---
		event = { 'BufRead Cargo.toml' },
	},

	{
		--- Source ---
		'nvim-treesitter/nvim-treesitter',

		--- Setup ---
		opts = { ensure_installed = { 'rust' } },
	},

	{
		--- Source ---
		'mason-org/mason.nvim',

		--- Setup ---
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, { 'codelldb' })

			if diagnostics == 'bacon-ls' then
				vim.list_extend(opts.ensure_installed, { 'bacon' })
			end
		end,
	},

	{
		--- Source ---
		'mrcjkb/rustaceanvim',

		--- Setup ---
		opts = {
			server = {
				on_attach = function(_, bufnr)
					vim.keymap.set('n', '<leader>cR', function()
						vim.cmd.RustLsp('codeAction')
					end, { desc = "Code Action", buffer = bufnr })
					vim.keymap.set('n', '<leader>dr', function()
						vim.cmd.RustLsp('debuggables')
					end, { desc = "Rust Debuggables", buffer = bufnr })
				end,
				default_settings = {
					-- rust-analyzer language server configuration
					['rust-analyzer'] = {
						cargo = {
							allFeatures = true,
							loadOutDirsFromCheck = true,
							buildScripts = {
								enable = true,
							},
						},
						-- Add clippy lints for Rust if using rust-analyzzer
						checkOnSave = diagnostics == 'rust-analyzer',
						-- Enable diagnostics if using rust-analyzer
						diagnostics = {
							enable = diagnostics == 'rust-analyzer'
						},
						procMacro = {
							enable = true,
						},
						files = {
							exclude = {
								".direnv",
								".git",
								".jj",
								".github",
								".gitlab",
								"bin",
								"node_modules",
								"target",
								"venv",
								".venv",
							},
							-- Avoid Roots Scanned hanging, see https://github.com/rust-lang/rust-analyzer/issues/12613#issuecomment-2096386344
							watcher = 'client',
						},
					},
				},
			},
		},
		config = function(_, opts)
			if Config.has('mason.nvim') then
				local codelldb = vim.fn.exepath('codelldb')
				local codelldb_lib_ext = io.popen('uname'):read("*l") == "Linux" and ".so" or ".dylib"
				local library_path = vim.fn.expand("$MASON/opt/lldb/lib/liblldb" .. codelldb_lib_ext)

				opts.dap = {
					adapter = require('rustaceanvim.config').get_codelldb_adapter(codelldb, library_path),
				}
			end

			vim.g.rustaceanvim = vim.tbl_deep_extend('keep', vim.g.rustaceanvim or {}, opts or {})

			if vim.fn.executable('rust-analyzer') == 0 then
				Config.utils.error(
					"**rust-analyzer** not found in PATH, please install it.\nhttps://rust-analyzer.github.io/",
					{ title = "rustaceanvim" }
				)
			end
		end,

		--- Lazy loading ---
		ft = { 'rust' },
	},

	{
		--- Source ---
		'neovim/nvim-lspconfig',

		--- Setup ---
		opts = {
			servers = {
				bacon_ls = {
					enabled = diagnostics == 'bacon-ls',
				},
				rust_analyzer = { enabled = false },
			},
		},
	},
}
