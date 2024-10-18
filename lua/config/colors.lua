local api = vim.api
local cmd = vim.cmd
local opt = vim.opt

local kanagawa = { 'kanagawa', '' }
local gruvbox = { 'gruvbox', 'dark' }
local onedark = { 'onedark', 'dark' }

local file_themes = {
	c = gruvbox,
	cpp = gruvbox,
	tpp = gruvbox,
	cmake = gruvbox,
	cs = onedark,
	rust = onedark
}
local default_theme = kanagawa

-- Return the filetype of the current buffer
local function get_filetype()
	return vim.filetype.match({ filename = api.nvim_buf_get_name(0) })
end

local function get_file_theme(ft)
	if file_themes[ft] ~= nil then
		return file_themes[ft]
	else
		return default_theme
	end
end

local background
opt.termguicolors = true

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

-- Set theme on nvim start
local scheme = default_theme[1]
local bg = default_theme[2]
local ft = get_filetype()

if file_themes[ft] ~= nil then
	scheme = file_themes[ft][1]
	bg = file_themes[ft][2]
end

cmd.colorscheme(scheme)
opt.background = bg
background = bg

-- Add autocmd to update theme on filetype changed
api.nvim_create_autocmd({ 'FileType', 'BufWinEnter', 'BufEnter' }, {
	nested = true,
	callback = update_theme,
})

-- Add user commands to change theme manually
local cmds = {
	Gruvbox = gruvbox,
	Onedark = onedark,
	Kanagawa = kanagawa,
}

for command, theme in pairs(cmds) do
	api.nvim_create_user_command(command, function()
		set_theme(theme)
	end, {})
end
