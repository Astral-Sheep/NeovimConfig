require('core.plugin_config.color_themes.kanagawa')

local api = vim.api
local cmd = vim.cmd
local opt = vim.opt

local custom = {
	c = { 'gruvbox', 'dark' },
	cpp = { 'gruvbox', 'dark' },
	tpp = { 'gruvbox', 'dark' },
	cmake = { 'gruvbox', 'dark' },
	cs = { 'onedark', 'dark' },
	rust = { 'onedark', 'dark' },
}
local default_theme = { 'kanagawa-wave', '' }

opt.termguicolors = true

-- Return the filetype of the current buffer
local function get_filetype()
	return vim.filetype.match({ filename = api.nvim_buf_get_name(0) })
end

-- Return the theme linked to the given filetype
local function get_file_theme(filetype)
	if (custom[filetype] ~= nil)
	then
		return custom[filetype]
	else
		return default_theme
	end
end

local background

-- Recover the filetype of the current buffer, and set the theme according to it
local function update_theme()
	-- Recover filetype
	local filetype = get_filetype()

	if (filetype == nil or filetype == "")
	then
		return
	end

	-- Recover theme
	local color_scheme = get_file_theme(filetype)
	local scheme = color_scheme[1]
	local bg = color_scheme[2]

	-- Set theme
	if (scheme ~= nil and scheme ~= vim.g.colors_name)
	then
		cmd[[ hi clear ]]
		cmd.colorscheme(scheme)
	end

	if (bg ~= nil and bg ~= background)
	then
		opt.background = bg
		background = bg
	end
end

-- Set theme on nvim start
local scheme = default_theme[1]
local bg = default_theme[2]
local filetype = get_filetype()

if (custom[filetype] ~= nil)
then
	scheme = custom[filetype][1]
	bg = custom[filetype][2]
end

cmd.colorscheme(scheme)
opt.background = bg
background = bg

-- Add autocmd to update theme on filetype changed
api.nvim_create_autocmd({ 'FileType', 'BufWinEnter' }, {
	nested = true,
	callback = update_theme
})

-- Add user commands to change theme manually
local themes = {
	gruvbox = 'Gruvbox',
	onedark = 'Onedark',
	kanagawa = 'Kanagawa',
}

for theme, command in pairs(themes) do
	api.nvim_create_user_command(command, 'colorscheme ' .. theme, {})
end

