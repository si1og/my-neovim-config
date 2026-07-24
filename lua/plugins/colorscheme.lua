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
    })

    vim.cmd.colorscheme("kanagawa-wave")

    local c = {
      fg = "#dcd7ba",
      muted = "#727169",
      faint = "#54546d",
      panel = "#2a2a37",
      select = "#363646",
      red = "#c34043",
      orange = "#ffa066",
      yellow = "#c0a36e",
      green = "#98bb6c",
      aqua = "#7aa89f",
      blue = "#7e9cd8",
      purple = "#957fb8",
      pink = "#d27e99",
    }

    local function hl(group, opts)
      vim.api.nvim_set_hl(0, group, opts)
    end

    hl("Normal", { bg = "NONE" })
    hl("NormalNC", { bg = "NONE" })
    hl("EndOfBuffer", { bg = "NONE" })
    hl("SignColumn", { bg = "NONE" })
    hl("Cursor", { fg = "#1f1f28", bg = c.yellow })
    hl("CursorLine", { bg = "NONE" })
    hl("CursorLineNr", { fg = c.yellow, bold = true })
    hl("LineNr", { fg = c.faint })
    hl("Visual", { bg = c.select })
    hl("Search", { fg = "#1f1f28", bg = c.yellow })
    hl("IncSearch", { fg = "#1f1f28", bg = c.orange })
    hl("NormalFloat", { bg = "NONE" })
    hl("FloatBorder", { fg = c.faint, bg = "NONE" })
    hl("WinSeparator", { fg = c.faint, bg = "NONE" })

    hl("Directory", { fg = c.green })
    hl("NeoTreeDirectoryIcon", { fg = c.green })
    hl("NeoTreeDirectoryName", { fg = c.green })
    hl("NeoTreeExpander", { fg = c.green })
    hl("NeoTreeRootName", { fg = c.yellow })
    hl("NvimTreeFolderIcon", { fg = c.green })
    hl("NvimTreeFolderName", { fg = c.green })
    hl("NvimTreeOpenedFolderName", { fg = c.green })

    hl("Pmenu", { fg = c.fg, bg = "NONE" })
    hl("PmenuSel", { fg = c.fg, bg = c.panel, bold = true })
    hl("PmenuSbar", { bg = "NONE" })
    hl("PmenuThumb", { bg = c.faint })
    hl("CmpPmenu", { fg = c.fg, bg = "NONE" })
    hl("CmpPmenuSel", { fg = c.fg, bg = c.panel, bold = true })
    hl("CmpBorder", { fg = c.faint, bg = "NONE" })

    hl("DiagnosticError", { fg = c.red })
    hl("DiagnosticWarn", { fg = c.yellow })
    hl("DiagnosticInfo", { fg = c.blue })
    hl("DiagnosticHint", { fg = c.aqua })
    hl("DiagnosticUnderlineError", { undercurl = true, sp = c.red })
    hl("DiagnosticUnderlineWarn", { undercurl = true, sp = c.yellow })
    hl("DiagnosticUnderlineInfo", { undercurl = true, sp = c.blue })
    hl("DiagnosticUnderlineHint", { undercurl = true, sp = c.aqua })

    hl("@keyword", { fg = c.purple })
    hl("@keyword.conditional", { fg = c.purple })
    hl("@keyword.repeat", { fg = c.purple })
    hl("@keyword.return", { fg = c.red })
    hl("@keyword.import", { fg = c.aqua })
    hl("@keyword.exception", { fg = c.red })
    hl("@operator", { fg = c.muted })
    hl("@punctuation.bracket", { fg = c.muted })
    hl("@punctuation.delimiter", { fg = c.muted })
    hl("@punctuation.special", { fg = c.orange })
    hl("@comment", { fg = c.muted, italic = true })
    hl("@string", { fg = c.green })
    hl("@string.special", { fg = c.aqua })
    hl("@number", { fg = c.pink })
    hl("@boolean", { fg = c.pink })
    hl("@constant", { fg = c.pink })
    hl("@constant.builtin", { fg = c.pink })
    hl("@variable", { fg = c.fg })
    hl("@variable.parameter", { fg = c.fg, italic = true })
    hl("@property", { fg = c.aqua })
    hl("@field", { fg = c.aqua })
    hl("@function", { fg = c.blue })
    hl("@function.call", { fg = c.blue })
    hl("@function.method", { fg = c.blue })
    hl("@function.method.call", { fg = c.blue })
    hl("@constructor", { fg = c.green })
    hl("@type", { fg = c.yellow })
    hl("@type.builtin", { fg = c.yellow, italic = true })
    hl("@module", { fg = c.aqua })
    hl("@namespace", { fg = c.aqua })
    hl("@tag", { fg = c.blue })
    hl("@tag.attribute", { fg = c.aqua })
    hl("@tag.delimiter", { fg = c.muted })

    hl("@type.cs", { fg = c.green })
    hl("@constructor.cs", { fg = c.green })

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
      hl("@lsp.type.class." .. lang, { fg = c.yellow })
      hl("@lsp.type.struct." .. lang, { fg = c.yellow })
      hl("@lsp.type.interface." .. lang, { fg = c.aqua })
      hl("@lsp.type.enum." .. lang, { fg = c.yellow })
      hl("@lsp.type.type." .. lang, { fg = c.yellow })
      hl("@lsp.type.function." .. lang, { fg = c.blue })
      hl("@lsp.type.method." .. lang, { fg = c.blue })
      hl("@lsp.type.property." .. lang, { fg = c.aqua })
      hl("@lsp.type.field." .. lang, { fg = c.aqua })
      hl("@lsp.type.parameter." .. lang, { fg = c.fg, italic = true })
      hl("@lsp.type.namespace." .. lang, { fg = c.aqua })
      hl("@lsp.type.variable." .. lang, { fg = c.fg })
      hl("@lsp.typemod.variable.readonly." .. lang, { fg = c.pink })
      hl("@lsp.typemod.property.readonly." .. lang, { fg = c.pink })
    end

    hl("@lsp.type.class.cs", { fg = c.green })
    hl("@lsp.type.recordClass.cs", { fg = c.green })
    hl("@lsp.type.struct.cs", { fg = c.green })
    hl("@lsp.type.type.cs", { fg = c.green })
    hl("@lsp.type.interface.cs", { fg = c.aqua })
    hl("@lsp.type.enum.cs", { fg = c.yellow })
    hl("@lsp.type.method.cs", { fg = c.blue })
    hl("@lsp.type.extensionMethod.cs", { fg = c.purple })
    hl("@lsp.type.property.cs", { fg = c.aqua })
    hl("@lsp.type.field.cs", { fg = c.aqua })
    hl("@lsp.type.parameter.cs", { fg = c.fg, italic = true })
    hl("@lsp.type.namespace.cs", { fg = c.aqua })
    hl("@lsp.type.variable.cs", { fg = c.fg })
    hl("@lsp.typemod.variable.readonly.cs", { fg = c.pink })
    hl("@lsp.typemod.property.readonly.cs", { fg = c.pink })
  end,
}
