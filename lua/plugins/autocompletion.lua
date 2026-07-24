return {
  -- LSP source
  { "hrsh7th/cmp-nvim-lsp" },

  -- Snippets
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
  },

  -- Icons for completion
  { "onsails/lspkind-nvim" },

  -- Autocompletion engine
  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require('lspkind')

      -- Load VSCode-style snippets
      require("luasnip.loaders.from_vscode").lazy_load()

      -- Register Easy-dotnet source
      cmp.register_source("easy-dotnet", require("easy-dotnet").package_completion_source)

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
                easy_dotnet = "[Dotnet]",
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
          { name = "easy-dotnet" },
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
