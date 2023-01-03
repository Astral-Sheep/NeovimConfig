vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local map = vim.keymap

map.set('n', '<C-F1>', ':q<CR>', { desc = "Close current tab" })
map.set('n', '<C-S-F1>', ':q!<CR>', { desc = "Close current tab without saving" })

map.set('n', '<C-z>', 'u', { desc = "Undo" })
map.set('n', '<C-y>', '<C-r>', { desc = "Redo" })
map.set('n', '<C-s>', ':up<CR>', { desc = "Save" })
map.set('i', 'C-z', '<u>', { desc = "Undo" })
map.set('i', 'C-y', '<C-r>', { desc = "Redo" })

map.set('n', '<C-S-Up>', ':resize -2<CR>:<BS>', { desc = "Decrease tab vertical size" })
map.set('n', '<C-S-Down>', ':resize +2<CR>:<BS>', { desc = "Increase tab vertical size" })
map.set('n', '<C-S-Left>', ':vertical resize +2<CR>:<BS>', { desc = "Increase tab horizontal size" })
map.set('n', '<C-S-Right>', ':vertical resize -2<CR>:<BS>', { desc = "Decrease tab horizontal size" })

map.set('n', '<C-Left>', '<C-w>h', { desc = "Go to left tab" })
map.set('n', '<C-Right>', '<C-w>l', { desc = "Go to right tab" })
map.set('n', '<C-Up>', '<C-w>k', { desc = "Go to top tab" })
map.set('n', '<C-Down>', '<C-w>j', { desc = "Go to bottom tab" })

map.set('n', '<C-F4>', ':bdelete<CR>:<BS>', { desc = "Close current buffer" })
map.set('n', '<TAB>', ':bnext<CR>:<BS>', { desc = "Goes to the next buffer" })
map.set('n', '<S-TAB>', ':bprev<CR>:<BS>', { desc = "Goes to the previous buffer" })
map.set('n', '<C-n>', ':tabnew<CR>:<BS>', { desc = "Creates a new buffer" })

map.set('t', '<Esc>', '<C-\\><C-n>')
