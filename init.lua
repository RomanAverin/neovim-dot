-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Reset cursor to beam on exit
vim.api.nvim_create_autocmd("VimLeave", {
  callback = function()
    vim.opt.guicursor = "a:ver25-blinkon1"
    io.write("\27[5 q")
  end,
})
