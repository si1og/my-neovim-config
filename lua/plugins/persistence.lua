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
      {
        "<leader>qs",
        function()
          require("persistence").load()
        end,
        desc = "Restore project session",
      },
      {
        "<leader>qS",
        function()
          require("persistence").select()
        end,
        desc = "Select session",
      },
      {
        "<leader>ql",
        function()
          require("persistence").load({ last = true })
        end,
        desc = "Restore last session",
      },
      {
        "<leader>qd",
        function()
          require("persistence").stop()
        end,
        desc = "Do not save current session",
      },
    },
  },
}
