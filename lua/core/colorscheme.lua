---@class core.colorscheme
local M = {}

local colorschemes = require('config.colorscheme')
local modes = { 'auto', 'dark', 'light' }
-- Stores the default terminal theme
-- FIX: store the default OS theme
local default_mode = vim.opt.background

---@return string
function M.get_system_theme()
	return default_mode
end

---@param file_type string
---@return string
function M.get_file_colorscheme(file_type)
	return Config.defaults.colorschemes.file_schemes[file_type] or vim.g.DEFAULT_THEME or 'default'
end

function M.refresh_color_mode()
	vim.opt.background = (vim.g.COLOR_MODE ~= 'auto' and vim.g.COLOR_MODE) or M.get_system_theme()
end

---@param mode string
function M.set_color_mode(mode)
	if mode == nil or mode == vim.g.COLOR_MODE then
		return
	end

	vim.g.COLOR_MODE = mode
	M.refresh_color_mode()
end

---@param colorscheme string
function M.set_colorscheme(colorscheme)
	if colorscheme == nil or colorscheme == vim.g.colors_name then
		return
	end

	vim.cmd('hi clear')

	local ok, _ = pcall(vim.cmd.colorscheme, colorscheme)

	if not ok then
		vim.cmd.colorscheme('default')
	end

	M.refresh_color_mode()
end

function M.update_colorscheme()
	---@type string?
	local ft = Config.utils.get_filetype()

	if ft == nil or ft == "" then
		return
	end

	M.set_colorscheme(M.get_file_colorscheme(ft))
end

---@param colorscheme string
function M.set_default_colorscheme(colorscheme)
	if colorscheme == vim.g.DEFAULT_THEME then
		return
	end

	local last_default = vim.g.DEFAULT_THEME
	vim.g.DEFAULT_THEME = colorscheme or 'default'

	-- Can be equal if last colorscheme was `default`
	if last_default == vim.g.DEFAULT_THEME then
		return
	end

	-- Apply new default colorscheme if per filetype colorscheme is enabled and the last default colorscheme was in use
	if Config.options.change_colorscheme_per_filetype and Config.defaults.colorschemes.file_schemes[Config.utils.get_filetype()] == nil then
		M.set_colorscheme(vim.g.DEFAULT_THEME)
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

---@return string
function M.get_current_colorscheme()
	-- Handle themes that have their variation concatenated to their name like `tokyonight-moon`
	return string.match(vim.g.colors_name, "(.+)-.+") or vim.g.colors_name
end

---@return string[]
function M.get_colorscheme_list()
	local list = vim.tbl_keys(colorschemes)
	table.sort(list)
	return list
end

---@param offset integer
function M.loop_colorscheme(offset)
	local current_colorscheme = M.get_current_colorscheme()
	local colorscheme_names = M.get_colorscheme_list()

	-- Very inefficient but unless you have like a billion themes it should be fine
	for i, v in ipairs(colorscheme_names) do
		if v == current_colorscheme then
			local new_colorscheme = colorscheme_names[((i + offset - 1) % #colorscheme_names) + 1]
			M.set_colorscheme(new_colorscheme)
			Config.utils.info("Colorscheme set to " .. Config.utils.capitalize(new_colorscheme))
			return
		end
	end
end

function M.switch_color_mode()
	local current_mode = vim.g.COLOR_MODE
	current_mode = current_mode == 'auto' and M.get_system_theme() or current_mode
	M.set_color_mode(current_mode == 'dark' and 'light' or 'dark')
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

	if Config.options.change_colorscheme_per_filetype and colorscheme_defaults.file_schemes[ft] ~= nil then
		scheme = colorscheme_defaults.file_schemes[ft]
	end

	vim.opt.termguicolors = true
	vim.cmd.colorscheme(scheme)
	M.refresh_color_mode()

	M.create_commands()
	M.create_keymaps()
end

function M.create_commands()
	if Config.options.change_colorscheme_per_filetype then
		-- Add autocmd to update theme on filetype changed
		vim.api.nvim_create_autocmd({ 'FileType', 'BufWinEnter', 'BufEnter' }, {
			nested = true,
			callback = function()
				M.update_colorscheme()
			end
		})
	end

	-- User commands to change theme manually
	for colorscheme, value in pairs(colorschemes) do
		if type(colorscheme) == 'string' and type(value) == 'table' then
			local name = Config.utils.capitalize(colorscheme)
			vim.api.nvim_create_user_command(
				name,
				function()
					M.set_colorscheme(colorscheme)
				end,
				{
					desc = "Use `" .. name .. "` colorscheme for the current buffer",
					nargs = 0,
				})
		end
	end

	-- User command to set the default theme
	vim.api.nvim_create_user_command(
		'SetDefaultColorscheme',
		function(opts)
			M.set_default_colorscheme(opts.fargs[1]:lower())
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
			M.set_color_mode(opts.fargs[1]:lower())
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

function M.create_keymaps()
	vim.keymap.set('n', '<leader>tc', function() M.loop_colorscheme(1) end, { desc = "Loop colorschemes in alphabetical order" })
	vim.keymap.set('n', '<leader>tC', function() M.loop_colorscheme(-1) end, { desc = "Loop colorschemes in reverse alphabetical order" })
	vim.keymap.set('n', '<leader>tm', function() M.switch_color_mode() end, { desc = "Switch beetween light and dark color modes" })
end

return M
