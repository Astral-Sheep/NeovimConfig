return {
	-- Treesitter is a new parser generator tool that we can
	-- use in Neovim to power faster and more accurate
	-- syntax highlighting.
	{
		--- Source ---
		'nvim-treesitter/nvim-treesitter',

		--- Setup ---
		---@alias plugin.TSFeat { enable?: boolean, disable?: string[] }
		---@class plugin.TSConfig: TSConfig
		opts = {
			-- LazyVim config for treesitter
			indent = { enable = true }, ---@type plugin.TSFeat
			highlight = { enable = true }, ---@type plugin.TSFeat
			folds = { enable = false }, ---@type plugin.TSFeat
			ensure_installed = {
				'css',
				'diff',
				'glsl',
				'hlsl',
				'html',
				'javascript',
				'jsdoc',
				'json',
				'markdown',
				'markdown_inline',
				'powershell',
				'printf',
				'python',
				'query',
				'regex',
				'toml',
				'tsx',
				'typescript',
				'vim',
				'vimdoc',
				'xml',
				'yaml',
			},
		},
		opts_extend = { 'ensure_installed' },
		config = function(_, opts)
			local TS = require('nvim-treesitter')

			setmetatable(require('nvim-treesitter.install'), {
				__newindex = function(_, k)
					if k == 'compilers' then
						vim.schedule(function()
							Config.utils.error({
								"Setting custom compilers for `nvim-treesitter` is no longer supported.",
								"",
								"For more info, see:",
								"- [compilers](https://docs.rs/cc/latest/cc/#compile-time-requirements)",
							})
						end)
					end
				end,
			})

			-- Some quick sanity checks
			if not TS.get_installed then
				return Config.utils.error("Please use `:Lazy` and update `nvim-treesitter`")
			elseif type(opts.ensure_installed) ~= 'table' then
				return Config.utils.error("`nvim-treesitter` opts.ensure_installed must be a table")
			end

			-- Setup treesitter
			TS.setup(opts)
			Config.treesitter.get_installed(true) -- Initialize the installed langs

			-- Install missing parsers
			local install = vim.tbl_filter(function(lang)
				return not Config.treesitter.have(lang)
			end, opts.ensure_installed or {})

			if #install > 0 then
				Config.treesitter.build(function()
					TS.install(install, { summary = true }):await(function()
						Config.treesitter.get_installed(true) -- Refresh the installed langs
					end)
				end)
			end

			vim.api.nvim_create_autocmd('FileType', {
				group = vim.api.nvim_create_augroup("lazyvim_treesitter", { clear = true }),
				callback = function(ev)
					local ft, lang = ev.match, vim.treesitter.language.get_lang(ev.match)

					if not Config.treesitter.have(ft) then
						return
					end

					---@param feat string
					---@param query string
					local function enabled(feat, query)
						local f = opts[feat] or {} ---@type plugin.TSFeat
						return f.enable ~= false
							and not (type(f.disable) == 'table' and vim.tbl_contains(f.disable, lang))
							and Config.treesitter.have(ft, query)
					end

					-- Highlighting
					if enabled('highlight', 'highlights') then
						pcall(vim.treesitter.start, ev.buf)
					end

					-- Indents
					if enabled('indent', 'indents') then
						Config.set_default('indentexpr', 'v:lua.Config.treesitter.indentexpr()')
					end

					-- Folds
					if enabled('folds', 'folds') then
						if Config.set_default('foldmethod', 'expr') then
							Config.set_default('foldexpr', 'v:lua.Config.treesitter.foldexpr()')
						end
					end
				end,
			})

			-- Update colors when color scheme changes
			vim.api.nvim_create_autocmd('ColorScheme', {
				nested = true,
				callback = function()
					Config.treesitter.apply_overrides()
				end,
			})

			Config.treesitter.apply_overrides()
		end,
		build = function()
			local TS = require('nvim-treesitter')

			if not TS.get_installed then
				Config.utils.error("Please restart Neovim and run `:TSUpdate` to use the `nvim-treesitter` **main** branch.")
				return
			end

			-- Make sure we're using the latest treesitter util
			package.loaded['core.treesitter'] = nil
			Config.treesitter.build(function()
				TS.update(nil, { summary = true })
			end)
		end,

		--- Lazy loading ---
		event = 'VeryLazy',
		cmd = { 'TSUpdate', 'TSInstall', 'TSLog', 'TSUninstall' },

		--- Versioning ---
		branch = 'main',
		commit = vim.fn.has('nvim-0.12') == 0 and '7caec274fd19c12b55902a5b795100d21531391f' or nil,
		version = false, -- last release is way too old and doesn't work on windows
	},

	{
		--- Source ---
		'nvim-treesitter/nvim-treesitter-textobjects',

		--- Setup ---
		opts = {
			move = {
				enable = true,
				set_jumps = true, -- Whether to set jumps in the jumplist
				-- LazyVim extention to create buffer-local keymaps
				keys = {
					goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
					goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
					goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
					goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
				},
			},
		},
		config = function(_, opts)
			local TS = require('nvim-treesitter-textobjects')

			if not TS.setup then
				Config.utils.error("Please use `:Lazy` and update `nvim-treesitter`")
				return
			end

			TS.setup(opts)

			local function attach(buf)
				local ft = vim.bo[buf].filetype

				if not (vim.tbl_get(opts, 'move', 'enable') and Config.treesitter.have(ft, 'textobjects')) then
					return
				end

				---@type table<string, table<string, string>>
				local moves = vim.tbl_get(opts, 'move', 'keys') or {}

				for method, keymaps in pairs(moves) do
					for key, query in pairs(keymaps) do
						local queries = type(query) == 'table' and query or { query }
						local parts = {}

						for _, q in ipairs(queries) do
							local part = q:gsub("@", ""):gsub("%..*", "")
							part = part:sub(1, 1):upper() .. part:sub(2)
							table.insert(parts, part)
						end

						local desc = table.concat(parts, " or ")
						desc = (key:sub(1, 1) == "[" and "Prev " or "Next ") .. desc
						desc = desc .. (key:sub(2, 2) == key:sub(2, 2):upper() and " End" or " Start")
						vim.keymap.set({ 'n', 'x', 'o' }, key, function()
							if vim.wo.diff and key:find("[cC]") then
								return vim.cmd('normal! ' .. key)
							end

							require('nvim-treesitter-textobjects.move')[method](query, 'textobjects')
						end, {
							buffer = buf,
							desc = desc,
							silent = true,
						})
					end
				end
			end

			vim.api.nvim_create_autocmd('FileType', {
				group = vim.api.nvim_create_augroup('lazyvim_treesitter_textobjects', { clear = true }),
				callback = function(ev)
					attach(ev.buf)
				end,
			})
			vim.tbl_map(attach, vim.api.nvim_list_bufs())
		end,

		--- Lazy loading ---
		event = 'VeryLazy',

		--- Versioning ---
		branch = 'main',
	},
}
