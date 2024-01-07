require('nvim-web-devicons').setup {
	-- Your personal icons can go here (to override)
	-- You can specify color or cterm_color instead of specifying both of them
	-- DevIcon will be appended to `name`
	override = {
		-- zsh = {
    		-- icon = "",
    		-- color = "#428850",
    		-- cterm_color = "65",
    		-- name = "Zsh"
		-- }
	};
	-- Globally enable different highlight colors per icon (default to true)
	-- If set to false, all icons will have the default icon's color
	color_icons = true;
	-- Globally enable default icons (default to false)
	-- Will get overriden by `get_icons` option
	default = true;
	-- Globally enable "strict" selection of icons
	-- Icon will be looked up in different tables, first by filename, and if not found by extensions; this prevents cases when file doesn't have any extension but still gets some icon because its name happened to match some extension (default to false)
	strict = false;
	-- Same as `override` but specifically for overrides by filename
	-- Takes effect when `strict` is true
	override_by_filename = {
		-- [".gitignore"] = {
    		-- icon = "",
    		-- color = "#f1502f",
    		-- name = "Gitignore"
  		-- }
	};
	-- Same as `override` but specifically for overrides by extension
	-- Takes effect when `strict` is true
	override_by_extension = {
		-- ["log"] = {
    		-- icon = "",
    		-- color = "#81e043",
    		-- name = "Log"
  		-- }
	};
}
