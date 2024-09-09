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

    -- Must be declared before executing ':colorscheme'.
    local grpid = vim.api.nvim_create_augroup("custom_highlights_sonokai", {})
    vim.api.nvim_create_autocmd("ColorScheme", {
      group = grpid,
      pattern = "sonokai",
      callback = function()
        local config = vim.fn["sonokai#get_configuration"]()
        local palette = vim.fn["sonokai#get_palette"](config.style, config.colors_override)
        local set_hl = vim.fn["sonokai#highlight"]

        set_hl("Visual", palette.none, palette.grey_dim)
        set_hl("IncSearch", palette.bg0, palette.yellow)
        set_hl("Search", palette.none, palette.diff_yellow)
      end,
    })
  end,
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "sonokai",
    },
  },
}
