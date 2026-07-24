return {
  "GustavEikaas/easy-dotnet.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    local dotnet = require("easy-dotnet")

    dotnet.setup({
      -- ================= LSP =================
      lsp = {
        enabled = false,
        roslynator_enabled = false,
        analyzer_assemblies = {},
        config = {},
      },

      -- ================= DEBUGGER =================
      debugger = {
        bin_path = nil, -- use mason netcoredbg
        apply_value_converters = true,
        auto_register_dap = true,
        mappings = {
          open_variable_viewer = {
            lhs = "T",
            desc = "open variable viewer",
          },
        },
      },

      -- ================= TEST RUNNER =================
      ---@type TestRunnerOptions
      test_runner = {
        viewmode = "float", -- "split" | "vsplit" | "float" | "buf"
        vsplit_width = nil,
        vsplit_pos = nil,
        enable_buffer_test_execution = true,
        noBuild = true,

        icons = {
          passed = "",
          skipped = "",
          failed = "",
          success = "",
          reload = "",
          test = "",
          sln = "󰘐",
          project = "󰘐",
          dir = "",
          package = "",
        },

        mappings = {
          run_test_from_buffer = { lhs = "<leader>r", desc = "run test from buffer" },
          peek_stack_trace_from_buffer = { lhs = "<leader>p", desc = "peek stack trace from buffer" },
          filter_failed_tests = { lhs = "<leader>fe", desc = "filter failed tests" },
          run_all = { lhs = "<leader>R", desc = "run all tests" },
          run = { lhs = "<leader>r", desc = "run test" },
          peek_stacktrace = { lhs = "<leader>p", desc = "peek stacktrace of failed test" },
          expand = { lhs = "o", desc = "expand" },
          expand_node = { lhs = "E", desc = "expand node" },
          expand_all = { lhs = "-", desc = "expand all" },
          collapse_all = { lhs = "W", desc = "collapse all" },
          close = { lhs = "q", desc = "close testrunner" },
          refresh_testrunner = { lhs = "<C-r>", desc = "refresh testrunner" },
        },

        additional_args = {},
      },

      -- ================= NEW PROJECT =================
      new = {
        project = {
          prefix = "sln", -- "sln" | "none"
        },
      },

      -- ================= TERMINAL =================
      ---@param action "test" | "restore" | "build" | "run" | "watch"
      terminal = function(path, action, args)
        args = args or ""

        local commands = {
          run = function()
            return string.format("dotnet run --project %s %s", path, args)
          end,
          test = function()
            return string.format("dotnet test %s %s", path, args)
          end,
          restore = function()
            return string.format("dotnet restore %s %s", path, args)
          end,
          build = function()
            return string.format("dotnet build %s %s", path, args)
          end,
          watch = function()
            return string.format("dotnet watch --project %s %s", path, args)
          end,
        }

        local command = commands[action]()

        if require("easy-dotnet.extensions").isWindows() then
          command = command .. "\r"
        end

        vim.cmd("vsplit")
        vim.cmd("term " .. command)
      end,

      -- ================= MAPPINGS =================
      csproj_mappings = true,
      fsproj_mappings = true,

      -- ================= NAMESPACE =================
      auto_bootstrap_namespace = {
        type = "file_scoped", -- block_scoped | file_scoped
        enabled = true,
        use_clipboard_json = {
          behavior = "prompt",   --'auto' | 'prompt' | 'never',
          register = "+",        -- which register to check
        },
      },

      -- ================= SERVER =================
      server = {
        log_level = nil, -- Off | Critical | Error | Warning | Information | Verbose | All
      },

      picker = "telescope",
      background_scanning = true,

      -- ================= NOTIFICATIONS =================
      notifications = {
        handler = function(start_event)
          local spinner = require("easy-dotnet.ui-modules.spinner").new()
          spinner:start_spinner(start_event.job.name)

          ---@param finished_event JobEvent
          return function(finished_event)
            spinner:stop_spinner(
              finished_event.result.msg,
              finished_event.result.level
            )
          end
        end,
      },

      -- ================= DIAGNOSTICS =================
      diagnostics = {
        default_severity = "error",
        setqflist = false,
      },
    })

    -- ================= COMMANDS =================
    vim.api.nvim_create_user_command("Secrets", function()
      dotnet.secrets()
    end, {})

    -- ================= KEYMAPS =================
    vim.keymap.set("n", "<leader>gg", ":Dotnet run<CR>", { desc = "Run project" })
    vim.keymap.set("n", "<leader>tt", ":Dotnet test<CR>", { desc = "Run tests" })
    vim.keymap.set("n", "<leader>ap", ":Dotnet add package<CR>", { desc = "Open window with nuget packages" })

    vim.keymap.set("n", "<leader>pv", function()
      dotnet.project_view()
    end)

    vim.keymap.set("n", "<leader>sa", function()
      dotnet.solution_add()
    end)

    vim.keymap.set("n", "<leader>sr", function()
      dotnet.solution_remove()
    end)

    vim.keymap.set("n", "<leader>qt", ":bd!<CR>", { desc = "Close project terminal" })

  end,
}
