return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = { enabled = false },
    -- Disable virtual_text since it's redundant due to lsp_lines.
    diagnostics = {
      virtual_text = false,
    },
  },
}
