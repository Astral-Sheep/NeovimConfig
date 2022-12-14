local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
		vim.cmd[[packadd packer.nvim]]
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
	-- Packer
	use 'wbthomason/packer.nvim'

	-- Syntax highlighting
	use 'morhetz/gruvbox'
	use 'nvim-treesitter/nvim-treesitter'

	-- File explorer
	use 'nvim-tree/nvim-tree.lua'
	use 'nvim-tree/nvim-web-devicons'
	use {
		'nvim-telescope/telescope.nvim',
		tag = '0.1.0',
		requires = { 'nvim-lua/plenary.nvim' }
	}

	-- Status line
	use 'nvim-lualine/lualine.nvim'
	use 'akinsho/bufferline.nvim'

	-- Language Server Protocol (LSP)
	use {
		'williamboman/mason.nvim',
		'williamboman/mason-lspconfig.nvim',
		'neovim/nvim-lspconfig',
	}
	use {
		'hrsh7th/nvim-cmp',
		requires = {
			'hrsh7th/vim-vsnip',
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-buffer'
		}
	}

	-- Miscellaneous
	use 'windwp/nvim-autopairs'
	use 'airblade/vim-rooter'
	use 'mhinz/vim-startify'
	use 'mhinz/vim-signify'
	use 'tpope/vim-surround'
	use 'tpope/vim-commentary'
	use 'tpope/vim-fugitive'
	use 'ntpeters/vim-better-whitespace'
	use 'easymotion/vim-easymotion'

	-- Automatically set up your configuration after cloning packer.nvim
	if packer_bootstrap then
		require('packer').sync()
	end
end)
