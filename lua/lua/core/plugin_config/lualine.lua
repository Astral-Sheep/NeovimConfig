require('lualine').setup {
	options = {
		icons_enabled = true,
		theme = 'auto',
	},
	sections = {
		lualine_a = {
			{
				'filename',
				path = 1,
			}
		}
	}
}

-- Airline commands
-- vim.cmd[[
	-- let g:airline#extensions#tabline#enabled = 1
	-- let g:airline#extensions#tabline#left_sep = ''
	-- let g:airline#extensions#tabline#left_alt_sep = ''
	-- let g:airline#extensions#tabline#right_sep = ''
	-- let g:airline#extensions#tabline#right_alt_sep = ''

	-- let g:airline_powerline_fonts = 1
	-- let g:airline_left_sep = ''
	-- let g:airline_right_sep = ''

	-- let g:airline_theme = 'gruvbox'
-- ]]
