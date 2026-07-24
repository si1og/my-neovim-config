return {
  "ray-x/lsp_signature.nvim",
  config = function()
    require("lsp_signature").setup({
      bind = true,
      floating_window = true,
      hint_enable = true,
      handler_opts = { border = "rounded" },
      always_trigger = false,
    })
  end
}
