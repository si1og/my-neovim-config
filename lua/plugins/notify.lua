return {
  'rcarriga/nvim-notify',

  config = function()
    require("notify").setup({
      stages = "fade",
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
      render = "wrapped-compact",

      background_colour = "#000000",
    })

    vim.notify = require("notify")
    local notify_groups = {
      "NotifyBackground",

      "NotifyERRORBody",
      "NotifyWARNBody",
      "NotifyINFOBody",
      "NotifyDEBUGBody",
      "NotifyTRACEBody",

      "NotifyERRORBorder",
      "NotifyWARNBorder",
      "NotifyINFOBorder",
      "NotifyDEBUGBorder",
      "NotifyTRACEBorder",
    }

    for _, group in ipairs(notify_groups) do
      vim.api.nvim_set_hl(0, group, { bg = "NONE" })
    end
  end
}
