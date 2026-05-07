return {
	-- lspconfig
	{
		--- Source ---
		'neovim/nvim-lspconfig',

		--- Loading ---
		dependencies = {
			'mason.nvim',
			{ 'mason-org/mason-lspconfig.nvim', config = function() end },
		},

		--- Setup ---
		opts_extend = { "servers.*.keys" },
		---@class PluginLspOpts
		opts = {
			-- options for vim.diagnostic.config()
			---@type vim.diagnostic.Opts
			diagnostics = {
				underline = true,
				update_in_insert = false,
				virtual_text = {
					spacing = 4,
					source = "if_many",
					prefix = "●",
					-- this will set the prefix to a function that returns the diagnostics icon based on the severity
					-- prefix = "icons"
				},
				severity_sort = true,
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = Config.defaults.icons.diagnostics.error,
						[vim.diagnostic.severity.WARN] = Config.defaults.icons.diagnostics.warn,
						[vim.diagnostic.severity.HINT] = Config.defaults.icons.diagnostics.hint,
						[vim.diagnostic.severity.INFO] = Config.defaults.icons.diagnostics.info,
					},
				},
			},
			-- Enable this to enable the builtin LSP inlay hints on Neovim.
			-- Be aware that you also will need to properly configure your LSP server to
			-- provide the inlay hints
			inlay_hints = {
				enabled = false,
				exclude = { 'vue' }, -- filetypes for which you don't want to enable inlay hints
			},
			-- Enable this to enable the builtin LSP code lenses on Neovim.
			-- Be aware that you also will need to properly configure your LSP server to
			-- provide the code lenses
			codelens = {
				enabled = false,
			},
			-- Enable this to enable the builtin LSP folding in Neovim.
			-- Be aware that you also will need to properly configure your LSP server to
			-- provide the folds.
			folds = {
				enabled = false,
			},
			-- Options for vim.lsp.buf.format
			-- `bufnr` and `filter` is handled by the LazyVim formatter,
			-- but can be also overridden when specified
			format = {
				formatting_options = nil,
				timeout_ms = nil,
			},
			-- LSP Server Settings
			-- Sets the default configuration for an LSP client (or all clients if the special name "*" is used).
			---@alias core.lsp.Config vim.lsp.Config|{ mason?: boolean, enabled?: boolean, keys?: LazyKeysLspSpec[] }
			---@type table<string, core.lsp.Config|boolean>
			servers = {
				-- Configuration for all lsp servers
				["*"] = {
					capabilities = {
						workspace = {
							fileOperations = {
								didRename = true,
								willRename = true,
							},
						},
					},
					-- stylua: ignore
					keys = {
						{ "<leader>cl", function() Snacks.picker.lsp_config() end, desc = "Lsp info" },
						{ "gd", vim.lsp.buf.definition, desc = "Go to definition", has = "definition" },
						{ "gr", vim.lsp.buf.references, desc = "References", nowait = true },
						{ "gI", vim.lsp.buf.implementation, desc = "Go to implementation" },
						{ "gy", vim.lsp.buf.type_definition, desc = "Go to t[y]pe definition" },
						{ "gD", vim.lsp.buf.declaration, desc = "Go to declaration" },
						{ "gh", function() return vim.lsp.buf.hover() end, desc = "Hover" },
						{ "gH", function() return vim.lsp.signature_help() end, desc = "Signature help", has = "signatureHelp" },
						{ "<C-k>", function() return vim.lsp.buf.signature_help() end, mode = 'i', desc = "Signature help", has = "signatureHelp" },
						{ "<leader>ca", vim.lsp.buf.code_action, desc = "Code action", mode = { 'n', 'x' }, has = "codeAction" },
						{ "<leader>cc", vim.lsp.codelens.run, desc = "Run codelens", mode = { 'n', 'x' }, has = "codeLens" },
						{ "<leader>cC", vim.lsp.codelens.refresh, desc = "Refresh & display codelens", mode = { 'n' }, has = "codeLens" },
						{ "<leader>cr", vim.lsp.buf.rename, desc = "Rename", has = "rename" },
						{ "<leader>cA", Config.lsp.action.source, desc = "Source action", has = "codeAction" },
						{
							"<leader>co",
							Config.lsp.action["source.organizeImports"],
							desc = "Organize imports",
							has = "codeAction",
							enabled = function(buf)
								local code_actions = vim.tbl_filter(function(action)
									return action:find("^source%.organizeImports%.?$")
								end, Config.lsp.code_actions({ bufnr = buf }))
								return #code_actions > 0
							end
						},
					},
				},
				stylua = { enabled = false },
				lua_ls = {
					-- mason = false, -- set to false if you don't want this server to be installed with mason
					-- Use this to add any additional keymaps
					-- for specific lsp servers
					-- ---@type LazyKeysSpec[]
					-- keys = {},
					settings = {
						Lua = {
							workspace = {
								checkThirdParty = false,
							},
							codeLens = {
								enable = true,
							},
							completion = {
								callSnippet = "Replace",
							},
							doc = {
								privateName = { "^_" },
							},
							hint = {
								enable = true,
								setType = false,
								paramType = true,
								paramName = "Disable",
								semicolon = "Disable",
								arrayIndex = "Disable",
							},
						},
					},
				},
			},
			-- you can do any additional lsp server setup here
			-- return true if you don't want this server to be setup with lspconfig
			---@type table<string, fun(server: string, opts: vim.lsp.Config):boolean?>
			setup = {
				-- example to setup with typescript.nvim
				-- tsserver = function(_, opts)
				--	require('typescript').setup({ server = opts })
				--	return true
				-- end,
				-- Specify * to use this function as a fallback for any server
				-- ["*"] = function(server, opts) end,
			},
		},
		---@param opts PluginLspOpts
		config = function(_, opts)
			--- Setup keymaps
			local names = vim.tbl_keys(opts.servers) ---@type string[]
			table.sort(names)

			-- Inlay hints
			if opts.inlay_hints.enabled then
				Snacks.util.lsp.on({ method = "textDocument/inlayHint" }, function(buffer)
					if vim.api.nvim_buf_is_valid(buffer) and vim.bo[buffer].buftype == "" and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[buffer].filetype) then
						vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
					end
				end)
			end

			-- Folds
			if opts.folds.enabled then
				Snacks.util.lsp.on({ method = "textDocument/foldingRange" }, function()
					if Config.set_default('foldmethod', 'expr') then
						Config.set_default('foldexpr', 'v:lua.vim.lsp.foldexpr()')
					end
				end)
			end

			-- Code lens
			if opts.codelens.enabled and vim.lsp.codelens then
				Snacks.util.lsp.on({ method = "textDocument/codeLens" }, function(buffer)
					vim.lsp.codelens.refresh()
					vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
						buffer = buffer,
						callback = vim.lsp.codelens.refresh,
					})
				end)
			end

			-- Diagnostics
			if type(opts.diagnostics.virtual_text) == 'table' and opts.diagnostics.virtual_text.prefix == 'icons' then
				opts.diagnostics.virtual_text.prefix = function(diagnostic)
					local icons = Config.defaults.icons.diagnostics

					for d, icon in pairs(icons) do
						if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
							return icon
						end
					end

					return "●"
				end
			end

			vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

			if opts.servers["*"] then
				vim.lsp.config("*", opts.servers["*"])
			end

			-- Get all the servers that are available through mason-lspconfig
			local have_mason = Config.has('mason-lspconfig.nvim')
			local mason_all = have_mason and vim.tbl_keys(require('mason-lspconfig.mappings').get_mason_map().lspconfig_to_package) or {} --[[ @as string[] ]]
			local mason_exclude = {} ---@type string[]

			---@return boolean? exclude automatic setup
			local function configure(server)
				if server == "*" then
					return false
				end

				local sopts = opts.servers[server]
				sopts = sopts == true and {} or (not sopts) and { enabled = false } or sopts -- [[@as core.lsp.Config]]

				if sopts.enabled == false then
					mason_exclude[#mason_exclude + 1] = server
					return
				end

				local use_mason = sopts.mason ~= false and vim.tbl_contains(mason_all, server)
				local setup = opts.setup[server] or opts.setup["*"]

				if setup and setup(server, sopts) then
					mason_exclude[#mason_exclude + 1] = server
				else
					vim.lsp.config(server, sopts) -- configure the server

					if not use_mason then
						vim.lsp.enable(server)
					end
				end

				return use_mason
			end

			local install = vim.tbl_filter(configure, vim.tbl_keys(opts.servers))

			if have_mason then
				require('mason-lspconfig').setup({
					ensure_installed = vim.list_extend(install, Config.opts('mason-lspconfig.nvim').ensure_installed or {}),
					automatic_enable = { exclude = mason_exclude },
				})
			end
		end,

		--- Lazy Loading ---
		lazy = true,
		event = { 'BufReadPre', 'BufNewFile' },
	},

	-- cmdline tools and lsp servers
	{
		--- Source ---
		'mason-org/mason.nvim',

		--- Setup ---
		opts = {
			ensure_installed = {
				'stylua',
				'shfmt',
			},
		},
		opts_extend = { "ensure_installed" },
		---@param opts MasonSettings|{ ensure_installed: string[] }
		config = function(_, opts)
			require('mason').setup(opts)
			local mr = require('mason-registry')
			mr:on('package:install:success', function()
				vim.defer_fn(function()
					-- trigger FileType event to possibly load this newly installed LSP server
					require('lazy.core.handler.event').trigger({
						event = 'FileType',
						buf = vim.api.nvim_get_current_buf(),
					})
				end, 100)
			end)

			mr.refresh(function()
				for _, tool in ipairs(opts.ensure_installed) do
					local p = mr.get_package(tool)

					if not p:is_installed() then
						p:install()
					end
				end
			end)
		end,
		build = ":MasonUpdate",

		--- Lazy loading ---
		cmd = "Mason",
		keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
	},
}
