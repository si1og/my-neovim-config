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

        builtin.find_files({
          file_ignore_patterns = vim.fn.NvimConfigBinaryFilePatterns(),
          previewer = false,
        })
      end, { desc = "Telescope find files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
      vim.keymap.set("n", "<leader>/", builtin.live_grep, { desc = "Search project" })
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
