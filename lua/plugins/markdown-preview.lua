return {
	--- Source ---
	'iamcco/markdown-preview.nvim',

	--- Setup ---
	config = function()
		local g = vim.g

		-- Set to 1, nvim will open the preview window after entering the Markdown buffer
		-- Default: 0
		g.mkdp_auto_start = 0

		-- Set to 1, Vim will refresh Markdown when saving the buffer or
		-- When leaving insert mode. Default 0 is auto-refresh Markdown as you edit or
		-- Move the cursor
		-- Default: 0
		g.mkdp_refresh_slow = 0

		-- Set to 1, the MarkdownPreview command can be used for all files,
		-- By default it can be use in Markdown files only
		-- Default: 0
		g.mkdp_command_for_global = 0

		-- Set to 1, the preview server is available to others in your network.
		-- By default, the server listens on localhost (127.0.0.1)
		-- Default: 0
		g.mkdp_open_to_the_world = 0

		-- Use custom IP to open preview page.
		-- Useful when you work in remote Vim and preview on local browser.
		-- For more details see: https://github.com/iamcco/markdown-preview.nvim/pull/9
		-- Default: empty
		g.mkdp_open_ip = ''

		-- Specify browser to open preview page
		-- For path with space
		-- Valid: `/path/with\ space/xxx`
		-- Invalid: `/path/with\\ space/xxx`
		-- Default: ''
		g.mkdp_browser = ''

		-- Set to 1, echo preview page URL in command line when opening preview page
		-- Default: 0
		g.mkdp_echo_preview_url = 0

		-- A custom Vim function name to open preview page
		-- This function will receive URL as param
		-- Default: empty
		g.mkdp_browserfunc = ""

		-- Options for Markdown rendering
		-- mkit: markdown-it options for rendering
		-- katex: KaTeX options for math
		-- uml: markdown-it-plantuml options
		-- maid: mermaid options
		-- disable_sync_scroll: whether to disable sync scroll. Default: 0
		-- sync_scroll_type: 'middle', 'top' or 'relative'. Default: 'middle'
		--   middle: means the cursor position is always in the middle of the preview page
		--   top: means the Vim top viewport always shows up at the top of the preview page
		--   relative: means the cursor position is always at the relative positon of the preview page
		-- hide_yaml_meta: whether to hide YAML metadata. Default: 1
		-- sequence_diagrams: js-sequence-diagrams options
		-- content_editable: if enable content editable for preview page. Default: v:false
		-- disable_filename: if disable filename header for preview page. Default: 0
		g.mkdp_preview_options = {
			mkit = {},
			katex = {},
			uml = {},
			maid = {},
			disable_sync_scroll = 0,
			sync_scroll_type = 'middle',
			hide_yaml_meta = 1,
			sequence_diagrams = {},
			flowchart_diagrams = {},
			content_editable = false,
			disable_filename = 0,
			toc = {}
		}

		-- Use a custom Markdown style. Must be an absolute path
		-- Like '/Users/username/markdown.css' or expand('~/markdown.css')
		g.mkdp_markdown_css = ''

		-- Use a custom highlight style. Must be an absolute path
		-- Like '/Users/username/highlight.css' or expand('~/highlight.css')
		g.mkdp_highlight_css = ''

		-- Use a custom port to start server or empty for random
		g.mkdp_port = ''

		-- Preview page title
		-- ${name} will be replace with the file name
		g.mkdp_page_title = "「${name}」"

		-- Use a custom location for images
		g.mkdp_images_path = ''

		-- Recognized filetypes
		-- These filetypes will have MarkdownPreview... commands
		g.mkdp_filetypes = { 'markdown' }

		-- Set default theme (dark or light)
		-- By default the theme is defined according to the preferences of the system
		g.mkdp_theme = 'dark'

		-- Combine preview window
		-- Default: 0
		-- If enabled it will reuse previous opened preview window when you preview markdown file.
		-- Ensure to set let g:mkdp_auto_close = 0 if you have enabled this option
		g.mkdp_combine_preview = 0

		-- Auto refetch combine preview contents when change markdown buffer
		-- Only when g:mkdp_combine_preview is 1
		g.mkdp_combine_preview_auto_refresh = 1
	end,
	build = function()
		vim.fn["mkdp#util#install"]()
	end,

	--- Lazy Loading ---
	lazy = true,
	ft = 'markdown',
}
