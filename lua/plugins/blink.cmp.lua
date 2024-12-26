return {
  "saghen/blink.cmp",
  opts = {
    signature = { enabled = false },
    appearance = {
      use_nvim_cmp_as_default = false,
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
        border = "rounded",
        draw = { gap = 2 },
        -- winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine: BlinkCmpMenuSelection,Search:None",
      },
    },
  },
}
