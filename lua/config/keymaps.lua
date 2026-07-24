vim.g.mapleader = " "
vim.keymap.set("n", "<leader>cd", vim.cmd.Ex)
vim.keymap.set("n", "<leader>ee", "<cmd>Neotree toggle<CR>", { desc = "Explorer" })
vim.keymap.set("n", "<leader>rr", "<cmd>Neotree reveal<CR>")

vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})

vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Show diagnostic" })

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
vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})

-- Increment/decrement
vim.keymap.set("n", "+", "<C-a>")
vim.keymap.set("n", "-", "<C-x>")

-- Close current buffer
vim.keymap.set("n", "<leader>cb", function()
  vim.cmd("bdelete! ")
end, { desc = "Close current buffer" })
