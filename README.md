# NEOVIM CONFIGURATION

## Made for:

OS: Windows 10

Neovim version: 0.9.5

## Default path to install on windows:

C:\Users\{user}\AppData\Local\nvim

## Installation Guide:

Launch Neovim and let Lazy do its thing.

If highlighting is going crazy, **use** `:TSInstall` **in Neovim**

It's now ready to use.

## Keymaps:

Leader key: **Space**

### Global keymaps

Normal mode: 

- **Ctrl+F1** (`:q<CR>`) -> Close the current window, and if it's the last one, close Neovim

- **Ctrl+Shift+F1** (`:qa<CR>`) -> Close all opened windows (equivalent to closing Neovim)

- **Ctrl+Z** (`u`) -> Undo last modification

- **Ctrl+Y** (`<C-r>`) -> Redo last modification

- **Ctrl+S** (`:up<CR>`) -> Save the file

- **Shift+S** (`:w!<CR>`) -> Overwrite the file or save in readonly

- **Ctrl+Shift+Up** (`:res -2<CR>`) -> Decrease window vertical size

- **Ctrl+Shift+Down** (`:res +2<CR>`) -> Increase window vertical size

- **Ctrl+Shift+Left** (`:vert res +2<CR>`) -> Increase window horizontal size

- **Ctrl+Shift+Right** (`:vert res -2<CR>`) -> Decrease window horizontal size

- **Ctrl+Left** (`<C-w>h`) -> Go to left window

- **Ctrl+Right** (`<C-w>l`) -> Go to right window

- **Ctrl+Up** (`<C-w>k`) -> Go to top window

- **Ctrl+Down** (`<C-w>j`) -> Go to bottom window

- **Ctrl+N** (`:vs<CR>`) -> Create a new window on the right

- **Shift+N** (`:sp<CR>`) -> Create a new window at the bottom

- **Ctrl+F4** (`:Bdelete<CR>`) -> Close current buffer

- **Tab** (`:bn<CR>`) -> Go to the next buffer

- **Shift+Tab** (`:bp<CR>`) -> Go to the previous buffer

- **Shift+B** (`:tabnew<CR>`) -> Create a new empty buffer

Insert mode:

- **Ctrl+Z** (`<u>`) -> Undo last modification

- **Ctrl+Y** (`<C-r>`) -> Redo last modification

### CMP keymaps

Insert mode:

- **Ctrl+Space** (`cmp.mapping.complete()`) -> Trigger autocompletion options

- **Enter** (`cmp.mapping.confirm({ select = true})`) -> Select autocompletion option

### LSP keymaps

Normal mode:

- **gd** (`vim.lsp.buf.definition()`) -> Go to the definition

- **gi** (`vim.lsp.buf.implementation()`) -> Go to the implementation

- **gr** (`telescope.lsp_references()`) -> List the references

- **gh** (`vim.lsp.buf.hover()`) -> Show additional information

- **Ctrl+R+R** (`vim.lsp.buf.rename()`) -> Rename the current symbol (variable, function...)

- **Leader+C+A** (`lsp.buf.code_action()`) -> Trigger code actions

### Aerial keymaps

Normal mode:

- **,** (`:AerialPrev<CR>`) -> Go to the previous symbol

- **;** (`:AerialNext<CR>`) -> Go to the next symbol

- **Enter** | **Ctrl+M** (`:AerialToggle!<CR>`) -> Toggle the code outline window

### NvimTree keymaps

Normal mode:

- **Ctrl+B** (`:NvimTreeFindFileToggle<CR>`) -> Toggle the file explorer window

### Telescope keymaps

Normal mode:

- **Ctrl+P** (`telescope.find_files()`) -> Find a file by name

- **Shift+P** (`telescope.oldfiles()`) -> Show a list of recently opened files

- **Ctrl+F** (`telescope.live_grep()`) -> Find a word or a word list in a file

- **Shift+F** (`telescope.help_tags()`) -> Show a list of commands

### Comments keymaps

Normal mode:

- **t** (`todo-comments.jump_next()`) -> Go to the next TODO comment

- **Shift-t** (`todo-comments.jump_prev()`) -> Go to the previous TODO comment

### Dap keymaps

Normal mode:

- **bp** (`dap.toggle_breakpoint()`) -> Toggle a breakpoint

- **Ctrl+B+P** (`dap.set_breakpoint()`) -> Set a breakpoint

- **cp** (`dap.set_breakpoint(fn.input("Stop condition: "))`) -> Set a conditional breakpoint

- **lp** (`dap.set_breakpoint(nil, nil, fn.input("Log point message: "))`) -> Set a breakpoint that logs a message when triggered

- **F4** (`dap.disconnect({ terminateDebuggee = true })`) -> Disconnect the debugger

- **F5** (`dap.continue()`) -> Continue program execution

- **F6** (`dap.restart()`) -> Restart program

- **F10** (`dap.steop_over()`) -> Go to the next program step

- **Shift+F10** (`dap.step_back()`) -> Go to the last program step

- **F11** (`dap.step_into()`) -> Go to program step into function

- **F12** (`dap.step_out()`) -> Go to program step outside of current function

- **gt** (`dap_goto()`) -> Go to line under cursor

- **dr** (`dap.repl.open()`)

- **dl** (`dap.run_last()`) -> Run the last debugging configuration

- **dh** (`dap_widgets.hover()`)

- **dp** (`dap_widgets.preview()`)

Visual mode:

- **dh** (`dap_widgets.hover()`)

- **dp** (`dap_widgets.preview()`)

### Alpha keymaps

Normal mode:

- **go** (`:%bd|Alpha|bd#<CR>`) -> Open startup screen

## Custom commands:

### Theme commands

`:Gruvbox` -> Set theme to Gruvbox

`:Kanagawa` -> Set theme to Kanagawa

`:Onedark` -> Set theme to Onedark

`:Nord` -> Set theme to Nord

`:Catppuccin` -> Set theme to Catppuccin

`:SetDefaultTheme {theme}` -> Set default theme
