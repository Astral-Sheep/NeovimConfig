vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local set = vim.opt

set.hidden=true								-- Required to keep multiple buffers open
set.wrap=true								-- Display long lines as just one line
set.encoding="utf-8"						-- The encoding displayed
set.pumheight=10							-- Makes popup menu smaller
set.fileencoding="utf-8"					-- The encoding written to file
set.cmdheight=2								-- More space for displaying messages
set.iskeyword:append("-")					-- Treat dash seperated words as a word text object
set.mouse="a"								-- Enable the mouse
set.mousehide=false							-- Don't hide the mouse when writing
set.mousemodel="popup"						-- Allow right click to create popup
set.mouseshape="n:arrow,v:arrow,i:beam"		-- Change mouse type
set.splitbelow=true							-- Horizontal splits will automatically be below
set.splitright=true							-- Vertical splits will automatically be to the right
vim.cmd [[ set t_Co=256 ]]					-- Support 256 colors
set.conceallevel=0							-- So that I can see `` in markdown files
set.shiftwidth=4							-- Change the number of space characters inserted for indentation
set.smarttab=true							-- Makes tabbing smarter will realize you have 2 vs 4
set.smartindent=true						-- Makes indenting smart
set.autoindent=true							-- Good auto indent
set.expandtab=false							-- Avoid replacing tabs with spaces
set.tabstop=4								-- Change the size of a tab character to x spaces
set.laststatus=0							-- Always display the status line
set.number=true								-- Line numbers
set.cursorline=true							-- Enable highlighting of the current line

-- Disable ~ symbols if number is set to true
if set.number then
	set.fillchars:append({ eob = " " })
end

set.showtabline=2							-- Always show tabs
set.showmode=false							-- We don't need to see things like -- INSERT -- anymore
set.updatetime=300							-- Faster completion
set.timeoutlen=500							-- By default timeoutlen is 1000 ms
set.formatoptions:remove("cro")				-- Stop newline continution of comments
set.clipboard="unnamedplus"					-- Copy paste between NeoVim and everything else

vim.diagnostic.config({
	update_in_insert = false,
	severity_sort = true,
})

vim.cmd [[
	source $VIMRUNTIME/mswin.vim

	au! BufWritePost $MYVIMRC source %
	let g:netrw_fastbrowse = 0
]]											-- Auto source when writing to init.vim alternatively you can run :source $MYVIMRC
