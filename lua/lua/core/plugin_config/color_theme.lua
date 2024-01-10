local custom = {
	['c'] = { 'gruvbox', 'dark' },
	['cpp'] = { 'gruvbox', 'dark' },
	['cmake'] = { 'gruvbox', 'dark' },
	['cs'] = { 'onedark', 'dark' },
	['rust'] = { 'onedark', 'dark' },
}
local default_theme = { 'onedark', 'dark' }

local filetype = vim.filetype.match({ filename = vim.api.nvim_buf_get_name(0) })
local opt = vim.opt
local cmd = vim.cmd

opt.termguicolors=true

if (custom[filetype] ~= nil) then
	opt.background=custom[filetype][2]
	cmd.colorscheme(custom[filetype][1])
else
	opt.background=default_theme[2]
	cmd.colorscheme(default_theme[1])
end

