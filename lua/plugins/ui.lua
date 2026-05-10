local function set_alpha_footer()
	local stats = require('lazy').stats()
	local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
	require('alpha.themes.dashboard').section.footer.val = "   Neovim loaded "
		.. stats.loaded
		.. "/"
		.. stats.count
		.. " plugins in "
		.. ms
		.. "ms"
	pcall(vim.cmd.AlphaRedraw)
end

return {
	{
		--- Source ---
		'akinsho/bufferline.nvim',

		--- Setup ---
		opts = {
			options = {
				close_command = function(n) Snacks.bufdelete(n) end,
				right_mouse_command = function(n) Snacks.bufdelete(n) end,
				left_mouse_command = 'buffer %d',
				middle_mouse_command = nil,
				diagnostics = 'nvim_lsp',
				always_show_bufferline = false,
				diagnostics_indicator = function(_, _, diag)
					local icons = Config.defaults.icons.diagnostics
					local ret = (diag.error and icons.error .. diag.error .. " " or "")
						.. (diag.warning and icons.warn .. diag.warning or "")
					return vim.trim(ret)
				end,
				offset = {
					{
						filetype = 'neo-tree',
						text = 'Neo-tree',
						highlight = 'Directory',
						text_align = 'left',
					},
					{
						filetype = 'snacks_layout_box',
					},
				},
				---@param opts bufferline.IconFetcherOpts
				get_element_icon = function(opts)
					return Config.defaults.icons.ft[opts.filetype]
				end,
				color_icons = true,
				show_buffer_icons = true,
				show_buffer_close_icons = true,
				show_close_icon = false,
				show_tab_indicators = true,
				show_duplicate_prefix = true,
				persist_buffer_sort = false,
				separator_style = 'thick',
				enforce_regular_tabs = false,
				hover = {
					enabled = true,
					delay = 200,
					reveal = { 'close' },
				},
				sort_by = 'insert_at_end',
			}
		},
		config = function(_, opts)
			require('bufferline').setup(opts)
			-- Fix bufferline when restoring a session
			vim.api.nvim_create_autocmd({ 'BufAdd', 'BufDelete' }, {
				callback = function()
					vim.schedule(function()
						pcall(nvim_bufferline)
					end)
				end,
			})
		end,

		--- Lazy loading ---
		event = 'VeryLazy',
		keys = {
			{ '<leader>bp', '<cmd>BufferLineTogglePin<cr>', desc = "Toggle Pin" },
			{ '<leader>bP', '<cmd>BufferLineGroupClose ungrouped<cr>', desc = "Delete Non-Pinned Buffers" },
			{ '<leader>br', '<cmd>BufferLineCloseRight<cr>', desc = "Delete Buffers to the Right" },
			{ '<leader>bl', '<cmd>BufferLineCloseLeft<cr>', desc = "Delete Buffers to the Left" },
			{ '<S-h>', '<cmd>BufferLineCyclePrev<cr>', desc = "Prev Buffer" },
			{ '<S-l>', '<cmd>BufferLineCycleNext<cr>', desc = "Next Buffer" },
			{ '[b', '<cmd>BufferLineCyclePrev<cr>', desc = "Prev Buffer" },
			{ ']b', '<cmd>BufferLineCycleNext<cr>', desc = "Next Buffer" },
			{ '[B', '<cmd>BufferLineMovePrev<cr>', desc = "Move Buffer Prev" },
			{ ']B', '<cmd>BufferLineMoveNext<cr>', desc = "Move Buffer Next" },
			{ '<leader>bj', '<cmd>BufferLinePick<cr>', desc = "Pick Buffer" },
		},
	},

	-- Displays a fancy status line with git status,
	-- LSP diagnostics, filetype information, and more.
	{
		--- Source ---
		'nvim-lualine/lualine.nvim',

		--- Setup ---
		init = function()
			vim.g.lualine_laststatus = vim.o.laststatus

			if vim.fn.argc(-1) > 0 then
				-- Set an empty statusline till lualine loads
				vim.o.statusline = " "
			else
				-- Hide the statusline on the starter page
				vim.o.laststatus = 0
			end
		end,
		opts = function()
			local lualine_require = require('lualine_require')
			lualine_require.require = require

			local icons = Config.defaults.icons
			vim.o.laststatus = vim.g.lualine_laststatus

			local opts = {
				options = {
					theme = 'auto',
					globalstatus = vim.o.laststatus == 3,
					disabled_filetypes = { statusline = {
						'dashboard',
						'alpha',
						'ministarter',
						'snacks_dashboard',
						'startify',
					} },
				},
				sections = {
					lualine_a = {
						{
							'mode',
							icons_enabled = true,
							draw_empty = true,
						},
					},
					lualine_b = {
						'branch',
					},
					lualine_c = {
						{
							'filename',
							file_status = true,
							newfile_status = true,
							path = 1,
						},
					},
					lualine_x = {
						'encoding',
						'fileformat',
						{
							'filetype',
							colored = true,
							icon_only = true,
						}
					},
					lualine_y = {
						Snacks.profiler.status(),
						{
							'diff',
							colored = true,
							symbols = {
								added = icons.git.added,
								modified = icons.git.modified,
								removed = icons.git.removed,
							},
							source = function()
								local gitsigns = vim.b.gitsigns_status_dict

								if gitsigns then
									return {
										added = gitsigns.added,
										modified = gitsigns.changed,
										removed = gitsigns.removed,
									}
								end
							end,
						},
						{
							'diagnostics',
							-- sources = { 'nvim_lsp' },
							-- sections = { 'error', 'warn', 'hint', 'info' },
							symbols = { error = icons.diagnostics.error, warn = icons.diagnostics.warn, hint = icons.diagnostics.hint, info = icons.diagnostics.info },
							colored = true,
							update_in_insert = false,
							always_visible = true,
						},
					},
					lualine_z = {
						function()
							return " " .. os.date('%R')
						end,
						'location',
						'progress',
					},
				},
				extensions = { 'neo-tree', 'lazy', 'fzf' },
			}

			if vim.g.trouble_lualine and Config.has('trouble.nvim') then
				local trouble = require('trouble')
				local symbols = trouble.statusline({
					mode = 'symbols',
					groups = {},
					title = false,
					filter = { range = true },
					format = "{kind_icon}{symbol.name:Normal}",
					hl_group = 'lualine_c_normal',
				})
				table.insert(opts.sections.lualine_c, {
					symbols and symbols.get,
					cond = function()
						return vim.b.trouble_lualine ~= false and symbols.has()
					end,
				})
			end

			return opts
		end,

		--- Lazy loading ---
		event = 'VeryLazy',
	},

	-- Icons
	{
		--- Source ---
		'nvim-mini/mini.icons',

		--- Setup ---
		init = function()
			package.preload['nvim-web-devicons'] = function()
				require('mini.icons').mock_nvim_web_devicons()
				return package.loaded['nvim-web-devicons']
			end
		end,
		opts = {
			file = {
				[".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
				["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
			},
			filetype = {
				dotenv = { glyph = "", hl = "MiniIconsYellow" },
			},
		},

		--- Lazy loading ---
		lazy = true,
	},

	-- UI components
	{
		--- Source ---
		'MunifTanjim/nui.nvim',

		--- Lazy loading ---
		lazy = true,
	},

	{
		--- Source ---
		'snacks.nvim',

		--- Setup ---
		opts = {
			dashboard = { enabled = false },
			indent = { enabled = true },
			input = { enabled = true },
			notifier = { enabled = true },
			scope = { enabled = true },
			scroll = { enabled = true },
			statuscolumn = { enabled = false }, -- We set this in config.options.lua
			words = { enabled = true },
		},

		--- Lazy loading ---
		keys = {
			{
				'<leader>n',
				function()
					if Snacks.config.picker and Snacks.config.picker.enabled then
						Snacks.picker.notifications()
					else
						Snacks.notifier.show_history()
					end
				end,
				desc = "Notification History",
			},
			{
				'<leader>un',
				function()
					Snacks.notifier.hide()
				end,
				desc = "Dismiss All Notifications",
			}
		},
	},

	-- Dashboard. This runs when Neovim starts, and is what displays
	-- the banner
	{
		--- Source ---
		'Astral-Sheep/alpha-nvim',

		--- Loading ---
		enabled = true,

		--- Setup ---
		init = false,
		opts = function()
			local dashboard = require('alpha.themes.dashboard')
-- 			local logo = [[
-- ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗
-- ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║
-- ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║
-- ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║
-- ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝
-- 			]]

 -- 		local logo = [[
 --                                              
 --       ████ ██████           █████      ██
 --      ███████████             █████ 
 --      █████████ ███████████████████ ███   ███████████
 --     █████████  ███    █████████████ █████ ██████████████
 --    █████████ ██████████ █████████ █████ █████ ████ █████
 --  ███████████ ███    ███ █████████ █████ █████ ████ █████
 -- ██████  █████████████████████ ████ █████ █████ ████ ██████
 --
 -- ——————————————————————————————————————————————————————————————————————
 -- 		]]

-- 			local logo = [[
-- ███╗░░██╗██╗░░░██╗██╗███╗░░░███╗
-- ████╗░██║██║░░░██║██║████╗░████║
-- ██╔██╗██║╚██╗░██╔╝██║██╔████╔██║
-- ██║╚████║░╚████╔╝░██║██║╚██╔╝██║
-- ██║░╚███║░░╚██╔╝░░██║██║░╚═╝░██║
-- ╚═╝░░╚══╝░░░╚═╝░░░╚═╝╚═╝░░░░░╚═╝
-- 			]]

			local logo = [[

   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣭⣿⣶⣿⣦⣼⣆
    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦
          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷⠄⠄⠄⠄⠻⠿⢿⣿⣧⣄
           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄
          ⢠⣿⣿⣿⠈  ⠡⠌⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀
   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘⠄ ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄
  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄
 ⣠⣿⠿⠛⠄⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄
 ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇⠄⠛⠻⢷⣄
      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆
       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃
			]]
-- "     ⢰⣶  ⣶ ⢶⣆⢀⣶⠂⣶⡶⠶⣦⡄⢰⣶⠶⢶⣦  ⣴⣶     ",
-- "     ⢸⣿⠶⠶⣿ ⠈⢻⣿⠁ ⣿⡇ ⢸⣿⢸⣿⢶⣾⠏ ⣸⣟⣹⣧    ",
-- "     ⠸⠿  ⠿  ⠸⠿  ⠿⠷⠶⠿⠃⠸⠿⠄⠙⠷⠤⠿⠉⠉⠿⠆   ",
			-- ]]

			---@param text string
			---@param line_width integer
			---@return string
			local function center_text(text, line_width)
				local total_padding = line_width - #text
				local left_padding = math.floor(total_padding / 2)
				local right_padding = total_padding - left_padding
				return string.rep(" ", left_padding) .. text .. string.rep(" ", right_padding)
			end
			local DASHBOARD_WIDTH = 35

			dashboard.set_width(DASHBOARD_WIDTH)

			local v = vim.version()
			local header = vim.split(logo, "\n")
			header[#header + 1] = center_text(" v" .. v.major .. "." .. v.minor .. "." .. v.patch, DASHBOARD_WIDTH)
			dashboard.section.header.val = header

			dashboard.section.buttons.val = {
				dashboard.button('n', Config.defaults.icons.dashboard.new_file .. " New File", [[<cmd>ene <BAR> startinsert<cr>]]),
				dashboard.button('s', Config.defaults.icons.dashboard.restore_session .. " Restore Session", [[<cmd>lua require('persistence').load()<cr>]]),
				dashboard.button('r', Config.defaults.icons.dashboard.recent_files .. " Recent files", [[<cmd>lua Config.pick('oldfiles')()<cr>]]),
				dashboard.button('f', Config.defaults.icons.dashboard.find_file .. " Find file", [[<cmd>lua Config.pick()()<cr>]]),
				dashboard.button('t', Config.defaults.icons.dashboard.find_text .. " Find text", [[<cmd>lua Config.pick('live_grep')()<cr>]]),
				dashboard.button('c', Config.defaults.icons.dashboard.configuration .. " Config", [[<cmd>lua Config.pick.config_files()()<cr> ]]),
				dashboard.button('l', Config.defaults.icons.dashboard.lazy .. " Lazy", '<cmd>Lazy<cr>'),
				dashboard.button('q', Config.defaults.icons.dashboard.quit .. " Quit", '<cmd>qa<cr>'),
			}

			for _, button in ipairs(dashboard.section.buttons.val) do
				button.opts.hl = "AlphaButtons"
				button.opts.hl_shortcut = "AlphaShortcut"
			end

			dashboard.section.header.opts.hl = "AlphaHeader"
			dashboard.section.buttons.opts.hl = "AlphaButtons"
			dashboard.section.footer.opts.hl = "AlphaFooter"
			dashboard.opts.layout[1].val = 8
			return dashboard
		end,
		config = function(_, dashboard)
			-- Close Lazy and re-open when the dashboard is ready
			if vim.o.filetype == 'lazy' then
				vim.cmd.close()
				vim.api.nvim_create_autocmd('User', {
					once = true,
					pattern = "AlphaReady",
					callback = function()
						require('lazy').show()
					end,
				})
			end

			require('alpha').setup(dashboard.opts)
			vim.cmd('autocmd FileType alpha setlocal nofoldenable')

			vim.keymap.set('n', 'go', ':%bd<BAR>Alpha<BAR>bd#<CR>', {
				silent = true,
				desc = "Close all buffers and open Alpha",
			})

			vim.api.nvim_create_autocmd('User', {
				once = true,
				pattern = 'LazyVimStarted',
				callback = function()
					set_alpha_footer()

					vim.api.nvim_create_autocmd('User', {
						pattern = 'AlphaReady',
						callback = set_alpha_footer,
					})
				end,
			})

			vim.api.nvim_create_autocmd('User', {
				pattern = 'BDeletePre *',
				callback = function()
					local bufnr = vim.api.nvim_get_current_buf()
					local name = vim.api.nvim_buf_get_name(bufnr)

					if name == "" then
						vim.cmd(':Alpha | bd#')
					end
				end,
			})
		end,

		--- Lazy loading ---
		event = 'VimEnter',
	},
}
