return {
  "ibhagwan/fzf-lua",
  opts = {
    winopts = {
      preview = {
        layout = "vertical",
      },
    },
    fzf_colors = true,
    grep = {
      rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 "
        .. "--colors=match:fg:214 --colors=match:style:bold -e",
    },
  },
}
