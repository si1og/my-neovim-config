return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.config").setup({
      ensure_installed = {
        "c_sharp",
        "sql",
        "bash",
        "c",
        "diff",
        "html",
        "css",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "printf",
        "python",
        "query",
        "regex",
        "toml",
        "typescript",
        "tsx",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
        "dockerfile",
        "haskell",
      },
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
      autotag = {
        enable = true,
      },
      auto_install = true,
    })
  end,
}
