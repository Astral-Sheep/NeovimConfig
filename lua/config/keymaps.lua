vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local map = vim.keymap

map.set('n', '<C-F1>', ':q<CR>', { desc = "Close current window" })
map.set('n', '<CS-F1>', ':qa<CR>', { desc = "Close all windows" })

map.set('n', '<C-z>', 'u', { desc = "Undo" })
map.set('n', '<C-y>', '<C-r>', { desc = "Redo" })
map.set('n', '<C-s>', ':w<CR>', { desc = "Save" })
map.set('n', '<S-s>', ':w!<CR>', { desc = "Overwrite file" })
map.set('i', 'C-z', '<u>', { desc = "Undo" })
map.set('i', 'C-y', '<C-r>', { desc = "Redo" })

map.set('n', '<CS-Up>', ':res +2<CR>', { silent = true, desc = "Increase window vertical size" })
map.set('n', '<CS-Down>', ':res -2<CR>', { silent = true, desc = "Decrease window vertical size" })
map.set('n', '<CS-Left>', ':vert res +2<CR>', { silent = true, desc = "Increase window horizontal size" })
map.set('n', '<CS-Right>', ':vert res -2<CR>', { silent = true, desc = "Decrease window horizontal size" })

map.set('n', '<C-Left>', '<C-w>h', { silent = true, desc = "Go to left window" })
map.set('n', '<C-Right>', '<C-w>l', { silent = true, desc = "Go to right window" })
map.set('n', '<C-Up>', '<C-w>k', { silent = true, desc = "Go to top window" })
map.set('n', '<C-Down>', '<C-w>j', { silent = true, desc = "Go to bottom window" })

map.set('n', '<C-n>', ':vs<CR>', { desc = "Create a new window on the right of the editor" })
map.set('n', '<S-n>', ':sp<CR>', { desc = "Create a new window at the bottom of the editor" })
map.set('n', '<C-S-F4>', ':bdelete<CR>', { silent = true, desc = "Close current buffer and its window if there are more than one" })
map.set('n', '<TAB>', ':bn<CR>', { silent = true, desc = "Go to the next buffer" })
map.set('n', '<S-TAB>', ':bp<CR>', { silent = true, desc = "Go to the previous buffer" })
map.set('n', '<S-b>', ':tabnew<CR>', { silent = true, desc = "Create a new buffer" })

map.set('t', '<Esc>', '<C-\\><C-n>')
