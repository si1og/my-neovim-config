vim.g.mapleader = " "

-- Use Normal-mode commands and mappings without switching from Russian layout.
-- Insert mode is unaffected, so Russian text input continues to work normally.
vim.opt.langmap = table.concat({
  "йцукенгшщз;qwertyuiop",
  "фывапролд;asdfghjkl",
  "ячсмить;zxcvbnm",
  "ЙЦУКЕНГШЩЗ;QWERTYUIOP",
  "ФЫВАПРОЛД;ASDFGHJKL",
  "ЯЧСМИТЬ;ZXCVBNM",
}, ",")

vim.keymap.set("n", "<leader>qq", "<cmd>confirm qall<CR>", { desc = "Quit Neovim" })
vim.keymap.set("n", "<leader>qQ", "<cmd>qall!<CR>", { desc = "Force quit Neovim" })

vim.keymap.set("n", "<leader>cd", vim.cmd.Ex)
vim.keymap.set("n", "<leader>ee", "<cmd>Neotree toggle<CR>", { desc = "Explorer" })
vim.keymap.set("n", "<leader>er", "<cmd>Neotree reveal<CR>", { desc = "Explorer: reveal current file" })
vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<CR>", { desc = "Explorer" })

vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})

vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Show diagnostic" })
vim.keymap.set("n", "<leader>j", function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Next diagnostic" })
vim.keymap.set("n", "<leader>'", function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Previous diagnostic" })

-- Move selected line / block of text in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move Lines Down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move Lines Up" })

-- Keep search results centered
vim.keymap.set("n", "n", "nzzv", { desc = "Next Match (centered)" })
vim.keymap.set("n", "N", "Nzzv", { desc = "Prev Match (centered)" })
vim.keymap.set("n", "*", "*zzv", { desc = "Search Word (centered)" })
vim.keymap.set("n", "#", "#zzv", { desc = "Search Word Back (centered)" })
vim.keymap.set("n", "g*", "g*zz", { desc = "Search Partial (centered)" })
vim.keymap.set("n", "g#", "g#zz", { desc = "Search Partial Back (centered)" })

-- Clear search highlight
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", { desc = "Clear Highlight", silent = true })

-- Format files
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "LSP: format buffer" })

-- Increment/decrement
vim.keymap.set("n", "+", "<C-a>")
vim.keymap.set("n", "-", "<C-x>")

-- Delete without overwriting the current register
vim.keymap.set({ "n", "v" }, "<leader>x", '"_d', { desc = "Delete without yanking" })

-- Close current buffer
vim.keymap.set("n", "<leader>c", "<cmd>confirm bdelete<CR>", { desc = "Close current buffer" })
vim.keymap.set("n", "<leader>cb", function()
  vim.cmd("bdelete! ")
end, { desc = "Close current buffer" })

-- Tabs
vim.keymap.set({"v", "n"}, "<Tab>", ">gv", { silent = true })
vim.keymap.set({"v", "n"}, "<S-Tab>", "<gv", { silent = true })

-- Splits navigation
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Add empty lines
vim.keymap.set("n", "<leader>o", "o<Esc>")

-- Zed-compatible terminal
vim.keymap.set("n", "<leader>t", "<cmd>botright 15split | terminal<CR>", { desc = "Open terminal" })
