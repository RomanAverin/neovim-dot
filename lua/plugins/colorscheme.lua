return {
  {
    "sainnhe/sonokai",
    lazy = false,
    priority = 1000,
    config = function()
      -- Optionally configure and load the colorscheme
      -- directly inside the plugin declaration.
      vim.g.sonokai_enable_italic = 1
      vim.g.sonokai_better_performance = 1
      vim.g.sonokai_disable_terminal_colors = 1
      vim.g.sonokai_diagnostic_line_highlight = 1
    end,
  },
  { "ellisonleao/gruvbox.nvim" },
  { "sainnhe/edge" },
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000, -- Ensure it loads first
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "frappe",
      background = { -- :h background
        light = "frappe",
        dark = "mocha",
      },
      color_overrides = {
        all = {
          -- base = "#33353f",
        },
      },
    },
  },
  {
    "AstroNvim/astrotheme",
    priority = 1000,
    opts = {
      palette = "astrodark",
    },
  },
  {
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require("github-theme").setup({
        -- ...
      })
    end,
  },
  {
    dir = "~/Develop/austere.nvim",
    name = "austere",
    priority = 1000,
    opts = {},
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "austere",
    },
  },
}
