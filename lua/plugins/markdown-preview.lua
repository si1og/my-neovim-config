return {
  "sammaji/markdown-preview.nvim",
  cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
  ft = { "markdown" },
  keys = {
    {
      "<leader>mp",
      "<cmd>MarkdownPreviewToggle<CR>",
      ft = "markdown",
      desc = "Markdown preview",
    },
  },
}
