---@class core.colorscheme
local M = {}

local colorschemes = require('config.colorscheme')
local modes = { 'auto', 'dark', 'light' }

---@return string
local function get_system_theme()
	return 'dark'
end

---@param file_type string
---@return string
local function get_file_colorscheme(file_type)
	return Config.defaults.colorschemes.file_schemes[file_type] or vim.g.DEFAULT_THEME or 'default'
end

---@param mode string
local function set_color_mode(mode)
	if mode == nil or mode == vim.g.COLOR_MODE then
		return
	end

	vim.g.COLOR_MODE = mode
	refresh_color_mode()
end

local function refresh_color_mode()
	vim.opt.background = (vim.g.COLOR_MODE ~= 'auto' and vim.g.COLOR_MODE) or get_system_theme()
end

---@param colorscheme string
local function set_colorscheme(colorscheme)
	if colorscheme == nil or colorscheme == vim.g.colors_name then
		return
	end

	vim.cmd('hi clear')

	local ok, _ = pcall(vim.cmd.colorscheme, colorscheme)

	if not ok then
		vim.cmd.colorscheme('default')
	end

	refresh_color_mode()
end

local function update_colorscheme()
	---@type string?
	local ft = Config.utils.get_filetype()

	if ft == nil or ft == "" then
		return
	end

	set_colorscheme(get_file_colorscheme(ft))
end

---@param colorscheme string
local function set_default_colorscheme(colorscheme)
	if colorscheme == vim.g.DEFAULT_THEME then
		return
	end

	local last_default = vim.g.DEFAULT_THEME
	vim.g.DEFAULT_THEME = colorscheme or 'default'

	-- Can be equal if last colorscheme was `default`
	if last_default == vim.g.DEFAULT_THEME then
		return
	end

	local colorscheme_defaults = Config.defaults.colorschemes

	-- Apply new default colorscheme if per filetype colorscheme is enabled and the last default colorscheme was in use
	if colorscheme_defaults.per_filetype and colorscheme_defaults.file_schemes[Config.utils.get_filetype()] == nil then
		set_colorscheme(vim.g.DEFAULT_THEME)
	end

	Config.utils.debug("Default colorscheme set to `" .. Config.utils.capitalize(colorscheme) .. "`")
end

---Get all LazyVim plugin data for colorschemes
---@return table[]
function M.get_lazyopts()
	local opts = {}

	for _, v in pairs(colorschemes) do
		if type(v) == 'table' and v.lazyopts ~= nil then
			opts[#opts + 1] = v.lazyopts
		end
	end

	return opts
end

function M.init()
	local colorscheme_defaults = Config.defaults.colorschemes

	-- Initialize default theme
	if vim.g.DEFAULT_THEME == nil then
		vim.g.DEFAULT_THEME = require(colorscheme_defaults.file_schemes.default) and colorscheme_defaults.file_schemes.default or 'default'
		Config.utils.debug("Default colorscheme reset to `" .. Config.utils.capitalize(vim.g.DEFAULT_THEME) .. "`")
	end

	if vim.g.COLOR_MODE == nil then
		vim.g.COLOR_MODE = 'auto'
		Config.utils.debug("Default color mode reset to `" .. vim.g.COLOR_MODE .. "`")
	end

	-- Set theme on nvim start
	local scheme = vim.g.DEFAULT_THEME
	local ft = Config.utils.get_filetype()

	if colorscheme_defaults.per_filetype and colorscheme_defaults.file_schemes[ft] ~= nil then
		scheme = colorscheme_defaults.file_schemes[ft]
	end

	vim.opt.termguicolors = true
	vim.cmd.colorscheme(scheme)
	-- For some reason I need to use the underlying value of background,
	-- otherwise a type mismatch error is thrown
	vim.opt.background = (vim.g.COLOR_MODE ~= 'auto' and vim.g.COLOR_MODE) or get_system_theme()

	M.create_commands()
end

function M.create_commands()
	local colorscheme_defaults = Config.defaults.colorschemes

	if colorscheme_defaults.per_filetype then
		-- Add autocmd to update theme on filetype changed
		vim.api.nvim_create_autocmd({ 'FileType', 'BufWinEnter', 'BufEnter' }, {
			nested = true,
			callback = function()
				update_colorscheme()
			end
		})
	end

	-- User commands to change theme manually
	for colorscheme, value in pairs(colorschemes) do
		if type(colorscheme) == 'string' and type(value) == 'table' then
			vim.api.nvim_create_user_command(Config.utils.capitalize(colorscheme), function()
				set_colorscheme(colorscheme)
			end, {})
		end
	end

	-- User command to set the default theme
	vim.api.nvim_create_user_command(
		'SetDefaultColorscheme',
		function(opts)
			set_default_colorscheme(opts.fargs[1]:lower())
		end,
		{
			nargs = 1,
			complete = function(arglead, _, _)
				local potential_args = {}

				for k, _ in pairs(colorschemes) do
					if #k >= #arglead and string.lower(string.sub(k, 1, #arglead)) == arglead:lower() then
						potential_args[#potential_args + 1] = k
					end
				end

				return potential_args
			end
		}
	)

	-- User command to set the color mode
	vim.api.nvim_create_user_command(
		'SetColorMode',
		function(opts)
			set_color_mode(opts.fargs[1]:lower())
		end,
		{
			nargs = 1,
			complete = function(arglead, _, _)
				local potential_args = {}

				for _, m in pairs(modes) do
					if #m >= #arglead and string.lower(string.sub(m, 1, #arglead)) == arglead:lower() then
						potential_args[#potential_args + 1] = m
					end
				end

				return potential_args
			end,
		}
	)
end

return M
