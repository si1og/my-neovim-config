return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    lazy = false,

    config = function()
      ------------------------------------------------------------------
      -- Neo-tree setup
      ------------------------------------------------------------------
      require("neo-tree").setup({
        popup_border_style = "rounded",
        enable_git_status = true,
        enable_diagnostics = true,

        open_files_do_not_replace_types = {
          "terminal",
          "trouble",
          "qf",
        },

        default_component_configs = {
          container = {
            enable_character_fade = true,
          },

          indent = {
            indent_size = 2,
            padding = 1,
            with_markers = true,
            indent_marker = "│",
            last_indent_marker = "└",
            highlight = "NeoTreeIndentMarker",
            with_expanders = true,
            expander_collapsed = "",
            expander_expanded = "",
            expander_highlight = "NeoTreeExpander",
          },

          icon = {
            folder_closed = "",
            folder_open = "",
            folder_empty = "󰜌",
            default = "*",
            highlight = "NeoTreeFileIcon",
            use_filtered_colors = true,
          },

          modified = {
            symbol = "[+]",
            highlight = "NeoTreeModified",
          },

          name = {
            trailing_slash = false,
            use_filtered_colors = true,
            use_git_status_colors = true,
            use_diagnostic_colors = true,
            highlight = "NeoTreeFileName",
          },

          git_status = {
            symbols = {
              added = "✚",
              modified = "",
              deleted = "✖",
              renamed = "󰁕",
              untracked = "",
              ignored = "",
              unstaged = "󰄱",
              staged = "",
              conflict = "",
            },
          },

          file_size = {
            enabled = true,
            width = 12,
            required_width = 64,
          },

          type = {
            enabled = true,
            width = 10,
            required_width = 122,
          },

          last_modified = {
            enabled = true,
            width = 20,
            required_width = 88,
          },

          created = {
            enabled = true,
            width = 20,
            required_width = 110,
          },
        },

        window = {
          position = "left",
          width = 40,
          mapping_options = {
            noremap = true,
            nowait = true,
          },
        },

        filesystem = {
          commands = {
            easy = function(state)
              local node = state.tree:get_node()
              local path = node.type == "directory" and node.path or vim.fs.dirname(node.path)

              require("easy-dotnet").create_new_item(path, function()
                require("neo-tree.sources.manager").refresh(state.name)
              end)
            end,
          },

          window = {
            mappings = {
              ["R"] = "easy",
            },
          },

          filtered_items = {
            visible = false,
            hide_dotfiles = false,
            hide_gitignored = false,
            hide_hidden = true,
            always_show = {
              ".env",
              "dev.env",
              "prod.env",
              ".env.dev",
              ".env.prod",
              "Migrations",
            },
            never_show = {
              ".DS_Store",
            },
          },

          follow_current_file = {
            enabled = true,
          },
        },

        buffers = {
          follow_current_file = {
            enabled = true,
          },
          group_empty_dirs = true,
          show_unloaded = true,
        },
      })

      ------------------------------------------------------------------
      -- Diagnostics (global)
      ------------------------------------------------------------------
      vim.diagnostic.config({
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "󰌵",
          },
        },
      })
    end,
  },
}
