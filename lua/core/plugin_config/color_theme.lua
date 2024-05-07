-- vim.opt.termguicolors = true
-- vim.cmd [[ colorscheme onedark ]]

local custom = {
	['c'] = { 'gruvbox', 'dark' },
	['cpp'] = { 'gruvbox', 'dark' },
	['tpp'] = { 'gruvbox', 'dark' },
	['cmake'] = { 'gruvbox', 'dark' },
	['cs'] = { 'onedark', 'dark' },
	['rust'] = { 'onedark', 'dark' },
}
local default_theme = { 'onedark', 'dark' }

vim.opt.termguicolors = true

local function get_filetype()
	return vim.filetype.match({ filename = vim.api.nvim_buf_get_name(0) })
end

local function get_file_theme(filetype)
	if (custom[filetype] ~= nil)
	then
		return custom[filetype]
	else
		return default_theme
	end
end

local background

function UpdateTheme()
	local filetype = get_filetype()

	if (filetype == nil or filetype == "")
	then
		return
	end

	local color_scheme = get_file_theme(filetype)
	local scheme = color_scheme[1]
	local bg = color_scheme[2]

	if (scheme ~= nil and scheme ~= vim.g.colors_name)
	then
		vim.cmd[[ hi clear ]]
		vim.cmd.colorscheme(scheme)
	end

	if (bg ~= nil and bg ~= background)
	then
		vim.opt.background = bg
		background = bg
	end
end

local scheme = default_theme[1]
local bg = default_theme[2]
local filetype = get_filetype()

if (custom[filetype] ~= nil)
then
	scheme = custom[filetype][1]
	bg = custom[filetype][2]
end

vim.cmd.colorscheme(scheme)
vim.opt.background = bg
background = bg

