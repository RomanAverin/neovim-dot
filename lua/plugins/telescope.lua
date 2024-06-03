return {
  'nvim-telescope/telescope.nvim', tag = '0.1.5',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local action = require('telescope.actions')
    local map = vim.api.nvim_set_keymap

    -- Keybinding for Telescope find-files
    map('n', '<leader>ff', [[<cmd>lua require('telescope.builtin').find_files()<CR>]], { noremap = true, silent = true })
  end
}
