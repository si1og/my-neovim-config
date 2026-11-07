return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local input_source = require("config.input_source")
    input_source.setup()

    local colors = {
      bg = "#1a1612",
      surface = "#28211c",
      panel = "#302822",
      select = "#3d352e",
      fg = "#fffbf5",
      soft = "#d4c5b9",
      muted = "#8a7d72",
      orange = "#ff8860",
      peach = "#ff9f78",
      yellow = "#ffc09f",
    }

    local rust_and_brown = {
      normal = {
        a = { fg = colors.bg, bg = colors.orange, gui = "bold" },
        b = { fg = colors.fg, bg = colors.panel },
        c = { fg = colors.soft, bg = colors.surface },
      },
      insert = {
        a = { fg = colors.bg, bg = colors.yellow, gui = "bold" },
      },
      visual = {
        a = { fg = colors.bg, bg = colors.peach, gui = "bold" },
      },
      replace = {
        a = { fg = colors.bg, bg = colors.orange, gui = "bold" },
      },
      command = {
        a = { fg = colors.bg, bg = colors.soft, gui = "bold" },
      },
      inactive = {
        a = { fg = colors.muted, bg = colors.surface },
        b = { fg = colors.muted, bg = colors.surface },
        c = { fg = colors.muted, bg = colors.surface },
      },
    }

    require("lualine").setup({
      options = {
        theme = rust_and_brown,
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filetype', 'filename' },
        lualine_x = {
          'searchcount',
          'lsp_status',
          {
            input_source.status,
            color = { fg = colors.muted },
            separator = { left = "", right = "" },
          },
          {
            function()
              return os.date("%H:%M")
            end,
            color = { fg = colors.muted },
            separator = { left = "", right = "" },
          },
        },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
      },
    })
  end,
}
