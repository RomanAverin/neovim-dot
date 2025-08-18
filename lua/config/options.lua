-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
-- Set indentation options
vim.opt.expandtab = true -- Convert tabs to spaces
-- vim.opt.shiftwidth = 4 -- Amount to indent with << and >>
vim.opt.tabstop = 4 -- How many spaces are shown per Tab
-- vim.opt.softtabstop = 4 -- How many spaces are applied when pressing Tab

vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.autoindent = true -- Keep identation from previous line

-- Store undos between sessions
vim.opt.undofile = true

-- Enable break indent
vim.opt.breakindent = true

-- Cursor shape
vim.opt.guicursor =
  "n-v-c-sm:block,ci-ve:ver20,r-cr:block,o:hor50,i:ver20,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"

-- Enable .editconfig
vim.g.editorconfig = true

-- Nerd font suppurt
vim.g.have_nerd_font = true
