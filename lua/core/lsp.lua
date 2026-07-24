vim.lsp.enable({
  "lua_ls",
  "vimls",
  "html",
  "cssls",
  "clangd",
  "tailwindcss",
  "ts_ls",
  "jsonls",
  "yamlls",
  "markdown_oxide",
  "dockerls",
  "typos_lsp",
  "docker_compose_language_service",
  "hls",
})

vim.diagnostic.config({
  virtual_lines = false,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = true,
    header = "diagnostic",
    prefix = "● ",
    format = function(d)
      return string.format("%s: %s", d.code or "?", d.message)
    end,
  },
  virtual_text = {
    spacing = 4,
    prefix = "",
    format = function(d)
      return string.format("%s [%s]", d.message, d.source)
    end,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN] = "󰀪 ",
      [vim.diagnostic.severity.INFO] = "󰋽 ",
      [vim.diagnostic.severity.HINT] = "󰌶 ",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "ErrorMsg",
      [vim.diagnostic.severity.WARN] = "WarningMsg",
    },
  },
})
