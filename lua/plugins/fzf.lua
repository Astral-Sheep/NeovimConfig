return {
    --- Source ---
    'ibhagwan/fzf-lua',

    --- Loading ---
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },

    --- Setup ---
    opts = {
        winopts = {
            height = 0.95,
            width = 0.95,
            border = 'rounded',
            backdrop = 100,
            fullscreen = false,
            treesitter = {
                enabled = true,
                fzf_colors = {
                    ["hl"] = "-1:reverse",
                    ["hl+"] = "-1:reverse",
                },
            },
            preview = {
                border = 'rounded',
                wrap = true,
                hidden = false,
                horizontal = 'right:50%',
                layout = "horizontal",
                winopts = {
                    number = true,
                    relativenumber = false,
                    cursorline = true,
                    cursorlineopt = "both",
                    cursorcolumn = true,
                    signcolumn = "no",
                    list = false,
                    foldenable = true,
                    foldmethod = "manual",
                }
            },
        },
        keymap = {
            builtin = {
                false,
            },
            fzf = {
                false,
            },
        },
        default = {
            prompt = "󱞩 ",
        },
    },
    config = function(_, opts)
        require('fzf-lua').setup(opts)

        local map = vim.keymap

		map.set('n', '<C-p>', FzfLua.files, {
			silent = true,
			desc = "Find files with Fzf",
		})
		map.set('n', '<S-p>', FzfLua.oldfiles, {
			silent = true,
			desc = "Display list of last opened files with Fzf",
		})
		map.set('n', '<C-f>', FzfLua.live_grep, {
			silent = true,
			desc = "Find character sequences in current file",
		})
		map.set('n', '<S-f>', FzfLua.tags, {
			silent = true,
			desc = "Display list of plugin help files",
		})
    end,

    --- Lazy loading ---
    lazy = false,
}