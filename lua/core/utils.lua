---@class core.utils
local M = {}

-- Functions from lazy.core.util

---@param opts? { level?: number }
function M.pretty_trace(opts)
	opts = opts or {}

	local LazyConfig = require('lazy.core.config')
	local trace = {}
	local level = opts.level or 2

	while true do
		local info = debug.getinfo(level, "Sln")

		if not info then
			break
		end

		if info.what ~= 'C' and (LazyConfig.options.debug or not info.source:find('lazy.nvim')) then
			local source = info.source:sub(2)

			if source:find(LazyConfig.options.root, 1, true) == 1 then
				source = source:sub(#LazyConfig.options.root + 1)
			end

			source = vim.fn.fnamemodify(source, ':p:~:.') --[[@as string]]
			local line = "  - " .. source .. ":" .. info.currentline

			if info.name then
				line = line .. " _in_ **" .. info.name .. "**"
			end

			table.insert(trace, line)
		end

		level = level + 1
	end

	return #trace > 0 and ("\n\n# stacktrace:\n" .. table.concat(trace, "\n")) or ""
end

---@generic R
---@param fn fun():R?
---@param opts? string|{ msg:string, on_error:fun(msg) }
---@return R
function M.try(fn, opts)
	opts = type(opts) == 'string' and { msg = opts } or opts or {}

	local msg = opts.msg
	local error_handler = function(err)
		msg = (msg and (msg .. "\n\n") or "") .. err .. M.pretty_trace()

		if opts.on_error then
			opts.on_error(msg)
		else
			vim.schedule(function()
				M.error(msg)
			end)
		end

		return err
	end

	---@type boolean, any
	local ok, result = xpcall(fn, error_handler)
	return ok and result or nil
end

---@alias NotifyOpts { lang?:string, title?:string, level?:number, once?: boolean, stacktrace?:boolean, stacklevel?:number }

---@param msg string|string[]
---@param opts? NotifyOpts
function M.notify(msg, opts)
	if vim.in_fast_event() then
		return vim.schedule(function()
			M.notify(msg, opts)
		end)
	end

	opts = opts or {}

	if type(msg) == 'table' then
		msg = table.concat(
			vim.tbl_filter(function(line)
				return line or false
			end, msg),
			"\n"
		)
	end

	if opts.stacktrace then
		msg = msg .. M.pretty_trace({ level = opts.stacklevel or 2 })
	end

	local lang = opts.lang or 'markdown'
	local n = opts.once and vim.notify_once or vim.notify
	n(msg, opts.level or vim.log.levels.INFO, {
		ft = lang,
		on_open = function(win)
			local ok = pcall(function()
				vim.treesitter.language.add('markdown')
			end)

			if not ok then
				pcall(require, 'nvim-treesitter')
			end

			vim.wo[win].conceallevel = 3
			vim.wo[win].concealcursor = ""
			vim.wo[win].spell = false
			local buf = vim.api.nvim_win_get_buf(win)

			if not pcall(vim.treesitter.start, buf, lang) then
				vim.bo[buf].filetype = lang
				vim.bo[buf].syntax = lang
			end
		end,
		title = opts.title or 'lazy.nvim',
	})
end

---@param msg string|string[]
---@param opts? NotifyOpts
function M.error(msg, opts)
	opts = opts or {}
	opts.level = vim.log.levels.ERROR
	M.notify(msg, opts)
end

---@param msg string|string[]
---@param opts? NotifyOpts
function M.info(msg, opts)
	opts = opts or {}
	opts.level = vim.log.levels.INFO
	M.notify(msg, opts)
end

---@param msg string|string[]
---@param opts? NotifyOpts
function M.warn(msg, opts)
	opts = opts or {}
	opts.level = vim.log.levels.WARN
	M.notify(msg, opts)
end

---@param msg string|string[]
---@param opts? NotifyOpts
function M.debug(msg, opts)
	if not require('lazy.core.config').options.debug then
		return
	end

	opts = opts or {}

	if opts.title then
		opts.title = "lazy.nvim: " .. opts.title
	end

	if type(msg) == 'string' then
		M.notify(msg, opts)
	else
		opts.lang = 'lua'
		M.notify(vim.inspect(msg), opts)
	end
end

-- Fast implementation to check if a table is a list
---@param t table
function M.is_list(t)
	local i = 0

	for _ in pairs(t) do
		i = i + 1

		if t[i] == nil then
			return false
		end
	end

	return true
end

local function can_merge(v)
	return type(v) == 'table' and (vim.tbl_isempty(v) or not M.is_list(v))
end

--- Merges the values similar to vim.tbl_deep_extend with the **force** behaviour,
--- but the values can be any type, in which case they override the values on the left.
--- Values will be merged in-place in the first left-most table. If you want the result to be in
--- a new table, then simply pass an empty table as the first argument `vim.merge({}, ...)`
--- Supports clearing values by setting a key to `vim.NIL`
---@generic T
---@param ... T
---@return T
function M.merge(...)
	local ret = select(1, ...)

	if ret == vim.NIL then
		ret = nil
	end

	for i = 2, select("#", ...) do
		local value = select(i, ...)

		if can_merge(ret) and can_merge(value) then
			for k, v in pairs(value) do
				ret[k] = M.merge(ret[k], v)
			end
		elseif value == vim.NIL then
			ret = nil
		elseif value ~= nil then
			ret = value
		end
	end

	return ret
end

function M.dedup(list)
	local ret = {}
	local seen = {}

	for _, v in ipairs(list) do
		if not seen[v] then
			table.insert(ret, v)
			seen[v] = true
		end
	end

	return ret
end

-- Custom functions

---@return string
function M.get_filetype()
	return vim.filetype.match({ filename = vim.api.nvim_buf_get_name(0) })
end

---@param str string
function M.capitalize(str)
	return str ~= nil and #str > 0 and string.upper(string.sub(str, 1, 1)) .. string.sub(str, 2) or ""
end

return M
