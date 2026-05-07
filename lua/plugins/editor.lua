local function symbols_filter(entry, ctx)
	if ctx.symbol_filter == nil then
		ctx.symbols_filter = Config.get_kind_filter(ctx.bufnr) or false
	end

	if ctx.symbols_filter == false then
		return true
	end

	return vim.tbl_contains(ctx.symbols_filter, entry.kind)
end

return {
	-- which-key helps you remember key bindings by showing a popup
	-- with the active keybindings of the command you started typing
	{
		--- Source ---
		'folke/which-key.nvim',

		--- Setup ---
		opts = {
			preset = 'helix',
			spec = {
				{
					mode = { 'n', 'x' },
					{ '<leader><tab>', group = "tabs" },
					{ '<leader>c', group = "code" },
					{ '<leader>d', group = "debug" },
					{ '<leader>dp', group = "profiler" },
					{ '<leader>f', group = "file/find" },
					{ '<leader>g', group = "git" },
					{ '<leader>gh', group = "hunks" },
					{ '<leader>q', group = "quit/session" },
					{ '<leader>s', group = "search" },
					{ '<leader>u', group = "ui" },
					{ '<leader>x', group = "diagnostics/quickfix" },
					{ '[', group = "prev" },
					{ ']', group = "next" },
					{ 'g', group = "goto" },
					{ 'gs', group = "surround" },
					{ 'z', group = "fold" },
					{
						'<leader>b',
						group = "buffer",
						expand = function()
							return require('which-key.extras').expand.buf()
						end,
					},
					{
						'<leader>w',
						group = "windows",
						proxy = '<c-w>',
						expand = function()
							return require('which-key.extras').expand.win()
						end,
					},
					-- Better descriptions
					{ 'gx', desc = "Open with system app" },
				},
			},
		},
		opts_extend = { 'spec' },

		--- Lazy loading ---
		event = 'VeryLazy',
		keys = {
			{
				'<leader>?',
				function()
					require('which-key').show({ global = false })
				end,
				desc = "Buffer Keymaps (which-key)",
			},
			{
				'<c-w><space>',
				function()
					require('which-key').show({ keys = '<c-w>', loop = true })
				end,
				desc = "Window Hydra Mode (which-key)",
			},
		},
	},

	{
		--- Source ---
		'ibhagwan/fzf-lua',

		--- Setup ---
		init = function()
			Config.on_very_lazy(function()
				vim.ui.select = function(...)
					require('lazy').load({ plugins = { 'fzf-lua' } })
					local opts = Config.opts('fzf-lua') or {}
					require('fzf-lua').register_ui_select(opts.ui_select or nil)
					return vim.ui.select(...)
				end
			end)
		end,
		opts = function(_, opts)
			local fzf = require('fzf-lua')
			local config = fzf.config
			local actions = fzf.actions

			-- Quickfix
			config.defaults.keymap.fzf['ctrl-q'] = 'select-all+accept'
			config.defaults.keymap.fzf['ctrl-u'] = 'half-page-up'
			config.defaults.keymap.fzf['ctrl-d'] = 'half-page-down'
			config.defaults.keymap.fzf['ctrl-x'] = 'jump'
			config.defaults.keymap.fzf['ctrl-f'] = 'preview-page-down'
			config.defaults.keymap.fzf['ctrl-b'] = 'preview-page-up'
			config.defaults.keymap.builtin['<c-f>'] = 'preview-page-down'
			config.defaults.keymap.builtin['<c-b>'] = 'preview-page-up'

			-- Trouble
			if Config.has('trouble.nvim') then
				config.defaults.actions.files['ctrl-t'] = require('trouble.sources.fzf').actions.open
			end

			-- Toggle root dir / cwd
			-- config.defaults.actions.files['ctrl-r'] = function(_, ctx)
			-- 	local o = vim.deepcopy(ctx.__call_opts)
			-- 	o.root = o.root == false
			-- 	o.cwd = nil
			-- 	o.buf = ctx.__CTX.bufnr
			-- end
			-- config.defaults.actions.files['alt-c'] = config.defaults.actions.files['ctrl-r']
			-- config.set_action_helpstr(config.defaults.actions.files['ctrl-r'], 'toggle-root-dir')

			local img_previewer ---@type string[]?

			for _, v in ipairs({
				{ cmd = "ueberzug", args = {} },
				{ cmd = "chafa", args = { "{file}", "--format=symbols" } },
				{ cmd = "viu", args = { "-b" } },
			}) do
				if vim.fn.executable(v.cmd) == 1 then
					img_previewer = vim.list_extend({ v.cmd }, v.args)
					break
				end
			end

			return {
				"default-title",
				fzf_colors = true,
				fzf_opts = {
					['--no-scrollbar'] = true,
				},
				defaults = {
					-- formatter = 'path.filename_first',
					formatter = 'path.dirname_first',
				},
				previewers = {
					builtin = {
						extensions = {
							['png'] = img_previewer,
							['jpg'] = img_previewer,
							['jpeg'] = img_previewer,
							['gif'] = img_previewer,
							['webp'] = img_previewer,
						},
						ueberzug_scaler = "fit_contain",
					},
				},
				-- Custom LazyVim option to configure vim.ui.select
				ui_select = function(fzf_opts, items)
					return vim.tbl_deep_extend('force', fzf_opts, {
						prompt = " ",
						winopts = {
							title = " " .. vim.trim((fzf_opts.prompt or "Select"):gsub("%s*:%s*$", "")) .. " ",
							title_pos = 'center',
						},
					}, fzf_opts.kind == 'codeaction' and {
						winopts = {
							layout = 'vertical',
							-- height is number of items minus 15 lines for the preview, with a max of 80% screen height
							height = math.floor(math.min(vim.o.lines * 0.8 - 15, #items + 4) + 0.5) + 16,
							width = 0.5,
							preview = not vim.tbl_isempty(vim.lsp.get_clients({ bufnr = 0, name = "vstsls" })) and {
								layout = 'vertical',
								vertical = 'down:15,border-top',
								hidden = 'hidden',
							} or {
								layout = 'vertical',
								vertical = 'down:15,border-top',
							},
						},
					} or {
						winopts = {
							width = 0.5,
							-- height is number of items, with a max of 80% screen height
							height = math.floor(math.min(vim.o.lines * 0.8, #items + 4) + 0.5),
						},
					})
				end,
				winopts = {
					width = 0.8,
					height = 0.8,
					row = 0.5,
					col = 0.5,
					preview = {
						scrollchars = { "┃", "" },
					},
				},
				files = {
					cwd_prompt = false,
					actions = {
						['alt-i'] = { actions.toggle_ignore },
						['alt-h'] = { actions.toggle_hidden },
					},
				},
				grep = {
					actions = {
						['alt-i'] = { actions.toggle_ignore },
						['alt-h'] = { actions.toggle_hidden },
					},
				},
				lsp = {
					symbols = {
						symbol_hl = function(s)
							return "TroubleIcon" .. s
						end,
						symbol_fmt = function(s)
							return s:lower() .. "\t"
						end,
						child_prefix = false,
					},
					code_actions = {
						previewer = vim.fn.executable('delta') == 1 and 'codeaction_native' or nil,
					},
				},
			}
		end,
		config = function(_, opts)
			if opts[1] == "default-title" then
				-- Use the same prompt for all pickers for profile `default-title` and
				-- profiles that use `default-title` as base profile
				local function fix(t)
					t.prompt = t.prompt ~= nil and " " or nil

					for _, v in pairs(t) do
						if type(v) == 'table' then
							fix(v)
						end
					end

					return t
				end

				opts = vim.tbl_deep_extend('force', fix(require('fzf-lua.profiles.default-title')), opts)
				opts[1] = nil
			end

			require('fzf-lua').setup(opts)
		end,

		--- Lazy loading ---
		cmd = 'FzfLua',
		keys = {
			{ '<c-j>', '<c-j>', ft = 'fzf', mode = 't', nowait = true },
			{ '<c-k>', '<c-k>', ft = 'fzf', mode = 't', nowait = true },
			{
				'<leader>,',
				'<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>',
				desc = "Switch Buffer",
			},
			{ '<leader>:', '<cmd>FzfLua command_history<cr>', desc = "Command History" },
			-- Find
			{ '<leader>fb', '<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>', desc = "Buffers" },
			{ '<leader>fB', '<cmd>FzfLua buffers<cr>', desc = "Buffers (all)" },
			{ '<leader>fg', '<cmd>FzfLua git_files<cr>', desc = "Find Files (git-files)" },
			{ '<leader>fr', '<cmd>FzfLua oldfiles<cr>', desc = "Recent" },
			-- Git
			{ '<leader>gc', '<cmd>FzfLua git_commits<CR>', desc = "Commits" },
			{ '<leader>gd', '<cmd>FzfLua git_diff<cr>', desc = "Git Diff (files)" },
			{ '<leader>gl', '<cmd>FzfLua git_commits<CR>', desc = "Commits" },
			{ '<leader>gs', '<cmd>FzfLua git_status<CR>', desc = "Status" },
			{ '<leader>gS', '<cmd>FzfLua git_stash<cr>', desc = "Git Stash" },
			-- Search
			{ '<leader>s"', '<cmd>FzfLua registers<cr>', desc = "Registers" },
			{ '<leader>s/', '<cmd>FzfLua search_history<cr>', desc = "Search History" },
			{ '<leader>sa', '<cmd>FzfLua autocmds<cr>', desc = "Auto Commands" },
			{ '<leader>sb', '<cmd>FzfLua lines<cr>', desc = "Buffer Lines" },
			{ '<leader>sc', '<cmd>FzfLua command_history<cr>', desc = "Command History" },
			{ '<leader>sC', '<cmd>FzfLua commands<cr>', desc = "Commands" },
			{ '<leader>sd', '<cmd>FzfLua diagnostics_workspace<cr>', desc = "Diagnostics" },
			{ '<leader>sD', '<cmd>FzfLua diagnostics_document<cr>', desc = "Buffer Diagnostics" },
			{ '<leader>sh', '<cmd>FzfLua help_tags<cr>', desc = "Help Pages" },
			{ '<leader>sH', '<cmd>FzfLua highlights<cr>', desc = "Search Highlight Groups" },
			{ '<leader>sj', '<cmd>FzfLua jumps<cr>', desc = "Jumplist" },
			{ '<leader>sk', '<cmd>FzfLua keymaps<cr>', desc = "Key Maps" },
			{ '<leader>sl', '<cmd>FzfLua loclist<cr>', desc = "Location List" },
			{ '<leader>sM', '<cmd>FzfLua man_pages<cr>', desc = "Man Pages" },
			{ '<leader>sm', '<cmd>FzfLua marks<cr>', desc = "Jump to Mark" },
			{ '<leader>sR', '<cmd>FzfLua resume<cr>', desc = "Resume" },
			{ '<leader>sq', '<cmd>FzfLua quickfix<cr>', desc = "Quickfix List" },
			{
				'<leader>ss',
				function()
					require('fzf-lua').lsp_document_symbols({
						regex_filter = symbols_filter,
					})
				end,
				desc = "Goto Symbol",
			},
			{
				'<leader>sS',
				function()
					require('fzf-lua').lsp_live_workspace_symbols({
						regex_filter = symbols_filter,
					})
				end,
				desc = "Goto Symbol (Workspace)"
			},
		},
	},

	-- Flash enhanced the built-in search functionality by showing labels
	-- at the end of each match, letting you quickly jump to a specific
	-- location.
	{
		--- Source ---
		'folke/flash.nvim',

		--- Setup ---
		opts = {},

		--- Lazy loading ---
		event = 'VeryLazy',
		keys = {
			{ 's', mode = { 'n', 'x', 'o' }, function() require('flash').jump() end, desc = "Flash" },
			{ 'S', mode = { 'n', 'o', 'x' }, function() require('flash').treesitter() end, desc = "Flash Treesitter" },
			{ 'r', mode = 'o', function() require('flash').remote() end, desc = "Remote Flash" },
			{ 'R', mode = { 'o', 'x' }, function() require('flash').treesitter_search() end, desc = "Treesitter Search" },
			{ '<c-s>', mode = { 'c' }, function() require('flash').toggle() end, desc = "Toggle Flash Search" },
			-- Simulate nvim-treesitter incremental selection
			{
				'<c-space>',
				mode = { 'n', 'o', 'x' },
				function()
					require('flash').treesitter({
						actions = {
							['<c-space>'] = 'next',
							['<BS>'] = 'prev',
						},
					})
				end,
				desc = "Treesitter Incremental Selection"
			},
		},
	},

	-- Search/replace in multiple files
	{
		--- Source ---
		'MagicDuck/grug-far.nvim',

		--- Setup ---
		opts = { headerMaxWidth = 80 },

		--- Lazy loading ---
		cmd = { 'GrugFar', 'GrugFarWithin' },
		keys = {
			{
				'<leader>sr',
				function()
					local grug = require('grug-far')
					local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
					grug.open({
						transient = true,
						prefills = {
							filesFilter = ext and ext ~= "" and "*." .. ext or nil,
						},
					})
				end,
				mode = { 'n', 'x' },
				desc = "Search and Replace",
			}
		},
	},

	-- Finds and lists all of the TODO, HACK, BUG, etc comment
	-- in your project and loads them into a browsable list.
	{
		--- Source ---
		'folke/todo-comments.nvim',

		--- Setup ---
		opts = {},

		--- Lazy loading ---
		event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
		cmd = { 'TodoTrouble', 'TodoTelescope' },
		keys = {
			{ ']t', function() require('todo-comments').jump_next() end, desc = "Next Todo Comment" },
			{ '[t', function() require('todo-comments').jump_prev() end, desc = "Previous Todo Comment" },
			{ "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "Todo (Trouble)" },
			{ "<leader>xT", "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
			{ "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
			{ "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
		},
	},

	-- Better diagnostics list and others
	{
		--- Source ---
		'folke/trouble.nvim',

		--- Setup ---
		opts = {
			modes = {
				lsp = {
					win = { position = 'right' },
				},
			},
		},

		--- Lazy loading ---
		cmd = { 'Trouble' },
		keys = {
			{ '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', desc = "Diagnostics (Trouble)" },
			{ '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = "Buffer Diagnostics (Trouble)" },
			{ '<leader>cs', '<cmd>Trouble symbols toggle<cr>', desc = "Symbols (Trouble)" },
			{ '<leader>cS', '<cmd>Trouble lsp toggle<cr>', desc = "LSP references/definitions/... (Trouble)" },
			{ '<leader>xL', '<cmd>Trouble loclist toggle<cr>', desc = "Location List (Trouble)" },
			{ '<leader>xQ', '<cmd>Trouble qflist toggle<cr>', desc = "Quickfix List (Trouble)" },
			{
				"[q",
				function()
					local trouble = require('trouble')

					if trouble.is_open() then
						trouble.prev({ skip_groups = true, jump = true })
					else
						local ok, err = pcall(vim.cmd.cprev)

						if not ok then
							vim.notify(err, vim.log.levels.ERROR)
						end
					end
				end,
				desc = "Previous Trouble/Quickfix Item",
			},
			{
				"]q",
				function()
					local trouble = require('trouble')

					if trouble.is_open() then
						trouble.next({ skip_groups = true, jump = true })
					else
						local ok, err = pcall(vim.cmd.cnext)

						if not ok then
							vim.notify(err, vim.loog.levels.ERROR)
						end
					end
				end,
				desc = "Next Trouble/Quickfix Item",
			},
		},
	},
}
