local parsers = {
	-- 'arduino',
	-- 'asm',
	'bash',
	'c',
	'c_sharp',
	'cmake',
	'cpp',
	'css',
	-- 'gdscript',
	'gitattributes',
	'gitignore',
	'glsl',
	'hlsl',
	'html',
	-- 'java',
	'javascript',
	'json',
	'lua',
	'markdown',
	'powershell',
	'python',
	'rust',
	-- 'typescript',
	'vim',
	'vimdoc',
	'yaml',
}

return {
	--- Source ---
	'nvim-treesitter/nvim-treesitter',

	--- Setup ---
	opts = {
		install_dir = vim.fn.stdpath('data') .. '/site',
	},
	config = function(_, opts)
		local treesitter = require('nvim-treesitter')
		treesitter.setup(opts)

		local installed_parsers = treesitter.get_installed()
		local uninstalled_parsers = vim.iter(parsers)
			:filter(function(parser) return not vim.tbl_contains(installed_parsers, parser) end)
			:totable()

		treesitter.install(uninstalled_parsers)

		local function refresh_treesitter()
			local api = vim.api

			if vim.g.colors_name == 'gruvbox' then
				api.nvim_set_hl(0, 'Function',                 { link = 'GruvboxAqua' })
				api.nvim_set_hl(0, 'Constant',                 { link = 'GruvboxAqua' })
				api.nvim_set_hl(0, 'Number',                   { link = 'GruvboxPurple' })
				api.nvim_set_hl(0, 'Character',                { link = 'String' })
				api.nvim_set_hl(0, 'Boolean',                  { link = 'GruvboxRed' })
				api.nvim_set_hl(0, 'StorageClass',             { link = 'GruvboxRed' })
				api.nvim_set_hl(0, 'Structure',                { link = 'GruvboxYellow' })
				api.nvim_set_hl(0, 'Typedef',                  { link = 'GruvboxYellow' })
				api.nvim_set_hl(0, 'Delimiter',                { link = 'GruvboxOrange' })

				api.nvim_set_hl(0, '@variable',                { link = 'GruvboxBlue' })
				api.nvim_set_hl(0, '@type.qualifier',          { link = 'Keyword' })
				api.nvim_set_hl(0, '@keyword.directive',       { link = 'PreProc' })
				api.nvim_set_hl(0, '@keyword.import',          { link = 'PreProc' })
				api.nvim_set_hl(0, '@constant.builtin',        { link = 'Keyword' })
				api.nvim_set_hl(0, '@namespace',               { link = 'PreProc' })

				api.nvim_set_hl(0, '@constructor.cpp',         { link = 'Function' })
				api.nvim_set_hl(0, '@type.builtin.cpp',        { link = 'Keyword' })
				api.nvim_set_hl(0, '@variable.builtin.cpp',    { link = 'Keyword' })
				api.nvim_set_hl(0, '@punctuation.delimiter.cpp', { link = 'Delimiter' })
				api.nvim_set_hl(0, '@punctuation.bracket.cpp', { link = 'Delimiter' })
				api.nvim_set_hl(0, '@module.cpp',              { link = 'Function' })

				api.nvim_set_hl(0, '@lsp.type.namespace',      { link = 'PreProc' })
				api.nvim_set_hl(0, '@lsp.type.operator.cpp',   { link = 'Normal' })
			end
		end

		-- Update colors when color scheme changes
		vim.api.nvim_create_autocmd('ColorScheme', {
			nested = true,
			callback = refresh_treesitter,
		})

		refresh_treesitter()

		vim.api.nvim_create_autocmd(
			'FileType',
			{
				pattern = parsers,
				callback = function()
					vim.treesitter.start()
				end
			}
		)
	end,
	build = ':TSUpdate',

	--- Versioning ---
	branch = 'main'
}
