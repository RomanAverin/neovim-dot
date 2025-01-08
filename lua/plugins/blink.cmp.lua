return {
  "saghen/blink.cmp",
  version = "0.9.3",
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
            { "kind_icon", "kind" },
          },
        },
        -- winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine: BlinkCmpMenuSelection,Search:None",
      },
    },
    keymap = {
      preset = "super-tab",
      ["<C-i>"] = { "show", "show_documentation", "hide_documentation" },
      ["<CR>"] = { "accept", "fallback" },
    },
  },
}
