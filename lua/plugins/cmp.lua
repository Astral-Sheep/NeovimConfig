return {
	{
		--- Source ---
		'saghen/blink.cmp',

		--- Versioning ---
		version = "1.*",
	},

	-- Setup nvim-cmp
	{
		--- Source ---
		'hrsh7th/nvim-cmp',

		--- Loading ---
		dependencies = {
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
		},

		--- Setup ---
		opts = function()
			vim.lsp.config("*", { capabilities = require('cmp_nvim_lsp').default_capabilities() })

			vim.api.nvim_set_hl(0, 'CmpGhostText', { link = 'Comment', default = true })
			local cmp = require('cmp')
			local defaults = require('cmp.config.default')()
			local auto_select = true

			return {
				auto_brackets = {}, -- Configure any filetype to auto add brackets
				completion = {
					completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
				},
				preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,
				mapping = cmp.mapping.preset.insert({
					['<C-b>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = Config.cmp.confirm({ select = auto_select }),
					["<C-y>"] = Config.cmp.confirm({ select = true }),
					["<S-CR>"] = Config.cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
					["<C-CR>"] = function(fallback)
						cmp.abort()
						fallback()
					end,
					["<tab>"] = function(fallback)
						return Config.cmp.map({ "snippet_forward", "ai_nes", "ai_accept" }, fallback)()
					end,
				}),
				sources = cmp.config.sources({
					{ name = "lazydev" },
					{ name = "nvim_lsp" },
					{ name = "path" },
				}, {
					{ name = "buffer" },
				}),
				formatting = {
					format = function(entry, item)
						local icons = Config.defaults.icons.kinds

						if icons[item.kind] then
							item.kind = icons[item.kind] .. item.kind
						end

						local widths = {
							abbr = vim.g.cmp_widths and vim.g.cmp_widths.abbr or 40,
							menu = vim.g.cmp_widths and vim.g.cmp_widths.menu or 30
						}

						for key, width in pairs(widths) do
							if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
								item[key] = vim.fn.strcharpart(item[key], 0, width - 1) .. "…"
							end
						end

						return item
					end,
				},
				experimental = {
					ghost_text = false
				},
				sorting = defaults.sorting,
			}
		end,
		main = 'core.cmp',

		--- Lazy loading ---
		event = 'InsertEnter',

		--- Versioning ---
		version = false, -- last release is way too old
	},

	-- Snippets
	{
		--- Source ---
		'hrsh7th/nvim-cmp',

		--- Loading ---
		dependencies = {
			{
				--- Source ---
				'garymjr/nvim-snippets',

				--- Loading ---
				dependencies = { 'rafamadriz/friendly-snippets' },

				--- Setup ---
				opts = {
					friendly_snippets = true,
				},
			},
		},

		--- Setup ---
		opts = function(_, opts)
			opts.snippet = {
				expand = function(item)
					return Config.cmp.expand(item.body)
				end,
			}

			if Config.has('nvim-snippets') then
				table.insert(opts.sources, { name = 'snippets' })
			end
		end,
	},
}
