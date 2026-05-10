This is my Neovim configuration powered by [LazyVim](https://github.com/folke/lazy.nvim) and heavily inspired (if not completely copied for some files) by the [LazyVim default configuration](https://github.com/LazyVim/LazyVim).

## Features

- Auto-completion and diagnostics with [nvim-cmp](https://github.com/hrsh7th/nvim-cmp), [mason.nvim](https://github.com/mason-org/mason.nvim) and [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- Syntax highlighting with [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) (currently archived but functional, might break in the future)
- Fancy UI with [snacks.nvim](https://github.com/folke/snacks.nvim), [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) and [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)
- Search features with [fzf-lua](https://github.com/ibhagwan/fzf-lua), [flash.nvim](https://github.com/folke/flash.nvim) and [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)
- Debugging with [nvim-dap](https://github.com/mfussenegger/nvim-dap)
- Git integration with [vim-signify](https://github.com/mhinz/vim-signify) and [Git UI](https://github.com/gitui-org/gitui)
- Keymap cheatsheet with [which-key.nvim](https://github.com/folke/which-key.nvim)

## Requirements

- Neovim >= 0.12.0
- Git >= 2.19.0 (for partial clones support)
- [fzf](https://github.com/junegunn/fzf) > 0.36 for `fzf-lua`. See [here](https://github.com/ibhagwan/fzf-lua#dependencies)
- a C compiler for `nvim-treesitter`. See [here](https://github.com/nvim-treesitter/nvim-treesitter#requirements)
- a [Nerd Font](https://www.nerdfonts.com/) (optional)

## Install

Clone the repo in your nvim config folder (`~\AppData\Local\nvim` for Windows and `~/.config/nvim` for Linux).<br/>
You can use this command in your terminal `git clone https://github.com/Astral-Sheep/NeovimConfig nvim` if you don't have a `nvim` folder in your config folder, or just `git clone https://github.com/Astral-Sheep/NeovimConfig .` if you're already in your `nvim` folder.<br/>
If you already have a configuration in your nvim folder, back it up by renaming it with `ren nvim nvim.bak` on Windows and `mv nvim ./nvim.bak` on Linux.<br/>

Once you've cloned the repo, start Neovim and let LazyVim install your plugins. You might have an error from `tiny-inline-diagnostics`, if so just restart Neovim. It's caused by `vim.diagnostic` doing funny things.

If highlighting is going crazy, **use** `:TSInstall` **in Neovim** to install missing treesitter parsers.

## File Structure

The files are split in 3 folders:
- the `lua/core` folder containing utility functions, loaders, etc. You won't need to touch it if you just want to add some plugins, but you might need to if you want to modify deeper logic like how colorschemes are loaded or which defaults are used by this configuration.
- the `lua/config` folder containing the main configuration options for Neovim like colorschemes and keymaps. You can change it as much as you want, it's here exactly for this purpose.
- the `lua/plugins` folder containing all custom plugins, including the ones you'll add. All files there will be automatically loaded by LazyVim.
    - the `lua/plugins/lang` folder contains all language related plugins like [clangd_extensions.nvim](https://github.com/p00f/clangd_extensions.nvim) for C/C++ or [render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim) for Markdown
    - the `lua/plugins/misc` folder is a folder I use for plugins that don't meaningfully improve the experience in Neovim but that I like anyway. They can be disabled in `options.lua` by setting `load_misc_plugins` to `false`

<pre>
    ~/AppData/Local/nvim
    ├── lua
    |   ├── config
    |   |   ├── autocmds.lua
    |   |   ├── colorscheme.lua
    |   |   ├── keymaps.lua
    |   |   ├── lazy.lua
    |   |   └── options.lua
    |   └── plugins
    |       ├── lang
    |       |   ├── language1.lua
    |       |   ├── ...
    |       |   └── language2.lua
    |       ├── misc
    |       |   ├── optional1.lua
    |       |   ├── ...
    |       |   └── optional2.lua
    |       ├── init.lua
    |       ├── lang.lua
    |       ├── misc.lua
    |       ├── plugin1.lua
    |       ├── ...
    |       └── plugin2.lua
    └── init.lua
</pre>

Refer to the [LazyVim documentation](https://lazy.folke.io/) for more info on how to setup your custom configuration.
