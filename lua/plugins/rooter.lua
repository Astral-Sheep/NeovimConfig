return {
	--- Source ---
	'airblade/vim-rooter',

	--- Setup ---
	config = function()
		local g = vim.g
		g.rooter_targets = '*'
		g.rooter_patterns = { '.git', '*.sln', 'MakeFile', '*.godot', '*.uproject' }
	end
}
