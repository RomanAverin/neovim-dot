return {
  "nvim-telescope/telescope-file-browser.nvim",
  dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
  config = function()
    local map = vim.api.nvim_set_keymap

    -- Keybinding for Telescope file_browser
    map('n', '<leader>fb', [[<cmd>Telescope file_browser<CR>]], { noremap = true, silent = true })
  end
}
