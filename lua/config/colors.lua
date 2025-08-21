local api = vim.api
local cmd = vim.cmd
local opt = vim.opt

local themes = {
	Kanagawa = {
		dark = 'wave',
		light = 'lotus',
	},
	Gruvbox = {},
	Onedark = {},
	Nord = {},
	Catppuccin = {},
	Mellifluous = {},
	Miasma = {},
	Neofusion = {},
}

local modes = { 'dark', 'light' }

local file_themes = {
	c = 'Gruvbox',
	cpp = 'Gruvbox',
	tpp = 'Gruvbox',
	cmake = 'Gruvbox',
	cs = 'Onedark',
	rust = 'Nord',
	lua = 'Kanagawa',
	py = 'Kanagawa'
}

-- Return the filetype of the current buffer
local function get_filetype()
	return vim.filetype.match({ filename = api.nvim_buf_get_name(0) })
end

local function get_file_theme(ft)
	if file_themes[ft] ~= nil then
		return file_themes[ft]
	else
		return vim.g.DEFAULT_THEME
	end
end

local function set_color_mode(mode)
	if mode == nil or mode == opt.background then
		return
	end

	vim.g.COLOR_MODE = mode
	opt.background = themes[vim.g.COLOR_MODE] or vim.g.COLOR_MODE
end

-- Set the colorscheme
local function set_theme(theme)
	if theme == nil then
		return
	end

	local ltheme = theme:lower()

	if ltheme ~= nil and ltheme ~= vim.g.colors_name then
		cmd('hi clear')
		cmd.colorscheme(ltheme)
	end

	set_color_mode(vim.g.COLOR_MODE)
end

-- Recover the filetype of the current buffer, and set the theme according to it
local function update_theme()
	local ft = get_filetype()

	if ft == nil or ft == "" then
		return
	end

	set_theme(get_file_theme(ft))
end

local function set_default_theme(name)
	if name == vim.g.DEFAULT_THEME then
		return
	end

	local last = vim.g.DEFAULT_THEME
	vim.g.DEFAULT_THEME = name or vim.g.DEFAULT_THEME

	if last == vim.g.DEFAULT_THEME then
		return
	end

	if (themes[vim.g.DEFAULT_THEME] == nil) then
		set_theme(vim.g.DEFAULT_THEME)
	end

	print("Default theme set to " .. name)
end

local function init()
	if vim.g.DEFAULT_THEME == nil then
		print("Default theme set to Kanagawa")
		vim.g.DEFAULT_THEME = 'Kanagawa'
	end

	if vim.g.COLOR_MODE == nil then
		print("Default color mode set to dark")
		vim.g.COLOR_MODE = 'dark'
	end

	-- Set theme on nvim start
	local scheme = vim.g.DEFAULT_THEME
	local bg = vim.g.COLOR_MODE
	local ft = get_filetype()

	if file_themes[ft] ~= nil then
		scheme = file_themes[ft]
		bg = file_themes[ft][vim.g.COLOR_MODE] or vim.g.COLOR_MODE
	end

	opt.termguicolors = true
	cmd.colorscheme(scheme:lower())
	opt.background = bg

	-- Add autocmd to update theme on filetype changed
	api.nvim_create_autocmd({ 'FileType', 'BufWinEnter', 'BufEnter' }, {
		nested = true,
		callback = update_theme,
	})

	-- User commands to change theme manually
	for name, _ in pairs(themes) do
		api.nvim_create_user_command(name, function()
			set_theme(name)
		end, {})
	end

	-- User command to set the default theme
	api.nvim_create_user_command(
		'SetDefaultTheme',
		function(opts)
			set_default_theme(opts.fargs[1])
		end,
		{
			nargs = 1,
			complete = function(arglead, _, _)
				local potential_args = {}

				for k, _ in pairs(themes) do
					if #k >= #arglead and string.lower(string.sub(k, 1, #arglead)) == string.lower(arglead) then
						potential_args[#potential_args + 1] = k
					end
				end

				return potential_args
			end,
		}
	)

	-- User command to set the color mode
	api.nvim_create_user_command(
		'SetColorMode',
		function(opts)
			set_color_mode(opts.fargs[1])
		end,
		{
			nargs = 1,
			complete = function(arglead, _, _)
				local potential_args = {}

				for _, m in pairs(modes) do
					if #m >= #arglead and string.lower(string.sub(m, 1, #arglead)) == string.lower(arglead) then
						potential_args[#potential_args + 1] = m
					end
				end

				return potential_args
			end,
		}
	)
end

-- Call init only when shada files are loaded
api.nvim_create_autocmd('VimEnter', {
	nested = true,
	callback = init,
})
