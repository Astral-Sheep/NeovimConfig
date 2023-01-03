require('bufferline').setup {
	options = {
		mode = "buffers",
		numbers = "none",
		close_command = "bdelete! %d",
		right_mouse_command = "bdelete! %d",
		left_mouse_command = "buffer %d",
		middle_mouse_command = nil,
		indicator = {
			icon = "▎",
			style = "icon"
		},
		buffer_close_icon = "",
		modified_icon = "●",
		close_icon = "",
		left_trunk_marker = "",
		right_trunk_marker = "",
		max_name_length = 15,
		max_prefix_length = 12,
		truncate_names = true,
		tab_size = 15,
		diagnostics = "nvim_lsp",
		diagnostics_update_in_insert = true,
		diagnostics_indicator = function(count, level, _, _)
			if count > 1 then
				return "("..count.." "..level.."s)"
			else
				return "("..count.." "..level..")"
			end
		end,
		custom_filter = nil,
		offsets = {
			{
				filetype = "NvimTree",
				text = "File Explorer",
				text_align = "left",
				separator = true
			}
		},
		color_icons = true,
		show_buffer_icons = true,
		show_buffer_close_icons = true,
		show_buffer_default_icon = true,
		show_close_icon = false,
		show_tab_indicators = true,
		show_duplicate_prefix = true,
		persist_buffer_sort = true,
		separator_style = "thick",
		enforce_regular_tabs = false,
		always_show_bufferline = true,
		hover = {
			enabled = true,
			delay = 200,
			reveal = { "close" }
		},
		sort_by = "insert_after_current"
	}
}
