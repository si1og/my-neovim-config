return {
  cmd = { 'haskell-language-server-wrapper', '--lsp' },
  filetypes = { 'haskell', 'lhaskell' },
  root_dir = function(bufnr, on_dir)
  local fname = vim.api.nvim_buf_get_name(bufnr)

  local root = vim.fs.root(fname, {
    "hie.yaml",
    "stack.yaml",
    "cabal.project",
    ".git",
  })

  on_dir(root)
  end,
  settings = {
    haskell = {
      formattingProvider = 'ormolu',
      cabalFormattingProvider = 'cabal-fmt',
    },
  },
}
