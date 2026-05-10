---@class core.json
local M = {
	version = 1,
	loaded = false,
	path = vim.g.config_json or vim.fn.stdpath('config') .. '/config.json',
	data = {
		version = nil, ---@type number?
		install_version = nil, ---@type number?
		news = {}, ---@type table<string, string>
	},
}

local function encode(value, indent)
	local t = type(value)

	if t == 'string' then
		return string.format("%q", value)
	elseif t == 'number' or t == 'boolean' then
		return tostring(value)
	elseif t == 'table' then
		local is_list = Config.utils.is_list(value)
		local parts = {}
		local next_indent = indent .. "  "

		if is_list then
			---@diagnostic disable-next-line: no-unknown
			for _, v in ipairs(value) do
				local e = encode(v, next_indent)

				if e then
					table.insert(parts, next_indent .. e)
				end
			end

			return "[\n" .. table.concat(parts, ",\n") .. "\n" .. indent .. "]"
		else
			local keys = vim.tbl_keys(value)
			table.sort(keys)

			---@diagnostic disable-next-line: no-unknown
			for _, k in ipairs(keys) do
				local e = encode(value[k], next_indent)

				if e then
					table.insert(parts, next_indent .. string.format("%q", k) .. ": " .. e)
				end
			end

			return "{\n" .. table.concat(parts, ",\n") .. "\n" .. indent .. "}"
		end
	end
end

function M.encode(value)
	return encode(value, "")
end

function M.load()
	M.loaded = true
	local f = io.open(M.path, 'r')

	if f then
		local data = f:read("*a")
		f:close()
		local ok, json = pcall(vim.json.decode, data, { luanil = { object = true, array = true } })

		if ok then
			M.data = vim.tbl_deep_extend('force', M.data, json or {})

			if M.data.version ~= M.version then
				Config.json.migrate()
			end
		end
	else
		M.data.install_version = M.version
	end
end

function M.save()
	Config.json.data.version = Config.json.version
	local f = io.open(Config.json.path, 'w')

	if f then
		f:write(Config.json.encode(Config.json.data))
		f:close()
	end
end

function M.migrate()
	Config.utils.info("Migrating `config.json` to version `" .. Config.json.version .. "`")
	local json = Config.json

	if not json.data.version then
		json.data.version = 1
	elseif json.data.version < json.version then
		Config.utils.warn("Migrate function isn't implemented for migrating from version " .. json.data.version .. " to version " .. json.version)
	end

	M.save()
end

return M
