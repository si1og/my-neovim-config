return {
  { -- This generates docblocks
    "kkoomen/vim-doge",
    build = ":call doge#install()",
    init = function()
      vim.g.doge_mapping = "<leader>Dd"
    end,
  },
  { -- Git plugin
    "tpope/vim-fugitive",
  },
  { -- Show historical versions of the file locally
    "mbbill/undotree",
  },
  { -- Show CSS Colors
    "brenoprata10/nvim-highlight-colors",
    config = function()
      require("nvim-highlight-colors").setup({})
    end,
  },
}
