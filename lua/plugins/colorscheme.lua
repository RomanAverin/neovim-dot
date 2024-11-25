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
  {
    "neanias/everforest-nvim",
    version = false,
    lazy = false,
    priority = 1000, -- make sure to load this before all the other start plugins
    -- Optional; default configuration will be used if setup isn't called.
    config = function()
      require("everforest").setup({

        -- The default highlights for TSBoolean is linked to `Purple` which is fg
        -- purple and bg none. If we want to just add a bold style to the existing,
        -- we need to have the existing *and* the bold style. (We could link to
        -- `PurpleBold` here otherwise.)
        --
        on_highlights = function(hl, palette)
          hl.TSBoolean = { fg = palette.purple, bg = palette.none, bold = true }
        end,
      })
    end,
  },
  { "sainnhe/edge" },
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000, -- Ensure it loads first
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "onedark",
    },
  },
}
