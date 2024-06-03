local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

if vim.g.vscode then
  -- VSCode extension
  require("config.vscode_keymaps")
else
  -- ordinary Neovim
  require("lazy").setup("plugins")
  require("config.keymaps")

  vim.cmd [[colorscheme sonokai]]
end 

