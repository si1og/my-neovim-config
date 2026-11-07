return {
  { -- This generates docblocks
    "kkoomen/vim-doge",
    cmd = "DogeGenerate",
    build = ":call doge#install()",
    init = function()
      vim.g.doge_mapping = "<leader>Dd"
    end,
  },
  { -- Git plugin
    "tpope/vim-fugitive",
    lazy = true,
  },
  { -- Show historical versions of the file locally
    "mbbill/undotree",
    lazy = true,
  },
  { -- Show CSS Colors
    "brenoprata10/nvim-highlight-colors",
    ft = { "css", "scss", "sass", "html", "javascript", "typescript", "javascriptreact", "typescriptreact" },
    config = function()
      require("nvim-highlight-colors").setup({})
    end,
  },
}
