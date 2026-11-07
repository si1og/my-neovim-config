return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "v0.2.0",
    cmd = "Telescope",
    keys = { "<leader>ff", "<leader>fg", "<leader>/", "<leader>fb", "<leader>fh", "<leader>p", "<leader>ft" },
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-ui-select.nvim" },
    config = function()
      local telescope = require("telescope")
      local builtin = require("telescope.builtin")
      local themes = require("telescope.themes")

      local function project_search_opts(opts)
        return themes.get_dropdown(vim.tbl_deep_extend("force", {
          initial_mode = "insert",
          previewer = true,
          layout_strategy = "vertical",
          layout_config = {
            width = 0.55,
            height = 0.45,
            prompt_position = "top",
            mirror = true,
            preview_height = 0.5,
          },
        }, opts or {}))
      end

      telescope.setup({
        defaults = {
          layout_config = {
            horizontal = {
              preview_cutoff = 0,
            },
          },
        },
        pickers = {
          buffers = {
            mappings = {
              n = {
                d = require("telescope.actions").delete_buffer,
                ["в"] = require("telescope.actions").delete_buffer,
              },
            },
          },
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })
      telescope.load_extension("ui-select")

      vim.keymap.set("n", "<leader>ff", function()
        if vim.fn.exists("*NvimConfigBinaryFilePatterns") ~= 1 then
          vim.notify("Haskell provider is still starting", vim.log.levels.INFO)
          return
        end

        builtin.find_files(project_search_opts({
          file_ignore_patterns = vim.fn.NvimConfigBinaryFilePatterns(),
        }))
      end, { desc = "Telescope find files" })
      vim.keymap.set("n", "<leader>fg", function()
        builtin.live_grep(project_search_opts())
      end, { desc = "Telescope live grep" })
      vim.keymap.set("n", "<leader>/", function()
        builtin.live_grep(project_search_opts())
      end, { desc = "Search project" })
      vim.keymap.set("n", "<leader>fb", function()
        builtin.buffers(require("telescope.themes").get_dropdown({
          initial_mode = "normal",
          previewer = false,
          layout_config = {
            width = 0.55,
            height = 0.45,
          },
        }))
      end, { desc = "Search open buffers" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
      vim.keymap.set("n", "<leader>p", builtin.commands, { desc = "Command palette" })
      vim.keymap.set("n", "<leader>ft", function()
        vim.cmd("TodoTelescope")
      end, { desc = "Open todo telescope" })
    end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    lazy = true,
  },
}
