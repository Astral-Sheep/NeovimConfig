return {
	--- Source ---
	'Astral-Sheep/alpha-nvim',

	--- Setup ---
	config = function()
		local btn_width = 35
		local dashboard = require('alpha.themes.dashboard')
		dashboard.set_width(btn_width)

		local function center_text(text, width)
			local total_padding = width - #text
			local left_padding = math.floor(total_padding / 2)
			local right_padding = total_padding - left_padding
			return string.rep(" ", left_padding) .. text .. string.rep(" ", right_padding)
		end

		local function text(txt, highlight, pos)
			return { type = 'text', val = txt, opts = { hl = highlight, position = pos } }
		end

		local v = vim.version()

		dashboard.section.header.val = {
			" ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
			" ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
			" ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
			" ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
			" ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
			" ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
			"",
			center_text(" v" .. v.major .. "." .. v.minor .. "." .. v.patch, 55),
		}

		-- dashboard.config.layout[1].val = 2
		-- dashboard.config.layout[2].val = 2
		-- dashboard.config.layout[3].val = 2
		-- dashboard.section.header.val = {
		-- 	'',
    		-- "   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣭⣿⣶⣿⣦⣼⣆         ",
    		-- "    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ",
    		-- "          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷⠄⠄⠄⠄⠻⠿⢿⣿⣧⣄     ",
    		-- "           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ",
    		-- "          ⢠⣿⣿⣿⠈  ⠡⠌⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ",
    		-- "   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘⠄ ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ",
    		-- "  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ",
    		-- " ⣠⣿⠿⠛⠄⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ",
    		-- " ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇⠄⠛⠻⢷⣄ ",
    		-- "      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ",
    		-- "       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ",
    		-- "     ⢰⣶  ⣶ ⢶⣆⢀⣶⠂⣶⡶⠶⣦⡄⢰⣶⠶⢶⣦  ⣴⣶     ",
    		-- "     ⢸⣿⠶⠶⣿ ⠈⢻⣿⠁ ⣿⡇ ⢸⣿⢸⣿⢶⣾⠏ ⣸⣟⣹⣧    ",
    		-- "     ⠸⠿  ⠿  ⠸⠿  ⠿⠷⠶⠿⠃⠸⠿⠄⠙⠷⠤⠿⠉⠉⠿⠆   ",
		-- 	"",
		-- 	center_text(" v" .. v.major .. "." .. v.minor .. "." .. v.patch, 35),
		-- }

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

		dashboard.section.buttons.val = {
			-- text("  v" .. v.major .. "." .. v.minor .. "." .. v.patch, 'SpecialComment', 'center'),
			dashboard.button('e', "  Empty file", ':ene <BAR> startinsert<CR>'),
			dashboard.button('s l', "  Last session", ":'0<CR>"),
			dashboard.button('f f', "  Find file", ':Telescope find_files<CR>'),
			dashboard.button('f e', "  File explorer", ':NvimTreeOpen<CR>'),
			dashboard.button('f w', "󰈭  Find word", ':Telescope find_word<CR>'),
			dashboard.button('c', "  Configuration", ':cd ' .. vim.fn.stdpath("config") .. '<CR>'),
			dashboard.button('q', "󰅚  Quit", ':qa<CR>'),
		}

		local stats = require('lazy').stats()

		dashboard.section.footer.val = {
			center_text(string.rep('—', btn_width), btn_width),
			center_text("   Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins" , btn_width),
			center_text(string.rep('—', btn_width), btn_width),
		}

		require('alpha').setup(dashboard.opts)
		vim.cmd('autocmd FileType alpha setlocal nofoldenable')

		-- Display startup time on UIEnter
		vim.api.nvim_create_autocmd('UIEnter', {
			once = true,
			callback = function()
				local l_stats = require('lazy').stats()
				dashboard.section.footer.val = {
					center_text(string.rep('—', btn_width), btn_width),
					center_text("   Loaded " .. l_stats.loaded .. "/" .. l_stats.count .. " plugins in " .. math.floor(l_stats.startuptime) .. " ms", btn_width),
					center_text(string.rep('—', btn_width), btn_width),
				}
				vim.cmd(':AlphaRedraw')
			end
		})
	end,

	--- Lazy Loading ---
	lazy = false,
}
