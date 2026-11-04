return {
  "rebelot/kanagawa.nvim",
  priority = 1000,

  config = function()
    vim.o.background = "dark"

    require("kanagawa").setup({
      compile = false,
      undercurl = true,
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = false },
      statementStyle = {},
      typeStyle = {},
      transparent = true,
      dimInactive = false,
      terminalColors = true,
      theme = "wave",
      background = {
        dark = "wave",
        light = "lotus",
      },
      colors = {
        palette = {
          autumnRed = "#ff705c",
          samuraiRed = "#ff705c",
          waveRed = "#ff795f",
          peachRed = "#ff8860",
          surimiOrange = "#ff8860",
          roninYellow = "#ff9f78",
          boatYellow1 = "#ffad88",
          boatYellow2 = "#ffb89d",
          carpYellow = "#ffc09f",
          oldWhite = "#ffd0bd",
          fujiWhite = "#fffbf5",
          crystalBlue = "#ffc4aa",
          springBlue = "#ffb89d",
          lightBlue = "#ffd0bd",
          dragonBlue = "#ffab80",
          waveAqua1 = "#ffad88",
          waveAqua2 = "#ffb89d",
          springGreen = "#ffad88",
          sakuraPink = "#ff9f78",
          oniViolet = "#ff9470",
          springViolet1 = "#ff9f78",
          springViolet2 = "#ffb89d",
        },
      },
    })

    vim.cmd.colorscheme("kanagawa-wave")

    -- Rust & Brown palette, shared with Zed and tmux.
    local c = {
      bg = "#1a1612",
      surface = "#221e1a",
      panel = "#2a241f",
      select = "#3d352e",
      border = "#3d352e",
      fg = "#fffbf5",
      soft = "#d4c5b9",
      muted = "#8a7d72",
      faint = "#5a4d42",
      red = "#ff705c",
      orange = "#ff8860",
      peach = "#ff9f78",
      yellow = "#ffc09f",
      green = "#ffad88",
      aqua = "#ffb89d",
      blue = "#ffc4aa",
      cyan = "#ffab80",
      purple = "#ff9470",
      pink = "#ffd0bd",
    }

    local function hl(group, opts)
      vim.api.nvim_set_hl(0, group, opts)
    end

    hl("Normal", { bg = "NONE" })
    hl("NormalNC", { bg = "NONE" })
    hl("EndOfBuffer", { bg = "NONE" })
    hl("SignColumn", { bg = "NONE" })
    hl("Cursor", { fg = c.bg, bg = c.orange })
    hl("CursorLine", { bg = c.panel })
    hl("CursorLineNr", { fg = c.soft, bold = true })
    hl("LineNr", { fg = c.muted })
    hl("Visual", { bg = c.select })
    hl("Search", { fg = c.bg, bg = c.orange })
    hl("IncSearch", { fg = c.bg, bg = c.yellow })
    hl("NormalFloat", { fg = c.fg, bg = c.surface })
    hl("FloatBorder", { fg = c.border, bg = c.surface })
    hl("WinSeparator", { fg = c.border, bg = "NONE" })

    hl("Directory", { fg = c.blue })
    hl("NeoTreeDirectoryIcon", { fg = c.blue })
    hl("NeoTreeDirectoryName", { fg = c.blue })
    hl("NeoTreeExpander", { fg = c.muted })
    hl("NeoTreeRootName", { fg = c.orange })
    hl("NvimTreeFolderIcon", { fg = c.blue })
    hl("NvimTreeFolderName", { fg = c.blue })
    hl("NvimTreeOpenedFolderName", { fg = c.blue })

    hl("Pmenu", { fg = c.fg, bg = c.surface })
    hl("PmenuSel", { fg = c.fg, bg = c.panel, bold = true })
    hl("PmenuSbar", { bg = c.surface })
    hl("PmenuThumb", { bg = c.faint })
    hl("CmpPmenu", { fg = c.fg, bg = c.surface })
    hl("CmpPmenuSel", { fg = c.fg, bg = c.panel, bold = true })
    hl("CmpBorder", { fg = c.border, bg = c.surface })

    hl("DiagnosticError", { fg = c.red })
    hl("DiagnosticWarn", { fg = c.yellow })
    hl("DiagnosticInfo", { fg = c.blue })
    hl("DiagnosticHint", { fg = c.aqua })
    hl("DiagnosticUnderlineError", { undercurl = true, sp = c.red })
    hl("DiagnosticUnderlineWarn", { undercurl = true, sp = c.yellow })
    hl("DiagnosticUnderlineInfo", { undercurl = true, sp = c.blue })
    hl("DiagnosticUnderlineHint", { undercurl = true, sp = c.aqua })

    hl("@keyword", { fg = c.orange, bold = true })
    hl("@keyword.conditional", { fg = c.orange })
    hl("@keyword.repeat", { fg = c.orange })
    hl("@keyword.return", { fg = c.orange, bold = true })
    hl("@keyword.import", { fg = c.orange })
    hl("@keyword.exception", { fg = c.red })
    hl("@operator", { fg = c.peach })
    hl("@punctuation.bracket", { fg = c.soft })
    hl("@punctuation.delimiter", { fg = c.soft })
    hl("@punctuation.special", { fg = c.peach })
    hl("@comment", { fg = c.muted, italic = true })
    hl("@string", { fg = c.peach })
    hl("@string.special", { fg = c.pink })
    hl("@number", { fg = c.pink })
    hl("@boolean", { fg = c.pink })
    hl("@constant", { fg = c.pink })
    hl("@constant.builtin", { fg = c.pink })
    hl("@variable", { fg = c.blue })
    hl("@variable.parameter", { fg = c.blue })
    hl("@variable.builtin", { fg = c.cyan })
    hl("@property", { fg = c.cyan })
    hl("@field", { fg = c.cyan })
    hl("@function", { fg = c.yellow })
    hl("@function.call", { fg = c.yellow })
    hl("@function.method", { fg = c.yellow })
    hl("@function.method.call", { fg = c.yellow })
    hl("@constructor", { fg = c.green })
    hl("@type", { fg = c.yellow })
    hl("@type.builtin", { fg = c.yellow, italic = true })
    hl("@module", { fg = c.soft })
    hl("@namespace", { fg = c.soft })
    hl("@tag", { fg = c.orange })
    hl("@tag.attribute", { fg = c.yellow })
    hl("@tag.delimiter", { fg = c.soft })

    local semantic = {
      c = true,
      cpp = true,
      haskell = true,
      typescript = true,
      typescriptreact = true,
      javascript = true,
      javascriptreact = true,
    }

    for lang in pairs(semantic) do
      hl("@lsp.type.class." .. lang, { fg = c.green })
      hl("@lsp.type.struct." .. lang, { fg = c.green })
      hl("@lsp.type.interface." .. lang, { fg = c.aqua })
      hl("@lsp.type.enum." .. lang, { fg = c.aqua })
      hl("@lsp.type.type." .. lang, { fg = c.green })
      hl("@lsp.type.function." .. lang, { fg = c.yellow })
      hl("@lsp.type.method." .. lang, { fg = c.yellow })
      hl("@lsp.type.property." .. lang, { fg = c.cyan })
      hl("@lsp.type.field." .. lang, { fg = c.cyan })
      hl("@lsp.type.parameter." .. lang, { fg = c.blue })
      hl("@lsp.type.namespace." .. lang, { fg = c.soft })
      hl("@lsp.type.variable." .. lang, { fg = c.blue })
      hl("@lsp.typemod.variable.readonly." .. lang, { fg = c.pink })
      hl("@lsp.typemod.property.readonly." .. lang, { fg = c.pink })
    end

  end,
}
