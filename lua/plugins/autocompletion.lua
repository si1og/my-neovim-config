return {
  -- LSP source
  { "hrsh7th/cmp-nvim-lsp", lazy = true },

  -- Snippets
  {
    "L3MON4D3/LuaSnip",
    lazy = true,
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
  },

  -- Icons for completion
  { "onsails/lspkind-nvim", lazy = true },

  -- Autocompletion engine
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "onsails/lspkind-nvim",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require('lspkind')

      -- Load VSCode-style snippets
      require("luasnip.loaders.from_vscode").lazy_load()

      local confirm_completion = cmp.mapping.confirm({ select = true })

      cmp.setup({
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            ellipsis_char = "...",
            before = function(entry, vim_item)
              vim_item.kind = vim_item.kind:gsub("^%s*[%w%p]*%s*", "")
              vim_item.menu = ({
                nvim_lsp = "[LSP]",
                luasnip = "[Snip]",
                buffer = "[Buf]",
                path = "[Path]",
                nvim_lsp_signature_help = "[Sig]",
              })[entry.source.name]
              return vim_item
            end,
          }),

        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered({
            border = "rounded",
            winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
          }),
          documentation = cmp.config.window.bordered({
            border = "rounded",
            winhighlight = "Normal:CmpPmenu,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None",
          })
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-i>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<C-CR>"] = confirm_completion,
          ["<C-y>"] = confirm_completion,
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
        }),

        sources = cmp.config.sources({
          { name = "nvim_lsp_signature_help", priority = 50 },
          { name = "luasnip",                 priority = 40 },
          { name = "nvim_lsp",                priority = 30 },
          { name = "buffer",                  priority = 20 },
          { name = "path",                    priority = 10 },
        }),
      })
    end,
  },
}
