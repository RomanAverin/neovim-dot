return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = { enabled = true },
    servers = {
      jinja_lsp = {
        filetypes = { "jinja", "html", "j2" },
      },
    },
  },
}
