return {
  {
    "lewis6991/gitsigns.nvim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "┃" },
          change = { text = "┃" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
          untracked = { text = "┆" },
        },
        signs_staged = {
          add = { text = "┃" },
          change = { text = "┃" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
          untracked = { text = "┆" },
        },
        signcolumn = true,
        numhl = false,
        linehl = false,
        word_diff = false,
        watch_gitdir = { interval = 1000, follow_files = true },
        attach_to_untracked = true,
        current_line_blame = false,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol",
          delay = 1000,
          ignore_whitespace = false,
        },
        current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
        sign_priority = 6,
        status_formatter = nil,
        update_debounce = 200,
        max_file_length = 40000,
        preview_config = {
          border = "rounded",
          style = "minimal",
          relative = "cursor",
          row = 0,
          col = 1,
        },
        on_attach = function(bufnr)
          local gs = require("gitsigns")
          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
          end
          -- Navigation
          map("n", "]h", gs.next_hunk, "Next Hunk")
          map("n", "[h", gs.prev_hunk, "Prev Hunk")
        end,
      })
    end,
    keys = {
      -- Advanced Git actions live under <leader>G; <leader>g is quick commit.
      {
        "<leader>Gh",
        function()
          require("gitsigns").preview_hunk()
        end,
        desc = "Preview Hunk",
      },
      {
        "<leader>GH",
        function()
          require("gitsigns").preview_hunk_inline()
        end,
        desc = "Preview Hunk Inline",
      },
      {
        "<leader>Ga",
        function()
          require("gitsigns").stage_hunk()
        end,
        desc = "Stage Hunk",
      },
      {
        "<leader>Gu",
        function()
          require("gitsigns").undo_stage_hunk()
        end,
        desc = "Undo Stage",
      },
      {
        "<leader>Gr",
        function()
          require("gitsigns").reset_hunk()
        end,
        desc = "Reset Hunk",
      },
      {
        "<leader>GR",
        function()
          require("gitsigns").reset_buffer()
        end,
        desc = "Reset Buffer",
      },
      {
        "<leader>Gx",
        function()
          require("gitsigns").blame_line()
        end,
        desc = "Blame Line",
      },
      {
        "<leader>GD",
        function()
          vim.cmd("Gitsigns diffthis HEAD")
        end,
        desc = "Diff HEAD",
      },
    },
  },
  {
    "sindrets/diffview.nvim",
    event = "VeryLazy",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    keys = {
      { "<leader>d", "<cmd>DiffviewOpen<cr>", desc = "Git: open diff" },
    },
  },
  -- Git related plugins
  {
    "tpope/vim-fugitive",
    keys = {
      { "<leader>g", "<cmd>Git commit<cr>", desc = "Git: commit changes" },
      { "<leader>Gs", "<cmd>Git<cr>", desc = "Git: show status" },
      { "<leader>Gw", "<cmd>Gwrite<cr>", desc = "Git: stage current file" },
      { "<leader>Gc", "<cmd>Git commit<cr>", desc = "Git: commit changes" },
      { "<leader>Gpl", "<cmd>Git pull<cr>", desc = "Git: pull changes" },
      { "<leader>Gpu", "<cmd>15 split | terminal git push<cr>", desc = "Git: push changes" },
    },
  },
  "tpope/vim-rhubarb",
  -- Undo tree
  {
    "mbbill/undotree",
    keys = {
      { "<leader>uU", "<cmd>UndotreeToggle<CR>", desc = "Undo Tree" },
    },
  },
}
