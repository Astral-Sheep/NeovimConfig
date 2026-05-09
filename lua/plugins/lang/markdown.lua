Config.on_very_lazy(function()
	vim.filetype.add({
		extension = { mdx = "markdown.mdx" },
	})
end)

return {
	{
		--- Source ---
		'nvim-treesitter/nvim-treesitter',

		--- Setup ---
		opts = { ensure_installed = { 'markdown', 'markdown_inline' } },
	},

	{
		--- Source ---
		'mason-org/mason.nvim',

		--- Setup ---
		opts = { ensure_installed = { 'marksman', 'markdown-toc' } }
	},

	{
		--- Source ---
		'neovim/nvim-lspconfig',

		--- Setup ---
		opts = {
			servers = {
				marksman = {},
			},
		},
	},

	{
		--- Source --
		'MeanderingProgrammer/render-markdown.nvim',

		--- Setup ---
		opts = {
			code = {
				sign = false,
				width = 'block',
				right_pad = 1,
			},
			heading = {
				sign = false,
				icons = {},
			},
			checkbox = {
				enabled = false,
			},
		},
		config = function(_, opts)
			require('render-markdown').setup(opts)
			Snacks.toggle({
				name = "Render Markdown",
				get = require('render-markdown').get,
				set = require('render-markdown').set,
			}):map('<leader>um')
		end,

		--- Lazy loading ---
		ft = { 'markdown', 'norg', 'rmd', 'org', 'codecompanion' },
	}
}
