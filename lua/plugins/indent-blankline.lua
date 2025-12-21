return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  ---@module "ibl"
  ---@type ibl.config
  opts = {
    scope = {
      enabled = true,
      show_start = false,
      show_end = false,
      include = {
        node_type = {
          ["*"] = { "*" }, -- enabled for all nodes
        },
      },
    },
  },
}
