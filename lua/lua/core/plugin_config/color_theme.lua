local custom = {
	['c'] = { 'gruvbox', 'dark' },
	['cpp'] = { 'gruvbox', 'dark' },
	['cs'] = { 'darcula-solid', 'dark' },
	['rust'] = { 'onedark', 'dark' },
}
local default_theme = { 'onedark', 'dark' }

local set = vim.opt
local filetype = vim.filetype.match({ filename = vim.api.nvim_buf_get_name(0) })

set.termguicolors=true

if (custom[filetype] ~= nil) then
	set.background=custom[filetype][2]
	vim.cmd.colorscheme(custom[filetype][1])
else
	set.background=default_theme[2]
	vim.cmd.colorscheme(default_theme[1])
end

