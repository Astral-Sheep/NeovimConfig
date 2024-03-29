local g = vim.g
g.startify_fortune_use_unicode = 1
g.startify_padding_left = 10
g.startify_enabled_special = 1

vim.cmd [[
	let g:startify_custom_indices = map(range(1, 100), 'string(v:val)')

	let g:ascii = [
		\'          ┌┼┼┬╴                    ├┼┬╴',
		\'        ┌┼┼┼┼┼┼┬╴                  ├┼┼┼┬╴',
		\'      ┌┼┼┼┼┼┼┼┼┼┬╴                 ├┼┼┼┼┼┬╴',
		\'   ╶┬┼┼┼┼┼┼┼┼┼┼┼┼┼┐                ├┼┼┼┼┼┼┼┬╴',
		\' ╶┬╴└┼┼┼┼┼┼┼┼┼┼┼┼┼┼┬╴              ├┼┼┼┼┼┼┼┼┼┬┬╴',
		\'┌┼┼┼╴ └┼┼┼┼┼┼┼┼┼┼┼┼┼┼╴             ├┼┼┼┼┼┼┼┼┼┼┼┼╴',
		\'├┼┼┼┼┬╴└┼┼┼┼┼┼┼┼┼┼┼┼┼┼┬╴           ├┼┼┼┼┼┼┼┼┼┼┼┼╴',
		\'├┼┼┼┼┼┬╴╶┼┼┼┼┼┼┼┼┼┼┼┼┼┼┬╴          ├┼┼┼┼┼┼┼┼┼┼┼┼╴',
		\'├┼┼┼┼┼┼┼┬╴└┼┼┼┼┼┼┼┼┼┼┼┼┼┼┬╴        ├┼┼┼┼┼┼┼┼┼┼┼┼╴',
		\'├┼┼┼┼┼┼┼┼┬╴╶┼┼┼┼┼┼┼┼┼┼┼┼┼┼┬╴       ├┼┼┼┼┼┼┼┼┼┼┼┼╴',
		\'├┼┼┼┼┼┼┼┼┼┼┬╴└┼┼┼┼┼┼┼┼┼┼┼┼┼┼┬╴     ├┼┼┼┼┼┼┼┼┼┼┼┼╴',
		\'├┼┼┼┼┼┼┼┼┼┼┼┐ ╶┼┼┼┼┼┼┼┼┼┼┼┼┼┼┬╴    ├┼┼┼┼┼┼┼┼┼┼┼┼╴',
		\'├┼┼┼┼┼┼┼┼┼┼┼┤   └┼┼┼┼┼┼┼┼┼┼┼┼┼┼╴   ├┼┼┼┼┼┼┼┼┼┼┼┼╴',
		\'├┼┼┼┼┼┼┼┼┼┼┼┤    └┼┼┼┼┼┼┼┼┼┼┼┼┼┼┬╴ ├┼┼┼┼┼┼┼┼┼┼┼┼╴',
		\'├┼┼┼┼┼┼┼┼┼┼┼┤      └┼┼┼┼┼┼┼┼┼┼┼┼┼┼╴╶┼┼┼┼┼┼┼┼┼┼┼┼╴',
		\'├┼┼┼┼┼┼┼┼┼┼┼┤       └┼┼┼┼┼┼┼┼┼┼┼┼┼┼┬╴└┼┼┼┼┼┼┼┼┼┼╴',
		\'├┼┼┼┼┼┼┼┼┼┼┼┤        ╶┼┼┼┼┼┼┼┼┼┼┼┼┼┼┬╴╶┼┼┼┼┼┼┼┼┼╴',
		\'├┼┼┼┼┼┼┼┼┼┼┼┤          └┼┼┼┼┼┼┼┼┼┼┼┼┼┼┬╴└┼┼┼┼┼┼┼╴',
		\'├┼┼┼┼┼┼┼┼┼┼┼┤           ╶┼┼┼┼┼┼┼┼┼┼┼┼┼┼┬╴└┼┼┼┼┼┼╴',
		\'├┼┼┼┼┼┼┼┼┼┼┼┤             └┼┼┼┼┼┼┼┼┼┼┼┼┼┼┬╴└┼┼┼┼╴',
		\'└┼┼┼┼┼┼┼┼┼┼┼┤              ╶┼┼┼┼┼┼┼┼┼┼┼┼┼┼┬╴└┼┼┴╴',
		\'  ╶┴┼┼┼┼┼┼┼┼┤                └┼┼┼┼┼┼┼┼┼┼┼┼┼┼╴',
		\'    ╶┴┼┼┼┼┼┼┤                 └┼┼┼┼┼┼┼┼┼┼┼┼┴╴',
		\'       └┤├┼┼┤                  ╶┴┼┼┼┼┼┼┼┴┴╴',
		\'         └┼┼┤                    └┼┼┼┼┴╴',
		\'           └┤                     ╶┴┴╴',
	\]

	let g:startify_custom_header = 'startify#pad(g:ascii + startify#fortune#boxed())'

	let g:startify_custom_footer = [
		\'============================================================================================================================================================================================================================================',
		\'============================================================================================================================================================================================================================================'
	\]
]]
