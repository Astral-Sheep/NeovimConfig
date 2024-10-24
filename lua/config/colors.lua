local api = vim.api
local cmd = vim.cmd
local opt = vim.opt

local themes = {
	Kanagawa =   { 'kanagawa', '' },
	Gruvbox =    { 'gruvbox', 'dark' },
	Onedark =    { 'onedark', 'dark' },
	Catppuccin = { 'catppuccin', 'dark' },
	Nord =       { 'nord', 'dark' },
}

local file_themes = {
	c = themes['Gruvbox'],
	cpp = themes['Gruvbox'],
	tpp = themes['Gruvbox'],
	cmake = themes['Gruvbox'],
	cs = themes['Onedark'],
	rust = themes['Onedark'],
}

local background

-- Return the filetype of the current buffer
local function get_filetype()
	return vim.filetype.match({ filename = api.nvim_buf_get_name(0) })
end

local function get_file_theme(ft)
	if file_themes[ft] ~= nil then
		return file_themes[ft]
	else
		return themes['Default']
	end
end

-- Set the colorscheme
local function set_theme(theme)
	if theme == nil then
		return
	end

	if theme[1] ~= nil and theme[1] ~= vim.g.colors_name then
		cmd('hi clear')
		cmd.colorscheme(theme[1])
	end

	if theme[2] ~= nil and theme[2] ~= background then
		opt.background = theme[2]
		background = theme[2]
	end
end

-- Recover the filetype of the current buffer, and set the theme according to it
local function update_theme()
	local ft = get_filetype()

	if ft == nil or ft == "" then
		return
	end

	local color_scheme = get_file_theme(ft)
	set_theme(color_scheme)
end

local function set_default(name)
	local last = vim.g.DEFAULT_THEME[1]
	vim.g.DEFAULT_THEME = themes[name] or vim.g.DEFAULT_THEME

	if (last ~= vim.g.DEFAULT_THEME[1]) then
		themes['Default'] = vim.g.DEFAULT_THEME
		print("Default theme set to " .. name)
	end
end

local function init()
	if vim.g.DEFAULT_THEME == nil then
		print("Default theme set to Kanagawa")
		vim.g.DEFAULT_THEME = themes['Kanagawa']
	end

	themes['Default'] = vim.g.DEFAULT_THEME

	-- Set theme on nvim start
	local scheme = themes['Default'][1]
	local bg = themes['Default'][2]
	local ft = get_filetype()

	if file_themes[ft] ~= nil then
		scheme = file_themes[ft][1]
		bg = file_themes[ft][2]
	end

	opt.termguicolors = true
	cmd.colorscheme(scheme)
	opt.background = bg
	background = bg

	-- Add autocmd to update theme on filetype changed
	api.nvim_create_autocmd({ 'FileType', 'BufWinEnter', 'BufEnter' }, {
		nested = true,
		callback = update_theme,
	})

	-- User commands to change theme manually
	for name, _ in pairs(themes) do
		api.nvim_create_user_command(name, function()
			set_theme(themes[name])
		end, {})
	end

	-- User command to set the default theme
	api.nvim_create_user_command('SetDefaultTheme', function(opts)
		set_default(opts.fargs[1])
	end, {
		nargs = 1,
		complete = function(arglead, _, _)
			local potential_args = {}

			for k, _ in pairs(themes) do
				if (#k >= #arglead and string.lower(string.sub(k, 1, #arglead)) == string.lower(arglead)) then
					potential_args[#potential_args + 1] = k
				end
			end

			return potential_args
		end,
	})
end

-- Call init only when shada files are loaded
api.nvim_create_autocmd('VimEnter', {
	nested = true,
	callback = init,
})
