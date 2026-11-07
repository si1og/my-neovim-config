return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local bufferline = require("bufferline")
    local bg = "#1a1612"
    local surface = "#28211c"
    local border = "#3d352e"
    local text = "#d4c5b9"
    local muted = "#8a7d72"
    local accent = "#ff8860"

    bufferline.setup({
      options = {
        offsets = {
          {
            filetype = "neo-tree",
            text = "File Explorer",
            text_align = "center",
            highlight = "Directory",
            separator = true,
          },
        },
        modified_icon = "●",
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",

        separator_style = "slant",
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
      },
      highlights = {
        fill = { bg = bg },
        background = { fg = muted, bg = surface },
        buffer_visible = { fg = text, bg = surface },
        buffer_selected = { fg = accent, bg = bg, bold = true, italic = false },
        separator = { fg = bg, bg = surface },
        separator_visible = { fg = bg, bg = surface },
        separator_selected = { fg = bg, bg = bg },
        indicator_selected = { fg = accent, bg = bg },
        close_button = { fg = muted, bg = surface },
        close_button_visible = { fg = text, bg = surface },
        close_button_selected = { fg = accent, bg = bg },
        modified = { fg = accent, bg = surface },
        modified_visible = { fg = accent, bg = surface },
        modified_selected = { fg = accent, bg = bg },
        offset_separator = { fg = border, bg = bg },
      },
    })
  end,
}
