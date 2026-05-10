---@alias VimOptions { g: table, opt: table }
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
		list = false,                  -- Show some invisible characters (tabs...)
		mouse = 'a',                   -- Enable mouse mode
		mousehide = true,              -- Hide the mouse when writting
		mousemodel = 'extend',         -- Allow right click to extend a selection
		number = true,                 -- Print line number
		pumheight = 10,                -- Make popup menu smaller
		relativenumber = true,         -- Relative line numbers
		ruler = true,                  -- Enable the default ruler
		scrolloff = 2,                 -- Lines of context above and below the cursor
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
 	-- Specify here which language specific plugins are loaded
	-- true or nil -> all languages are supported
	-- false -> no language
	-- { include = {} } -> only languages in this list are supported
	-- { exclude = {} } -> all languages except the ones in this list are supported
	---@type boolean | { include?: string|string[], exclude?: string|string[] } | nil
	language_support = true,
	load_misc_plugins = true,
	change_colorscheme_per_filetype = true,
}
