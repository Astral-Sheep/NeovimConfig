---@alias VimOptions { g: table<string, string|fun(table)>, opt: table<string, string|fun(table)> }
---@type VimOptions
return {
	g = {
		mapleader = " ",
		maplocalleader = " ",
		autoformat = false,          -- Disable autoformatting
		deprecation_warnings = true, -- Show deprecation warnings
	},
	opt = {
		autoindent = true,             -- Auto add indent when creating a new line
		autowrite = true,              -- Enable auto write
		clipboard = 'unnamedplus',     -- Copy pase between Neovim and everything else
		cmdheight = 1,                 -- Command line height
		conceallevel = 0,              -- Show conceal text normally (useful for markdown)
		cursorline = true,             -- Enable highlighting of the current line
		encoding = 'utf-8',            -- The encoding displayed
		expandtab = false,             -- Don't use spaces instead of tabs
		fileencoding = 'utf-8',        -- The encoding files are written in
		fillchars = function(vopt)     -- Remove `~` symbols when line numbers are displayed
			if vopt.number then
				vopt.fillchars:append({ eob = " " })
			end
		end,
		formatoptions = function(vopt) -- Stop newline continution of comments
			vopt.formatoptions:remove('cro')
		end,
		hidden = true,                 -- Required to keep multiple buffers open
		laststatus = 2,                -- Always display the status line
		linebreak = true,              -- Wrap lines at convenient points
		list = true,                   -- Show some invisible characters (tabs...)
		mouse = 'a',                   -- Enable mouse mode
		mousehide = true,              -- Hide the mouse when writting
		mousemodel = 'extend',         -- Allow right click to extend a selection
		number = true,                 -- Print line number
		pumheight = 10,                -- Make popup menu smaller
		relativenumber = true,         -- Relative line numbers
		ruler = true,                  -- Enable the default ruler
		scrolloff = 4,                 -- Lines of context above and below the cursor
		shiftround = true,             -- Round indent
		shiftwidth = 4,                -- Size of an indent
		showtabline = 1,               -- Show tab line if there are more than one buffer
		showmode = false,              -- Don't show mode since lualine is added
		sidescrolloff = 2,             -- Columns of context around the cursor
		signcolumn = 'yes',            -- Always show the signcolumn, otherwise it would shift the text each time it is modified
		smartcase = false,             -- Ignore case with capitcals
		smartindent = true,            -- Insert indents automatically
		smarttab = true,               -- Indent by shiftwidth
		spelllang = { 'en', 'fr' },
		splitbelow = true,             -- Put new windows below current
		splitkeep = 'screen',          -- Keep the text on the same screen line when opening, closing or resizing a window
		splitright = true,             -- Put new windows right of current
		tabstop = 4,                   -- Number of spaces tabs count for
		termguicolors = true,          -- True color support
		undofile = true,               -- Allow undoing modifications after closing and reopening a file
		undolevels = 10000,            -- Maximum number of modifications remembered
		updatetime = 200,              -- Save swap file is triggered after 200ms of inactivity
		virtualedit = 'block',         -- Allow cursor to move where there is no text in visual block mode
		winminwidth = 10,              -- Minimum window width
		wrap = true,                   -- Enable line wrap
	},
}

-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- local g = vim.g

-- g.mapleader = " "
-- g.maplocalleader = " "

-- g.autoformat = false          -- Disable autoformatting
-- g.deprecation_warnings = true -- Show deprecation warnings

-- local opt = vim.opt

-- opt.autoindent = true           -- Auto add indent when creating a new line
-- opt.autowrite = true            -- Enable auto write
-- opt.clipboard = 'unnamedplus'   -- Copy paste between NeoVim and everything else
-- opt.cmdheight = 2               -- Command line height (2 allows for more space to display messages)
-- opt.conceallevel = 0            -- Show conceal text normally (useful for markdown)
-- opt.cursorline = true           -- Enable highlighting of the current line
-- opt.encoding = 'utf-8'          -- The encoding displayed
-- opt.expandtab = false           -- Don't use spaces instead of tabs
-- opt.fileencoding = 'utf-8'      -- The encoding files are written in
-- opt.formatoptions:remove('cro') -- Stop newline continution of comments
-- opt.hidden = true               -- Required to keep multiple buffers open
-- opt.laststatus = 2              -- Always display the status line
-- opt.linebreak = true            -- Wrap lines at convenient points
-- opt.list = true                 -- Show some invisible characters (tabs...)
-- opt.mouse = 'a'                 -- Enable mouse mode
-- opt.mousehide = true            -- Hide the mouse when writting
-- opt.mousemodel = 'extend'       -- Allow right click to extend a selection
-- opt.number = true               -- Print line number
-- opt.pumheight = 10              -- Make popup menu smaller
-- opt.relativenumber = true       -- Relative line numbers
-- opt.ruler = true                -- Enable the default ruler
-- opt.scrolloff = 4               -- Lines of context above and below the cursor
-- opt.shiftround = true           -- Round indent
-- opt.shiftwidth = 4              -- Size of an indent
-- opt.showtabline = 1             -- Show tabs if there are more than one buffer
-- opt.showmode = false            -- Don't show mode since lualine is added
-- opt.sidescrolloff = 4           -- Columns of context around the cursor
-- opt.signcolumn = 'yes'          -- Always show the signcolumn, otherwise it would shift the text each time
-- opt.smartcase = false           -- Ignore case with capitals
-- opt.smartindent = true          -- Insert indents automatically
-- opt.smarttab = true             -- Indent by shiftwidth
-- opt.spelllang = { 'en', 'fr' }
-- opt.splitbelow = true           -- Put new windows below current
-- opt.splitkeep = 'screen'        -- Keep the text on the same screen line when opening, closing or resizing a window
-- opt.splitright = true           -- Put new windows right of current
-- opt.tabstop = 4                 -- Number of spaces tabs count for
-- opt.termguicolors = true        -- True color support
-- opt.undofile = true             -- Allows undoing modifications after closing and reopening a file
-- opt.undolevels = 10000          -- Maximum number of modification remembered
-- opt.updatetime = 200            -- Save swap file is triggered after 200ms of inactivity
-- opt.virtualedit = 'block'       -- Allow cursor to move where there is no text in visual block mode
-- opt.winminwidth = 10            -- Minimum window width
-- opt.wrap = true                 -- Enable line wrap

-- -- Remove `~` symbols when numbers are displayed
-- if opt.number then
-- 	opt.fillchars:append({ eob = " " })
-- end

-- vim.diagnostic.config({
-- 	update_in_insert = false,
-- 	severity_sort = true,
-- })
