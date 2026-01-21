return {
  "neovim/nvim-lspconfig",
  opts = {
    diagnostics = {
      virtual_text = false,
      underline = true,
      float = {
        border = "rounded", -- or "single", "double", "solid", "shadow"
        source = "always",
      },
    },
    servers = {
      jinja_lsp = {
        filetypes = { "jinja", "html", "j2" },
      },
      pyright = {
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic",
              diagnosticMode = "openFilesOnly",
              useLibraryCodeForTypes = true,
            },
          },
        },
      },
    },
  },
}
