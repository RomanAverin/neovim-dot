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

-- Disable diagnostic for the env files
local lsp_hacks = vim.api.nvim_create_augroup("LspHacks", { clear = true })

vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
  group = lsp_hacks,
  pattern = ".env*",
  callback = function(e)
    vim.diagnostic.enable(false, { bufnr = e.buf })
  end,
})

-- OSC52 support
vim.o.clipboard = "unnamedplus"

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
    local copy_to_unnamedplus = require("vim.ui.clipboard.osc52").copy("+")
    copy_to_unnamedplus(vim.v.event.regcontents)
    local copy_to_unnamed = require("vim.ui.clipboard.osc52").copy("*")
    copy_to_unnamed(vim.v.event.regcontents)
  end,
})

-- Inspector of highlight
local function load_inspector()
  local ok, inspector = pcall(require, "inspector")
  if not ok then
    vim.notify("Failed to load inspector module: " .. inspector, vim.log.levels.ERROR)
    return nil
  end
  return inspector
end
-- Keymap
vim.keymap.set("n", "<a-i>", function()
  local inspector = load_inspector()
  if inspector then
    inspector.inspect() -- Toggle: 1st call = auto-close, 2nd call = focus mode
  end
end, {
  desc = "Inspect highlight under cursor (toggle focus)",
  noremap = true,
  silent = true,
})

-- Global command
vim.api.nvim_create_user_command("Inspector", function()
  local inspector = load_inspector()
  if inspector then
    inspector.inspect()
  end
end, {
  desc = "Inspect highlight under cursor (toggle focus)",
  nargs = 0,
})
