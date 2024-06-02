vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local map = vim.keymap

map.set('n', '<C-F1>', ':q<CR>', { desc = "Close current window" })
map.set('n', '<CS-F1>', ':q!<CR>', { desc = "Close current window without saving" })

map.set('n', '<C-z>', 'u', { desc = "Undo" })
map.set('n', '<C-y>', '<C-r>', { desc = "Redo" })
map.set('n', '<C-s>', ':w<CR>', { desc = "Save" })
map.set('n', '<S-s>', ':w!<CR>', { desc = "Overwrite file" })
map.set('i', 'C-z', '<u>', { desc = "Undo" })
map.set('i', 'C-y', '<C-r>', { desc = "Redo" })

map.set('n', '<CS-Up>', ':resize -2<CR>:<BS>', { desc = "Decrease window vertical size" })
map.set('n', '<CS-Down>', ':resize +2<CR>:<BS>', { desc = "Increase window vertical size" })
map.set('n', '<CS-Left>', ':vertical resize +2<CR>:<BS>', { desc = "Increase window horizontal size" })
map.set('n', '<CS-Right>', ':vertical resize -2<CR>:<BS>', { desc = "Decrease window horizontal size" })

map.set('n', '<C-Left>', '<C-w>h', { desc = "Go to left window" })
map.set('n', '<C-Right>', '<C-w>l', { desc = "Go to right window" })
map.set('n', '<C-Up>', '<C-w>k', { desc = "Go to top window" })
map.set('n', '<C-Down>', '<C-w>j', { desc = "Go to bottom window" })

map.set('n', '<C-n>', ':vs<CR>', { desc = "Create a new window on the right of the editor" })
map.set('n', '<S-n>', ':sp<CR>', { desc = "Create a new window at the bottom of the editor" })
map.set('n', '<C-F4>', ':bdelete<CR>:<BS>', { desc = "Close current buffer" })
map.set('n', '<TAB>', ':bnext<CR>:<BS>', { desc = "Go to the next buffer" })
map.set('n', '<S-TAB>', ':bprev<CR>:<BS>', { desc = "Go to the previous buffer" })
map.set('n', '<S-b>', ':tabnew<CR>:<BS>', { desc = "Create a new buffer" })

map.set('t', '<Esc>', '<C-\\><C-n>')

