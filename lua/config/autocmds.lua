-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--
-- Must be declared before executing ':colorscheme'.

-- Sonokai colorscheme overriode
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

local lsp_hacks = vim.api.nvim_create_augroup("LspHacks", { clear = true })

vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
  group = lsp_hacks,
  pattern = ".env*",
  callback = function(e)
    vim.diagnostic.enable(false, { bufnr = e.buf })
  end,
})
