-- Set indentation options
vim.opt.tabstop =  4
vim.opt.softtabstop =  4
vim.opt.shiftwidth =  4
vim.opt.expandtab = true
-- Uncomment the lines below if you want to enable autoindent and smartindent
-- vim.opt.autoindent = true
-- vim.opt.smartindent = true

-- Define normal mode mappings
-- Make sure to use 'n' for normal mode mappings
-- Autoindent after pasting
vim.api.nvim_set_keymap('n', 'p', 'p=`]', {noremap = true})
vim.api.nvim_set_keymap('n', 'P', 'P=`]', {noremap = true})

-- Current line chages
vim.wo.relativenumber = true
vim.wo.number = true
vim.opt.numberwidth = 1
