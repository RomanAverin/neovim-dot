return {
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
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "sonokai",
    },
  },
}
