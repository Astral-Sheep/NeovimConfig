local dashboard = require('alpha.themes.dashboard')

local function center_text(text, width)
	local total_padding = width - #text
	local left_padding = math.floor(total_padding / 2)
	local right_padding = total_padding - left_padding
	return string.rep(' ', left_padding) .. text .. string.rep(' ', right_padding)
end

local function text(txt, highlight, pos)
	return { type = 'text', val = txt, opts = { hl = highlight, position = pos } }
end

dashboard.section.header.val = {
	"███╗░░██╗██╗░░░██╗██╗███╗░░░███╗",
	"████╗░██║██║░░░██║██║████╗░████║",
	"██╔██╗██║╚██╗░██╔╝██║██╔████╔██║",
	"██║╚████║░╚████╔╝░██║██║╚██╔╝██║",
	"██║░╚███║░░╚██╔╝░░██║██║░╚═╝░██║",
	"╚═╝░░╚══╝░░░╚═╝░░░╚═╝╚═╝░░░░░╚═╝",
}

local v = vim.version()

dashboard.section.buttons.val = {
	text("  v" .. v.major .. "." .. v.minor .. "." .. v.patch, 'SpecialComment', 'center'),
	-- text(os.date('%a %d %b'), 'SpecialComment', 'center'),
	-- text(os.date('%H:%M'), 'SpecialComment', 'center'),
	dashboard.button('e', "  Empty file", ':ene <BAR> startinsert<CR>'),
	dashboard.button('s l', "  Last session", ":'0<CR>"),
	dashboard.button('f f', "  Find file", ':Telescope find_files<CR>'),
	dashboard.button('f e', "  File explorer", ':NvimTreeOpen<CR>'),
	dashboard.button('f w', "󰈭  Find word", ':Telescope find_word<CR>'),
	dashboard.button('c', "  Configuration", ":cd stdpath('config')<CR>"),
	dashboard.button('q', "󰅚  Quit", ':qa<CR>'),
}

dashboard.section.footer.val = {
	center_text(string.rep('—', 35), 35),
	-- center_text(fortune, 35),
	-- center_text("  Loaded " .. 0 .. "/" .. plugin_count .. " plugins in " .. 0 .. " ms", 35),
	center_text(string.rep('—', 35), 35),
}

-- local handle = io.popen('fortune')
-- local fortune = handle:read("*a")
-- handle:close()

require('alpha').setup(dashboard.opts)

vim.cmd('autocmd FileType alpha setlocal nofoldenable')
