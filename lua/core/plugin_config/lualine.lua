require('lualine').setup {
	options = {
		icons_enabled = true,
		theme = 'auto',
		component_separators = '',
	},
	sections = {
		lualine_a = {
			{
				'mode',
				icons_enabled = true,
				draw_empty = true,
			},
		},
		lualine_b = {
			'branch',
		},
		lualine_c = {
			{
				'filename',
				file_status = true,
				newfile_status = true,
				path = 1,
			},
		},
		lualine_x = {
			'encoding',
			'fileformat',
			{
				'filetype',
				colored = true,
				icon_only = true,
			},
		},
		lualine_y = {
			{
				'diff',
				colored = true,
				symbols = {
					added = "󰐖 ",
					modified = " ",
					removed = " ",
				},
			},
			{
				'diagnostics',
				sources = { "nvim_lsp" },
				sections = { "error", "warn", "hint", "info" },
				symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
				colored = true,
				update_in_insert = false,
				always_visible = true,
			},
		},
		lualine_z = {
			'location',
			'progress',
		},
	},
}

function RefreshLualine()
	require('lualine').refresh({
		scope = 'window', -- scope of refresh all/tabpage/window
		place = { 'statusline', 'winbar', 'tabline' }, -- lualine segment to refresh
	})
end

