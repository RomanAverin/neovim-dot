return {
  {'nvim-treesitter/nvim-treesitter', 
    run = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
          ensure_installed = { "lua", "rust", "c", "vim", "vimdoc", "javascript", "bash", "python" },
          highlight = { enable = true },
          indent = { enable = true },  
      }
    end
  }
}

