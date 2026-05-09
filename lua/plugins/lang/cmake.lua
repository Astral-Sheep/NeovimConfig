return {
	{
		--- Source ---
		'nvim-treesitter/nvim-treesitter',

		--- Setup ---
		opts = { ensure_installed = { 'cmake' } },
	},

	{
		'mason.nvim',
		opts = { ensure_installed = { 'cmakelang' } },
	},

	{
		'neovim/nvim-lspconfig',
		opts = {
			servers = {
				neocmake = {},
			},
		},
	},

	{
		--- Source ---
		'Civitasv/cmake-tools.nvim',

		--- Setup ---
		init = function()
			local loaded = false
			local function check()
				local cwd = vim.uv.cwd()

				if vim.fn.filereadable(cwd .. "/CMakeLists.txt") == 1 then
					require('lazy').load({ plugins = { 'cmake-tools.nvim' } })
					loaded = true
				end
			end

			check()

			vim.api.nvim_create_autocmd('DirChanged', {
				callback = function()
					if not loaded then
						check()
					end
				end,
			})
		end,
		opts = {},

		--- Lazy loading ---
		lazy = true,
	}
}
