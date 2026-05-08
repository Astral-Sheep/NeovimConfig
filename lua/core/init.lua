---@class config
---@field defaults ConfigDefaults
---@field colorschemes core.colorscheme
---@field cmp core.cmp
---@field lsp core.lsp
---@field options table
---@field pick core.pick
---@field root core.root
---@field treesitter core.treesitter
---@field utils core.utils
local M = {
	defaults = require('core.defaults'),
	colorschemes = require('core.colorscheme'),
	cmp = require('core.cmp'),
	lsp = require('core.lsp'),
	options = {},
	pick = require('core.pick'),
	root = require('core.root'),
	treesitter = require('core.treesitter'),
	utils = require('core.utils'),
}

---@param name string
function M.get_plugin(name)
	return require('lazy.core.config').spec.plugins[name]
end

---@param plugin string
function M.has(plugin)
	return M.get_plugin(plugin) ~= nil
end

---@param name string
function M.opts(name)
	local plugin = M.get_plugin(name)

	if not plugin then
		return {}
	end

	local Plugin = require('lazy.core.plugin')
	return Plugin.values(plugin, 'opts', false)
end

---@param buf? number
---@return string[]?
function M.get_kind_filter(buf)
	buf = (buf == nil or buf == 0) and vim.api.nvim_get_current_buf() or buf
	local ft = vim.bo[buf].filetype

	if M.defaults.kind_filter == false then
		return
	end

	if M.defaults.kind_filter[ft] == false then
		return
	end

	if type(M.defaults.kind_filter[ft]) == 'table' then
		return M.defaults.kind_filter[ft]
	end

	return type(M.defaults.kind_filter) == 'table' and type(M.defaults.kind_filter.default) == 'table' and M.defaults.kind_filter.default or nil
end

local _defaults = {} ---@type table<string, boolean>

-- Determines whether it's safe to set an option to a default value.
--
-- It will only set the option if:
-- * it is the same as the global value
-- * it's current value is a default value
-- * it was las set by a script in $VIMRUNTIME
---@param option string
---@param value string|number|boolean
---@return boolean was_set
function M.set_default(option, value)
	local l = vim.api.nvim_get_option_value(option, { scope = 'local' })
	local g = vim.api.nvim_get_option_value(option, { scope = 'global' })

	_defaults[("%s=%s"):format(option, value)] = true
	local key = ("%s=%s"):format(option, l)

	local source = ""

	if l ~= g and not _defaults[key] then
		-- Option does not match global and is not a default value
		-- Check if it was set by a script in $VIMRUNTIME
		local info = vim.api.nvim_get_option_info2(option, { scope = 'local' })
		local scriptinfo = vim.tbl_filter(function(e)
			return e.sid == info.last_set_sid
		end, vim.fn.getscriptinfo())

		source = scriptinfo[1] and scriptinfo[1].name or ""
		local by_rtp = #scriptinfo == 1 and vim.startswith(scriptinfo[1].name, vim.fn.expand('$VIMRUNTIME'))

		if not by_rtp then
			if vim.g.lazyvim_debug_set_default then
				Config.utils.warn(
					("Not setting option `%s` to `%q` because it was changed by a plugin."):format(option, value),
					{ title = "LazyVim", once = true }
				)
			end

			return false
		end
	end

	if vim.g.lazyvim_debug_set_default then
		Config.utils.info({
			("Setting option `%s` to `%q`"):format(option, value),
			("Was: %q"):format(l),
			("Global: %q"):format(g),
			source ~= "" and ("Last set by: %s"):format(source) or "",
			"buf: " .. vim.api.nvim_buf_get_name(0),
		}, { title = "LazyVim", once = true })
	end

	vim.api.nvim_set_option_value(option, value, { scope = 'local' })
	return true
end

---@param fn fun()
function M.on_very_lazy(fn)
	vim.api.nvim_create_autocmd('User', {
		pattern = 'VeryLazy',
		callback = function()
			fn()
		end,
	})
end

---@param cfg string
---@return table?
local function load(cfg)
	if M.defaults[cfg] == false then
		M.utils.info(cfg .. " is disabled")
		return nil
	end

	return require('config.' .. cfg)
end

---@param opts table<string, table>?
local function load_options(opts)
	local options = load('options')

	if options == nil then
		return
	end

	if opts ~= nil then
		for cat, tab in pairs(opts) do
			if options[cat] == nil then
				options[cat] = {}
			end

			if type(tab) == 'table' then
				for opt, val in pairs(tab) do
					options[cat][opt] = val
				end
			end
		end
	end

	for cat, tab in pairs(options) do
		if vim[cat] ~= nil and type(tab) == 'table' then
			if type(tab) == 'table' then
				for opt, val in pairs(tab) do
					if type(val) == 'function' then
						val(vim[cat])
					else
						vim[cat][opt] = val
					end
				end
			else
				vim[cat] = tab
			end
		else
			M.options[cat] = tab
		end
	end
end

local function load_keymaps()
	local keymaps = load('keymaps')

	if keymaps == nil then
		return
	end

	for mode, maps in pairs(keymaps) do
		if type(mode) == 'string' and type(maps) == 'table' then
			for _, map in ipairs(maps) do
				if type(map) == 'function' then
					map(vim.keymap)
				elseif type(map) == 'table' then
					vim.keymap.set(mode, map[1], map[2], #map >= 3 and map[3] or {})
				else
					M.utils.error("Invalid keymap type: " .. type(map))
				end
			end
		end
	end
end

---@param opts table?
function M.setup(opts)
	load_options(opts)

	-- Initialize LazyVim
	load('lazy')

	M.colorschemes.init()
	load_keymaps()

	-- Create autocmds
	load('autocmds')
end

_G.Config = M
return M
