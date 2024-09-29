-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
-- Set indentation options
vim.opt.tabstop = 4
-- vim.opt.softtabstop = 4
-- vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Cursor shape
vim.opt.guicursor =
  "n-v-c-sm:block,ci-ve:ver20,r-cr-o:hor20,i:ver20,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"

-- Show current file in winbar
vim.opt.winbar = "%=%m %f"

-- Enable .editconfig
vim.g.editorconfig = true

-- Must be declared before executing ':colorscheme'.
local grpid = vim.api.nvim_create_augroup("custom_highlights_sonokai", {})
vim.api.nvim_create_autocmd("ColorScheme", {
  group = grpid,
  pattern = "sonokai",
  callback = function()
    local config = vim.fn["sonokai#get_configuration"]()
    local palette = vim.fn["sonokai#get_palette"](config.style, config.colors_override)
    local set_hl = vim.fn["sonokai#highlight"]

    set_hl("Visual", palette.none, palette.grey_dim)
    set_hl("IncSearch", palette.bg0, palette.yellow)
    set_hl("Search", palette.none, palette.diff_yellow)
  end,
})
