return {
	--- Source ---
	'hrsh7th/nvim-cmp',

	--- Loading ---
	dependencies = {
		'hrsh7th/vim-vsnip',
		'hrsh7th/cmp-nvim-lsp',
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-path',
	},

	--- Setup ---
	config = function()
		local cmp = require('cmp')
		cmp.setup({
			snippet = {
				-- REQUIRED - you must specify a snippet engine
				expand = function(args)
					vim.fn['vsnip#anonymous'](args.body)
				end,
			},
			window = {
				-- completion = cmp.config.window.bordered(),
				-- documentation = cmp.config.window.bordered(),
			},
			mapping = cmp.mapping.preset.insert({
				['<C-Space>'] = cmp.mapping.complete(),
				['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
			}),
			sources = cmp.config.sources({
				{ name = 'nvim-lsp' },
				{ name = 'vsnip' },
				{ name = 'buffer' },
				{ name = 'path' },
			}),
		})
	end,

	--- Lazy Loading ---
	lazy = true,
	event = 'BufRead',
}
