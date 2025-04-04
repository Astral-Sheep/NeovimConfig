local WIDTH = 35

local function center_text(text, width)
	local total_padding = width - #text
	local left_padding = math.floor(total_padding / 2)
	local right_padding = total_padding - left_padding
	return string.rep(" ", left_padding) .. text .. string.rep(" ", right_padding)
end

local function text(txt, highlight, pos)
	return { type = 'text', val = txt, opts = { hl = highlight, position = pos } }
end

local function set_stats()
	local l_stats = require('lazy').stats()
	require('alpha.themes.dashboard').section.footer.val = {
		center_text(string.rep('—', WIDTH), WIDTH),
		center_text("   Loaded " .. l_stats.loaded .. "/" .. l_stats.count .. " plugins in " .. math.floor(l_stats.startuptime) .. " ms", WIDTH),
		center_text(string.rep('—', WIDTH), WIDTH),
	}
	vim.cmd(':AlphaRedraw')
end

return {
	--- Source ---
	'Astral-Sheep/alpha-nvim',

	--- Setup ---
	config = function()
		local dashboard = require('alpha.themes.dashboard')
		dashboard.set_width(WIDTH)
		local v = vim.version()

		-- Set header
		-- dashboard.section.header.val = {
		-- 	" ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
		-- 	" ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
		-- 	" ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
		-- 	" ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
		-- 	" ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
		-- 	" ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
		-- 	"",
		-- 	center_text(" v" .. v.major .. "." .. v.minor .. "." .. v.patch, 55),
		-- }

		dashboard.config.layout[1].val = 1
		dashboard.config.layout[2].val = 1
		dashboard.config.layout[3].val = 1
		dashboard.section.header.val = {
			'',
    		"   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣭⣿⣶⣿⣦⣼⣆         ",
    		"    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ",
    		"          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷⠄⠄⠄⠄⠻⠿⢿⣿⣧⣄     ",
    		"           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ",
    		"          ⢠⣿⣿⣿⠈  ⠡⠌⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ",
    		"   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘⠄ ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ",
    		"  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ",
    		" ⣠⣿⠿⠛⠄⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ",
    		" ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇⠄⠛⠻⢷⣄ ",
    		"      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ",
    		"       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ",
    		-- "     ⢰⣶  ⣶ ⢶⣆⢀⣶⠂⣶⡶⠶⣦⡄⢰⣶⠶⢶⣦  ⣴⣶     ",
    		-- "     ⢸⣿⠶⠶⣿ ⠈⢻⣿⠁ ⣿⡇ ⢸⣿⢸⣿⢶⣾⠏ ⣸⣟⣹⣧    ",
    		-- "     ⠸⠿  ⠿  ⠸⠿  ⠿⠷⠶⠿⠃⠸⠿⠄⠙⠷⠤⠿⠉⠉⠿⠆   ",
			"",
			center_text(" v" .. v.major .. "." .. v.minor .. "." .. v.patch, 35),
		}

		-- dashboard.section.header.val = {
		-- 	"                                                                     ",
		-- 	"       ████ ██████           █████      ██                     ",
		-- 	"      ███████████             █████                             ",
		-- 	"      █████████ ███████████████████ ███   ███████████   ",
		-- 	"     █████████  ███    █████████████ █████ ██████████████   ",
		-- 	"    █████████ ██████████ █████████ █████ █████ ████ █████   ",
		-- 	"  ███████████ ███    ███ █████████ █████ █████ ████ █████  ",
		-- 	" ██████  █████████████████████ ████ █████ █████ ████ ██████ ",
		-- 	"                                                                       ",
		-- 	" ——————————————————————————————————————————————————————————————————————",
		-- 	"",
		-- 	center_text(" v" .. v.major .. "." .. v.minor .. "." .. v.patch, 70),
		-- }

		-- dashboard.section.header.val = {
		-- 	"███╗░░██╗██╗░░░██╗██╗███╗░░░███╗",
		-- 	"████╗░██║██║░░░██║██║████╗░████║",
		-- 	"██╔██╗██║╚██╗░██╔╝██║██╔████╔██║",
		-- 	"██║╚████║░╚████╔╝░██║██║╚██╔╝██║",
		-- 	"██║░╚███║░░╚██╔╝░░██║██║░╚═╝░██║",
		-- 	"╚═╝░░╚══╝░░░╚═╝░░░╚═╝╚═╝░░░░░╚═╝",
		-- 	"",
		-- 	center_text(" v" .. v.major .. "." .. v.minor .. "." .. v.patch, 32),
		-- }

		-- Set buttons
		dashboard.section.buttons.val = {
			-- text("  v" .. v.major .. "." .. v.minor .. "." .. v.patch, 'SpecialComment', 'center'),
			dashboard.button('e', "  Empty file", ':ene <BAR> startinsert<CR>'),
			dashboard.button('s l', "  Last session", ":SessionRestore<CR>"),
			dashboard.button('f f', "  Find file", ':Telescope find_files<CR>'),
			dashboard.button('f e', "  File explorer", ':NvimTreeOpen<CR>'),
			dashboard.button('f w', "󰈭  Find word", ':Telescope live_grep<CR>'),
			dashboard.button('c', "  Configuration", ':cd ' .. vim.fn.stdpath("config") .. '<CR>'),
			dashboard.button('q', "󰅚  Quit", ':qa<CR>'),
		}

		-- Set footer
		local stats = require('lazy').stats()

		dashboard.section.footer.val = {
			center_text(string.rep('—', WIDTH), WIDTH),
			center_text("   Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. math.floor(stats.startuptime) .. " ms", WIDTH),
			center_text(string.rep('—', WIDTH), WIDTH),
		}

		require('alpha').setup(dashboard.opts)
		vim.cmd('autocmd FileType alpha setlocal nofoldenable')
		vim.keymap.set('n', 'go', ':%bd<BAR>Alpha<BAR>bd#<CR>', {
			silent = true,
			desc = "Close all buffers and open Alpha",
		})

		-- Display startup time on UIEnter
		vim.api.nvim_create_autocmd('UIEnter', {
			once = true,
			callback = function()
				set_stats()
				vim.api.nvim_create_autocmd('User', {
					pattern = 'AlphaReady',
					callback = set_stats,
				})
			end
		})

		-- Display Alpha when all buffers are closed
		vim.api.nvim_create_autocmd('User', {
			pattern = 'BDeletePre *',
			callback = function()
				local bufnr = vim.api.nvim_get_current_buf()
				local name = vim.api.nvim_buf_get_name(bufnr)

				if name == '' then
					vim.cmd(':Alpha | bd#')
				end
			end
		})
	end,

	--- Lazy Loading ---
	lazy = false,
}
