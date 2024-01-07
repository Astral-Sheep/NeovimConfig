require('lualine').setup {
	options = {
		icons_enabled = true,
		theme = "auto",
	},
	sections = {
		lualine_a = {
			{
				"mode",
				icons_enabled = true,
				draw_empty = true,
			},
			"selectioncount",
		},
		lualine_b = {
			"branch",
			{
				"diff",
				colored = true,
			},
		},
		lualine_c = {
			{
				"filename",
				file_status = true,
				newfile_status = true,
				path = 1,
			},
		},
		lualine_x = {
			"encoding",
			"fileformat",
			{
				"filetype",
				colored = true,
				icon_only = true,
			},
		},
		lualine_y = {
			{
				"diagnostics",
				sources = { "nvim_lsp" },
				sections = { "error", "warn", "hint", "info" },
				symbols = { error = 'E ', warn = 'W ', info = 'I ', hint = 'H ' },
				colored = true,
				update_in_insert = false,
				always_visible = true,
			},
		},
		lualine_z = {
			"location",
			"progress",
		},
	},
}
