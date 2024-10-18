return { -- Indentation lines
	--- Source ---
	'lukas-reineke/indent-blankline.nvim',

	--- Setup ---
	opts = {
		enabled = true,                    -- Enables or disables indent-blankline
		debounce = 200,                    -- Sets the amount indent-blankline debounces refreshes in milliseconds
		viewport_buffer = {                -- Configures the viewport of where indentation guides are generated
			min = 30,                      -- Minimum number of lines above and below of what is currently visible in the window for which indentation guides will be generated
			-- max = 500                   -- [deprecated] Maximum number of lines above and below of what is currently visible in the window for which indentation guides will be generated
		},
		indent = {                         -- Configures the indentation
			char = '▏',                    -- Character, or list of characters, that get used to display the indentation guide. Each character has to habe a display of O or 1
			-- Default: `▎`
			--
			-- Alternatives:
			-- - left aligned solid
			--   `▏`
			--   `▎` (default)
			--   `▍`
			--   `▌`
			--   `▋`
			--   `▊`
			--   `▉`
			--   `█`
			-- - center aligned solid
			--   `│`
			--   `┃`
			-- - right aligned solid
			--   `▕`
			--   `▐`
			-- - center aligned dashed
			--   `╎`
			--   `╏`
			--   `┆`
			--   `┇`
			--   `┊`
			--   `┋`
			-- - center aligned double
			--   `║`
			-- tab_char = '',                 -- Character, or list of characters, that get used to display the indentation guide for tabs. Each character has to have a display width of 0 or 1
			-- highlight = ''                 -- Highlight group, or list of highlight groups, that get applied to the indentation guide
			smart_indent_cap = false,      -- Caps the number of intentation levels by looking at the surrounding code
			priority = 1,                  -- Virtual text priority for the indentation guide
			repeat_linebreak = true,       -- Repeat indentation guide virtual text on wrapped lines if |'breakindent'| is set, and |'breakindentopt'| does not contain any of the following: `column`, `sbr`, `shift` with a negative value
		},
		whitespace = {                     -- Configures the whitespace
			-- highlight = ''                 -- Highlight group, or list of highlight gorup, that getapplied to the whitespace
			remove_blankline_trail = false,-- Removes trailing whitespace on blanklines. Turn this off if you want to add background color to the whitespace highlight group
		},
		scope = {                          -- Configures the scope
			enabled = true,                -- Enables or disables scope
			-- char = '',                     -- Character, or list of characters, that get used to display the scope indentation guide. Each character has to have a display width of 0 or 1
			show_start = true,             -- Shows an underline on the first line of the scope
			show_end = true,               -- Shows an underline on the last line of the scope
			show_exact_scope = true,       -- Shows an underline on the first line of the scope starting at the exact start of the scope (even if this is to the right of the indent guide) and an underline on the last line of the scope ending at the exact end of the scope
			injected_languages = true,     -- Checks for the current scope in injected treesitter languages. This also influences if the scope gets excluded or not
			-- highlight = '',             -- Highlight group, or list of highlight groups, that get applied to the scope
			priority = 1024,               -- Virtual text priority for the scope
			-- include = '',               -- Configures additional nodes to be used as scope
			-- exclude = '',               -- Configures nodes or languages to be excluded from scope
		},
		exclude = {                        -- Configures nodes or languages to be excluded from ibl
			filetypes = {
				'lspinfo',
				'packer',
				'checkhealth',
				'help',
				'man',
				'gitcommit',
				'startify',
				'alpha',
				'TelescopePrompt',
				'TelescopeResults',
				'',
			},
			buftypes = {
				'terminal',
				'nofile',
				'quickfix',
				'prompt',
			}
		},
	},
	main = 'ibl',

	--- Lazy Loading ---
	lazy = true,
	event = 'BufRead',
}
