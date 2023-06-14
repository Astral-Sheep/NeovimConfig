# Lua Configuration

## Made for:

Neovim version: 0.9.0

## Installation Guide:

**Use** `:PackerSync` **in neovim to install all plugins.**

If highlighting is going crazy, **use** `:TSInstall` **in neovim**

It's now ready to use.

## Keymaps:

### Global keymaps

Normal mode: 

- Ctrl+F1 (:q\<CR>) -> Close the current window, and if it's the last one, close Neovim

- Ctrl+Shift+F1 (:q!\<CR>) -> Close the current window and ignore unsaved files

- Ctrl+Z (u) -> Undo last modification

- Ctrl+Y (\<C-r>) -> Redo last modification

- Ctrl+S (:up\<CR>) -> Save the file

- Shift+S (:up!\<CR>) -> Overwrite the file (mostly used when getting a message saying the file already exists)

- Ctrl+Shift+Up (:resize -2\<CR>:\<BS>) -> Decrease window vertical size

- Ctrl+Shift+Down (:resize +2\<CR>:\<BS>) -> Increase window vertical size

- Ctrl+Shift+Left (:vertical resize +2\<CR>:\<BS>) -> Increase window horizontal size

- Ctrl+Shift+Right (:vertical resize -2\<CR>:\<BS>) -> Decrease window horizontal size

- Ctrl+Left (\<C-w>h) -> Go to left window

- Ctrl+Right (\<C-w>l) -> Go to right window

- Ctrl+Up (\<C-w>k) -> Go to top window

- Ctrl+Down (\<C-w>j) -> Go to bottom window

- Ctrl+N (:vs\<CR>) -> Create a new window on the right

- Shift+N (:sp\<CR>) -> Create a new window at the bottom

- Ctrl+F4 (:bdelete\<CR>:\<BS>) -> Close current buffer

- Tab (:bnext\<CR>:\<BS>) -> Go to the next buffer

- Shift+Tab (:bprev\<CR>:\<B>) -> Go to the previous buffer

- Shift+B (:tabnew\<CR>:\<BS>) -> Create a new empty buffer

Insert mode:

- Ctrl+Z (\<u>) -> Undo last modification

- Ctrl+Y (\<C-r>) -> Redo last modification

### CMP keymaps

Insert mode:

- Ctrl+Space (cmp.mapping.complete()) -> Trigger autocompletion options

- Enter (cmp.mapping.confirm({ select = true}) -> Select autocompletion option

### LSP keymaps

Normal mode:

- gd (vim.lsp.buf.definition) -> Go to the definition

- gi (vim.lsp.buf.implementation) -> Go to the implementation

- gr (telescope.lsp_references) -> List the references

- gh (vim.lsp.buf.hover) -> Show additional information

- Ctrl+R+R (vim.lsp.buf.rename) -> Rename the current symbol (variable, function...)

### NvimTree keymaps

Normal mode:

- Ctrl+B (:NvimTreeFindFileToggle) -> Toggle the file explorer window

### Telescope keymaps

Normal mode:

- Ctrl+P (telescope.find_files) -> Find a file by name

- Shift+P (telescope.oldfiles) -> Show a list of recently opened files

- Ctrl+F (telescope.live_grep) -> Find a word or a word list in a file

- Shift+F (telescope.help_tags) -> Show a list of commands

### Aerial keymaps

Normal mode:

- Ctrl+M (\<cmd>AerialToggle!\<CR>) -> Toggle code outline window

- , (\<cmd>AerialPrev\<CR>) -> Go to the previous symbol

- ; (\<cmd>AerialNext\<CR>) -> Go to the next symbol
