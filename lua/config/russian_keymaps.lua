local M = {}

local layout = {
  q = "й", w = "ц", e = "у", r = "к", t = "е", y = "н", u = "г", i = "ш", o = "щ", p = "з",
  a = "ф", s = "ы", d = "в", f = "а", g = "п", h = "р", j = "о", k = "л", l = "д",
  z = "я", x = "ч", c = "с", v = "м", b = "и", n = "т", m = "ь",
  Q = "Й", W = "Ц", E = "У", R = "К", T = "Е", Y = "Н", U = "Г", I = "Ш", O = "Щ", P = "З",
  A = "Ф", S = "Ы", D = "В", F = "А", G = "П", H = "Р", J = "О", K = "Л", L = "Д",
  Z = "Я", X = "Ч", C = "С", V = "М", B = "И", N = "Т", M = "Ь",
}

local function translate(lhs)
  local suffix = lhs:match("^<Space>(.*)$") or lhs:match("^ (.*)$")
  if not suffix then
    return nil
  end

  local translated = {}
  local index = 1
  while index <= #suffix do
    if suffix:sub(index, index) == "<" then
      local closing = suffix:find(">", index, true)
      if closing then
        translated[#translated + 1] = suffix:sub(index, closing)
        index = closing + 1
      else
        translated[#translated + 1] = suffix:sub(index, index)
        index = index + 1
      end
    else
      local char = suffix:sub(index, index)
      translated[#translated + 1] = layout[char] or char
      index = index + 1
    end
  end

  local result = " " .. table.concat(translated)
  return result ~= lhs and result or nil
end

local function copy_mappings(mode, bufnr)
  local mappings = bufnr and vim.api.nvim_buf_get_keymap(bufnr, mode) or vim.api.nvim_get_keymap(mode)
  local existing = {}
  for _, mapping in ipairs(mappings) do
    existing[mapping.lhs] = true
  end

  for _, mapping in ipairs(mappings) do
    local russian_lhs = translate(mapping.lhs)
    local rhs = mapping.callback or mapping.rhs

    if russian_lhs and not existing[russian_lhs] and rhs and rhs ~= "" then
      local opts = {
        remap = mapping.noremap == 0,
        silent = mapping.silent == 1,
        expr = mapping.expr == 1,
        nowait = mapping.nowait == 1,
        desc = ((mapping.desc and mapping.desc ~= "") and mapping.desc or "Leader mapping") .. " [RU]",
      }
      if bufnr then
        opts.buffer = bufnr
      end
      if opts.expr then
        opts.replace_keycodes = mapping.replace_keycodes == 1
      end

      pcall(vim.keymap.set, mode, russian_lhs, rhs, opts)
      existing[russian_lhs] = true
    end
  end
end

function M.sync(bufnr)
  for _, mode in ipairs({ "n", "x", "s", "o" }) do
    copy_mappings(mode)
    if bufnr and vim.api.nvim_buf_is_valid(bufnr) then
      copy_mappings(mode, bufnr)
    end
  end
end

function M.setup()
  vim.api.nvim_create_autocmd({ "VimEnter", "BufEnter", "LspAttach" }, {
    group = vim.api.nvim_create_augroup("russian-leader-keymaps", { clear = true }),
    callback = function(event)
      vim.schedule(function()
        M.sync(event.buf)
      end)
    end,
  })

  vim.api.nvim_create_autocmd("User", {
    group = "russian-leader-keymaps",
    pattern = "LazyDone",
    callback = function()
      vim.schedule(function()
        M.sync(vim.api.nvim_get_current_buf())
      end)
    end,
  })

  vim.schedule(function()
    M.sync(vim.api.nvim_get_current_buf())
  end)
end

return M
