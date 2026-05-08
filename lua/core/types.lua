---@meta

---@class NewsOptions
---@field lazyvim boolean When enabled, NEWS.md will be shown when changed. This only contains big new features and breaking changes
---@field neovim boolean -- Same as lazyvim but for Neovim's news.txt

---@class Colorscheme
---@field name string
---@field dark? string
---@field light? string

---@alias ColorschemeTable table<string, { lazyopts: table, theme_overrides?: table<string, table> }>
