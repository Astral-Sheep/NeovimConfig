local function check_lsp()
	local non_lsp_ft = {
		'',
		'lspinfo',
		'packer',
		'checkhealth',
		'help',
		'man',
		'gitcommit',
		'startify',
		'alpha',
		'TelescopePrompt',
		'TelescopeResults',
	}

	for _, ft in pairs(non_lsp_ft) do
		print(ft)
		if ft == vim.bo.filetype then
			return false
		end
	end

	return true
end

local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

	if fn.empty(fn.glob(install_path)) > 0
	then
		vim.notify("Bootstrapping packer.nvim, please wait...")
		fn.system({
			'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
			install_path
		})
		vim.cmd('packadd packer.nvim')
		return true
	end

	return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup({ function(use)
	-----------------------
	--- Package Manager ---
	-----------------------

	use ('wbthomason/packer.nvim')

	-------------------------
	--- Utilitary Plugins ---
	-------------------------

	use('nvim-lua/plenary.nvim') -- Useful lua functions for neovim

	--------------------
	--- Color Themes and Icons ---
	--------------------

	use('rebelot/kanagawa.nvim')
	use({'morhetz/gruvbox', opt = false})
	use({'joshdick/onedark.vim', opt = false})

	use({ -- Web devicons
		'nvim-tree/nvim-web-devicons',
		config = function()
			require('core.plugin_config.nvim-web-devicons')
		end,
	})

	-------------------
	--- Status Line ---
	-------------------

	use({ -- Neovim status line
		'nvim-lualine/lualine.nvim',
		after = 'kanagawa.nvim',
		config = function()
			require('core.plugin_config.lualine')
		end,
	})

	use({ -- Buffer status line
		'akinsho/bufferline.nvim',
		after = 'kanagawa.nvim',
		config = function()
			require('core.plugin_config.bufferline')
		end,
	})

	---------------------------
	--- Syntax Highlighting ---
	---------------------------

	use({ -- Better syntax highlighting
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate',
		config = function()
			require('core.plugin_config.nvim-treesitter')
		end,
	})

	use({ -- Highlight of specific comments like TODO, FIX...
		'folke/todo-comments.nvim',
		requires = 'nvim-lua/plenary.nvim',
		config = function()
			require('core.plugin_config.todo-comments')
		end,
	})

	-----------------------------
	--- Navigation and Fuzzy Search ---
	-----------------------------

	use({ -- File explorer
		'nvim-tree/nvim-tree.lua',
		config = function()
			require('core.plugin_config.nvim-tree')
		end,
	})

	use({ -- Fuzzy finder
		'nvim-telescope/telescope.nvim',
		branch = '0.1.x',
		requires = 'nvim-lua/plenary.nvim',
		config = function()
			require('core.plugin_config.telescope')
		end,
	})

	use({ -- Code outlining
		'stevearc/aerial.nvim',
		event = 'BufRead',
		config = function()
			require('core.plugin_config.aerial')
		end,
	})

	------------------------------------------------
	--- LSP, Autocompletion and Code Formatting ---
	------------------------------------------------

	use({ -- LSP (Language Server Protocol)
		{
			'williamboman/mason.nvim',
			opt = false,
		},
		{
			'williamboman/mason-lspconfig.nvim',
			opt = false,
		},
		{
			'neovim/nvim-lspconfig',
			opt = false,
			cond = nil,
			requires = { 'mason.nvim', 'mason-lspconfig.nvim', 'nvim-cmp' },
			-- module = { 'mason.nvim', 'mason-lspconfig.nvim', 'nvim-cmp' },
			config = function()
				require('core.plugin_config.nvim-lspconfig')
			end,
		}
	})

	use({ -- Autocompletion
		'hrsh7th/nvim-cmp',
		opt = false,
		cond = nil,
		requires = {
			'hrsh7th/vim-vsnip',
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
		},
		config = function()
			require('core.plugin_config.nvim-cmp')
		end,
	})

	use({ -- Autocompletion for parenthesis, brackets...
		'windwp/nvim-autopairs',
		event = 'InsertCharPre',
		config = function()
			require('nvim-autopairs').setup()
		end,
	})

	use({ -- Indentation lines
		'lukas-reineke/indent-blankline.nvim',
		event = 'BufRead',
		config = function()
			require('core.plugin_config.ibl')
		end,
	})

	use({ -- Easy replacement of parentheses, brackets, quotes, ect by another surrounding pair of characters
		'tpope/vim-surround',
		event = 'BufRead',
	})

	use({ -- Comment code easily
		'tpope/vim-commentary',
		event = 'BufRead',
	})

	use({ -- Highlight trailing whitespaces
		'ntpeters/vim-better-whitespace',
		event = 'BufRead',
	})

	-----------------
	--- Debugging ---
	-----------------

	use({ -- Debugger
		'mfussenegger/nvim-dap',
		opt = true,
		ft = { 'c', 'cpp' },
		requires = {
			'rcarriga/nvim-dap-ui',
			'nvim-neotest/nvim-nio',
		},
		config = function()
			require('core.plugin_config.nvim-dap')
		end,
	})

	-----------------------
	--- Git Integration ---
	-----------------------

	use('tpope/vim-fugitive') -- Git commands

	use({ -- Show modified lines in file managed by a version control system (VCS)
		'mhinz/vim-signify',
		event = 'BufRead',
	})

	---------------------
	--- File Specific ---
	---------------------

	use({ -- Markdown preview
		'iamcco/markdown-preview.nvim',
		opt = true,
		ft = 'markdown',
		run = function() vim.fn["mkdp#util#install"]() end,
		config = function()
			require('core.plugin_config.markdown-preview')
		end,
	})

	---------------------
	--- Miscellaneous ---
	---------------------

	use('easymotion/vim-easymotion') -- Motion bindings improvements

	use({ -- Set root directory of opened project
		'airblade/vim-rooter',
		config = function()
			require('core.plugin_config.vim-rooter')
		end,
	})

	use({ -- Start screen
		'goolord/alpha-nvim',
		config = function()
			require('core.plugin_config.alpha-nvim')
		end,
	})

	use({ -- Discord rich presence
		'andweeb/presence.nvim',
		disable = false,
		config = function()
			require('core.plugin_config.presence')
		end,
	})

	-- Automatically set up your configuration after cloning packer.nvim
	if packer_bootstrap then
		require('packer').sync()
	end
end,
config = {
	display = {
		open_fn = function()
			return require('packer.util').float({ border = 'single' })
		end,
	},
}})
