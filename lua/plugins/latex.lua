return {
  {
    "lervag/vimtex",
    tag = "v2.18",
    ft = { "tex", "plaintex", "bib" },
    init = function()
      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_quickfix_mode = 0
      vim.g.vimtex_view_method = "skim"
    end,
  },
}
