-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--
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

-- lsp_line disable for the Lazy floating window
vim.api.nvim_create_autocmd("WinEnter", {
  callback = function()
    local floating = vim.api.nvim_win_get_config(0).relative ~= ""
    vim.diagnostic.config({
      virtual_text = floating,
      virtual_lines = not floating,
    })
  end,
})
