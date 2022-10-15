call plug#begin('~/AppData/Local/nvim/autoload/plugged')
	Plug 'https://github.com/jiangmiao/auto-pairs.git'
	"Plug 'https://github.com/joshdick/onedark.vim.git'
	Plug 'https://github.com/morhetz/gruvbox.git'
	Plug 'https://github.com/vim-airline/vim-airline.git'
	Plug 'https://github.com/vim-airline/vim-airline-themes.git'
	Plug 'https://github.com/neoclide/coc.nvim.git', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
	Plug 'https://github.com/junegunn/fzf.git', { 'do': { -> fzf#install() } }
	Plug 'https://github.com/junegunn/fzf.vim.git'
	Plug 'https://github.com/airblade/vim-rooter.git'
	Plug 'https://github.com/mhinz/vim-startify.git'
	Plug 'https://github.com/mhinz/vim-signify.git'
call plug#end()
