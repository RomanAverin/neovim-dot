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
    sources = {
      per_filetype = {
        lua = { "lsp", "buffer", "path", "snippets" },
        markdown = { "buffer", "path" },
        text = { "buffer", "path" },
        ps1 = { "lsp", "buffer", "path", "snippets" },
      },
    },
    cmdline = {
      keymap = { preset = "inherit" },
      completion = { menu = { auto_show = true } },
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
            { "kind_icon", "kind", gap = 1, "source_name" },
          },
          treesitter = {},
        },
        -- winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine: BlinkCmpMenuSelection,Search:None",
      },
    },
    -- SuperTab preset
    keymap = {
      ["<Tab>"] = {
        function(cmp)
          if cmp.snippet_active() then
            return cmp.accept()
          else
            return cmp.select_and_accept()
          end
        end,
        "snippet_forward",
        "fallback",
      },
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
