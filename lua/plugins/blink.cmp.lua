return {
  "saghen/blink.cmp",
  version = "*",
  build = "cargo build --release",
  opts = {
    signature = { enabled = false },
    appearance = {
      use_nvim_cmp_as_default = false,
      nerd_font_variant = "mono",
    },
    completion = {
      trigger = {
        show_on_insert_on_trigger_character = false,
      },
      ghost_text = {
        enabled = false,
      },
      -- Insert completion item on selection, don't select by default
      list = {
        selection = {
          preselect = true,
          auto_insert = false,
        },
      },
      -- Show documentation when selecting a completion item
      documentation = {
        auto_show = false,
        window = {
          border = "rounded",
        },
      },
      menu = {
        border = "padded",
        draw = {
          columns = {
            { "label", "label_description", gap = 1 },
            { "kind_icon", "kind", "source_name" },
          },
          treesitter = {},
        },
        -- winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine: BlinkCmpMenuSelection,Search:None",
      },
    },
    keymap = {
      preset = "super-tab",
      ["<C-i>"] = { "show", "show_documentation", "hide_documentation" },
      ["<CR>"] = { "accept", "fallback" },
      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
      ["<C-p>"] = { "select_prev", "fallback" },
      ["<C-n>"] = { "select_next", "fallback" },
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },
      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },
    },
  },
}
