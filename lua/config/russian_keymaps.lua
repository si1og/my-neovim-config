local M = {}

local function translate(lhs)
  if vim.fn.exists("*NvimConfigTranslateLeader") ~= 1 then
    return nil
  end

  local ok, translated = pcall(vim.fn.NvimConfigTranslateLeader, lhs)
  if not ok or translated == "" then
    return nil
  end
  return translated
end

local function copy_mappings(mode, bufnr)
  local mappings = bufnr and vim.api.nvim_buf_get_keymap(bufnr, mode) or vim.api.nvim_get_keymap(mode)
  local existing = {}
  for _, mapping in ipairs(mappings) do
    existing[mapping.lhs] = true
  end

  for _, mapping in ipairs(mappings) do
    local russian_lhs = translate(mapping.lhs)

    if russian_lhs and not existing[russian_lhs] then
      local opts = {
        -- Dispatch through the original mapping. This is important for
        -- lazy.nvim key handlers, whose callback is tied to the Latin LHS.
        remap = true,
        silent = mapping.silent == 1,
        nowait = mapping.nowait == 1,
        desc = ((mapping.desc and mapping.desc ~= "") and mapping.desc or "Leader mapping") .. " [RU]",
      }
      if bufnr then
        opts.buffer = bufnr
      end

      pcall(vim.keymap.set, mode, russian_lhs, mapping.lhs, opts)
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
