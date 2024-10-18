-- vim.cmd[[
-- " Delete buffer while keeping window layout (don't close buffer's windows).
-- " Version 2008-11-18 from http://vim.wikia.com/wiki/VimTip165
-- if v:version < 700 || exists('loaded_bclose') || &cp
--   finish
-- endif
-- let loaded_bclose = 1
-- if !exists('bclose_multiple')
--   let bclose_multiple = 1
-- endif

-- " Display an error message.
-- function! s:Warn(msg)
--   echohl ErrorMsg
--   echomsg a:msg
--   echohl NONE
-- endfunction

-- " Command ':Bclose' executes ':bd' to delete buffer in current window.
-- " The window will show the alternate buffer (Ctrl-^) if it exists,
-- " or the previous buffer (:bp), or a blank buffer if no previous.
-- " Command ':Bclose!' is the same, but executes ':bd!' (discard changes).
-- " An optional argument can specify which buffer to close (name or number).
-- function! s:Bclose(bang, buffer)
--   if empty(a:buffer)
--     let btarget = bufnr('%')
--   elseif a:buffer =~ '^\d\+$'
--     let btarget = bufnr(str2nr(a:buffer))
--   else
--     let btarget = bufnr(a:buffer)
--   endif
--   if btarget < 0
--     call s:Warn('No matching buffer for '.a:buffer)
--     return
--   endif
--   if empty(a:bang) && getbufvar(btarget, '&modified')
--     call s:Warn('No write since last change for buffer '.btarget.' (use :Bclose!)')
--     return
--   endif
--   " Numbers of windows that view target buffer which we will delete.
--   let wnums = filter(range(1, winnr('$')), 'winbufnr(v:val) == btarget')
--   if !g:bclose_multiple && len(wnums) > 1
--     call s:Warn('Buffer is in multiple windows (use ":let bclose_multiple=1")')
--     return
--   endif
--   let wcurrent = winnr()
--   for w in wnums
--     execute w.'wincmd w'
--     let prevbuf = bufnr('#')
--     if prevbuf > 0 && buflisted(prevbuf) && prevbuf != btarget
--       buffer #
--     else
--       bprevious
--     endif
--     if btarget == bufnr('%')
--       " Numbers of listed buffers which are not the target to be deleted.
--       let blisted = filter(range(1, bufnr('$')), 'buflisted(v:val) && v:val != btarget')
--       " Listed, not target, and not displayed.
--       let bhidden = filter(copy(blisted), 'bufwinnr(v:val) < 0')
--       " Take the first buffer, if any (could be more intelligent).
--       let bjump = (bhidden + blisted + [-1])[0]
--       if bjump > 0
--         execute 'buffer '.bjump
--       else
--         execute 'enew'.a:bang
--       endif
--     endif
--   endfor
--   execute 'bdelete'.a:bang.' '.btarget
--   execute wcurrent.'wincmd w'
-- endfunction
-- command! -bang -complete=buffer -nargs=? Bclose call <SID>Bclose(<q-bang>, <q-args>)
-- nnoremap <silent> <C-F4> :Bclose<CR>
-- ]]

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

map.set('n', '<CS-Up>', ':resize -2<CR>', { silent = true, desc = "Decrease window vertical size" })
map.set('n', '<CS-Down>', ':resize +2<CR>', { silent = true, desc = "Increase window vertical size" })
map.set('n', '<CS-Left>', ':vertical resize +2<CR>', { silent = true, desc = "Increase window horizontal size" })
map.set('n', '<CS-Right>', ':vertical resize -2<CR>', { silent = true, desc = "Decrease window horizontal size" })

map.set('n', '<C-Left>', '<C-w>h', { silent = true, desc = "Go to left window" })
map.set('n', '<C-Right>', '<C-w>l', { silent = true, desc = "Go to right window" })
map.set('n', '<C-Up>', '<C-w>k', { silent = true, desc = "Go to top window" })
map.set('n', '<C-Down>', '<C-w>j', { silent = true, desc = "Go to bottom window" })

map.set('n', '<C-n>', ':vs<CR>', { desc = "Create a new window on the right of the editor" })
map.set('n', '<S-n>', ':sp<CR>', { desc = "Create a new window at the bottom of the editor" })
map.set('n', '<C-S-F4>', ':bdelete<CR>', { silent = true, desc = "Close current buffer and its window if there are more than one" })
map.set('n', '<TAB>', ':bnext<CR>', { silent = true, desc = "Go to the next buffer" })
map.set('n', '<S-TAB>', ':bprev<CR>', { silent = true, desc = "Go to the previous buffer" })
map.set('n', '<S-b>', ':tabnew<CR>', { silent = true, desc = "Create a new buffer" })

map.set('t', '<Esc>', '<C-\\><C-n>')
