return {
  "stevearc/conform.nvim",

  config = function()
    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        csharp = { "csharpier" },
        css = { "prettier" },
        c = { "clang-format" },
      },
    })
    vim.keymap.set({ "n", "v" }, "<leader>mp", function()
      require("conform").format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      })
    end, { desc = "Format whole file or range (in visual mode) with" })
  end
}
