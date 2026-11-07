return {
  {
    "neovimhaskell/nvim-hs.vim",
    lazy = false,
    config = function()
      local project = vim.fn.stdpath("config") .. "/haskell"
      vim.fn["nvimhs#start"](project, "nvim-config-hs", {})
    end,
  },
}
