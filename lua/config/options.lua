vim.keymap.set("i", "jj", "<Esc>")
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.relativenumber = true

vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.termguicolors = true

-- disable automaticall insertion of comments
vim.cmd([[autocmd FileType * set formatoptions-=ro]])
