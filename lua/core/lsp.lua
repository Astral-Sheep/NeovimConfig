---@class core.lsp
local M = {}

M.action = setmetatable({}, {
	__index = function(_, action)
		return function()
			vim.lsp.buf.code_action({
				apply = true,
				context = {
					only = { action },
					diagnostics = {},
				},
			})
		end
	end,
})

---@class LspCommand: lsp.ExecuteCommandParams
---@field open? boolean
---@field handler? lsp.Handler
---@field filter? string|vim.lsp.get_clients.Filter
---@field title? string

---@param opts LspCommand
function M.execute(opts)
	local filter = opts.filter or {}
	filter = type(filter) == 'string' and { name = filter } or filter
	local buf = vim.api.nvim_get_current_buf()

	---@cast filter vim.lsp.get_clients.Filter
	local client = vim.lsp.get_clients(Config.utils.merge({}, filter, { bufnr = buf }))[1]

	local params = {
		command = opts.command,
		arguments = opts.arguments,
	}

	if opts.open then
		require('trouble').open({
			mode = 'lsp_command',
			params = params,
		})
	else
		vim.list_extend(params, { title = opts.title })
		return client:exec_cmd(params, { bufnr = buf }, opts.handler)
	end
end

---@param filter? vim.lsp.get_client.Filter
function M.code_actions(filter)
	filter = filter or {}
	local ret = {} ---@type string[]
	local clients = vim.lsp.get_clients(filter)

	for _, client in ipairs(clients) do
		-- Check server capabilities first
		vim.list_extend(ret, vim.tbl_get(client, 'server_capabilities', 'codeActionProvider', 'codeActionKinds') or {})
		-- Check dynamic capabilities
		local regs = client.dynamic_capabilities:get('codeActionProvider', filter)

		for _, reg in ipairs(regs or {}) do
			vim.list_extend(ret, vim.tbl_get(reg, 'registerOptions', 'codeActionKinds') or {})
		end
	end

	return Config.utils.dedup(ret)
end

return M
