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

	-- Theme & Syntax highlighting
	use 'morhetz/gruvbox'
	use 'joshdick/onedark.vim'
	use 'scottmckendry/cyberdream.nvim'
	use 'rebelot/kanagawa.nvim'
	use 'nvim-treesitter/nvim-treesitter'
	use {
		'folke/todo-comments.nvim',
		requires = { 'nvim-lua/plenary.nvim' }
	}

	-- File explorer
	use 'nvim-tree/nvim-tree.lua'
	use {
		'nvim-tree/nvim-web-devicons',
	}
	use {
		'nvim-telescope/telescope.nvim',
		branch = '0.1.x',
		requires = { 'nvim-lua/plenary.nvim' }
	}
	use 'stevearc/aerial.nvim'

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
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
		}
	}

	-- Debugging
	use {
		'mfussenegger/nvim-dap',
		requires = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
		}
	}

	-- File specific
	use {
		'iamcco/markdown-preview.nvim',
		run = function() vim.fn["mkdp#util#install"]() end,
	} 									-- Markdown preview

	-- Miscellaneous
	use 'windwp/nvim-autopairs' 		-- Autocompletion for parenthesis, brackets...
	use 'airblade/vim-rooter' 			-- Set root directory of opened project
	use 'mhinz/vim-startify'			-- Start screen
	use 'mhinz/vim-signify'				-- Show modified lined in file managed by a version control system (VCS)
	use 'tpope/vim-surround'			-- Easy replacement of parentheses, brackets, quotes, ect by another surrounding pair of characters
	use 'tpope/vim-commentary'			-- Comment code easily
	use 'tpope/vim-fugitive'			-- Git commands
	use 'ntpeters/vim-better-whitespace'-- Highlight trailing whitespaces
	use 'easymotion/vim-easymotion'		-- Motion bindings improvements

	-- Automatically set up your configuration after cloning packer.nvim
	if packer_bootstrap then
		require('packer').sync()
	end
end)
