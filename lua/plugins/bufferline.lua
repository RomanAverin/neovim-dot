return {
  "akinsho/bufferline.nvim",
  after = "charleston",
  -- dependencies = { "charleston" },
  opts = {
    highlights = function()
      return require("charleston.bufferline").get_theme()
    end,
    options = {
      separator_style = "splope",
      always_show_bufferline = false,
      show_tab_indicators = true,
    },
  },
}
