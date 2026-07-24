---@diagnostic disable: missing-fields
return {
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup({
        expand_lines = true,
        controls = { enabled = false }, -- no extra play/step buttons
        floating = { border = "rounded" },
        -- Set dapui window
        render = {
          max_type_length = 60,
          max_value_lines = 200,
        },
        -- Only one layout: just the "scopes" (variables) list at the bottom
        layouts = {
          {
            elements = {
              { id = "scopes", size = 1.0 }, -- 100% of this panel is scopes
            },
            size = 15,                       -- height in lines (adjust to taste)
            position = "bottom",             -- "left", "right", "top", "bottom"
          },
        },
      })

      dap.listeners.before.attach.dapui_config = function() dapui.open() end
      dap.listeners.before.launch.dapui_config = function() dapui.open() end
      dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
      dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

      -- https://emojipedia.org/en/stickers/search?q=circle
      vim.fn.sign_define('DapBreakpoint',
        {
          text = '⚪',
          texthl = 'DapBreakpointSymbol',
          linehl = 'DapBreakpoint',
          numhl = 'DapBreakpoint'
        })

      vim.fn.sign_define('DapStopped',
        {
          text = '🔴',
          texthl = 'yellow',
          linehl = 'DapBreakpoint',
          numhl = 'DapBreakpoint'
        })
      vim.fn.sign_define('DapBreakpointRejected',
        {
          text = '⭕',
          texthl = 'DapStoppedSymbol',
          linehl = 'DapBreakpoint',
          numhl = 'DapBreakpoint'
        })

      vim.keymap.set("n", "<leader>ss", dap.terminate, { desc = "Terminate" })

      vim.keymap.set("n", "<leader>dcb", dap.clear_breakpoints, { desc = "Clear breakpoints" })

      vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Start/continue debugging" })
      vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Step over" })
      vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Step into" })
      vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Step out" })
      vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
      vim.keymap.set("n", "<leader>dC", dap.run_to_cursor, { desc = "Run to cursor" })
      vim.keymap.set("n", "<leader>dr", dap.repl.toggle, { desc = "Toggle DAP REPL" })
      vim.keymap.set("n", "<leader>dj", dap.down, { desc = "Go down stack frame" })
      vim.keymap.set("n", "<leader>dk", dap.up, { desc = "Go up stack frame" })
    end
  }
}
