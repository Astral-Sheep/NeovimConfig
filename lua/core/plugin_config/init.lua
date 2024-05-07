-- Highlighting
require('core.plugin_config.color_theme')
require('core.plugin_config.nvim-treesitter')
-- Intellisense & Autocompletion
require('nvim-autopairs').setup {}
require('core.plugin_config.nvim-lspconfig')
require('core.plugin_config.nvim-cmp')
-- Status lines
require('core.plugin_config.lualine')
require('core.plugin_config.bufferline')
-- File Explorer
require('core.plugin_config.nvim-tree')
require('core.plugin_config.telescope')
require('core.plugin_config.vim-rooter')
require('core.plugin_config.nvim-web_devicons')
-- Misc
require('core.plugin_config.vim-startify')
require('core.plugin_config.aerial')
require('core.plugin_config.markdown-preview')

local api = vim.api

api.nvim_create_autocmd({ 'FileType', 'BufWinEnter' }, {
	nested = true,
	callback = UpdateTheme
})

api.nvim_create_autocmd('ColorScheme', {
	callback = function()
		RefreshTreesitter()
		RefreshLualine()
	end
})

