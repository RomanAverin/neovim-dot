return {
  "nvim-telescope/telescope-file-browser.nvim",
  dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  keys = {
    {
      "<leader>fG",
      ":Telescope file_browser path=%:p:h=%:p:h<CR>",
      desc = "Telescope file browser",
    },
  },
  config = function()
    require("telescope").load_extension("file_browser")
  end,
}
