return {
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {
      need = 0,
      branch = false,
    },
    init = function()
      vim.opt.sessionoptions = {
        "buffers",
        "curdir",
        "folds",
        "help",
        "tabpages",
        "winsize",
      }
    end,
    keys = {
      {
        "<leader>r",
        function()
          require("config.sessions").open()
        end,
        desc = "Open project sessions",
      },
    },
  },
}
