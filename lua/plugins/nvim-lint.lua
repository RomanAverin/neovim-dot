return {
  "mfussenegger/nvim-lint",
  event = "LazyFile",
  opts = {
    linters_by_ft = {
      fish = { "fish" },
      python = { "pylint" },
    },
  },
}
