local M = {}
local modes = { "n", "x", "s", "o" }
local global_synced = false

local function is_leader_mapping(lhs)
  return lhs:sub(1, 1) == " " or lhs:sub(1, 7) == "<Space>"
end

local function copy_mappings(mode, bufnr)
  if vim.fn.exists("*NvimConfigTranslateLeaders") ~= 1 then
    return false
  end

  local mappings = bufnr and vim.api.nvim_buf_get_keymap(bufnr, mode) or vim.api.nvim_get_keymap(mode)
  local existing = {}
  local candidates = {}
  local lhs = {}
  for _, mapping in ipairs(mappings) do
    existing[mapping.lhs] = true
    if is_leader_mapping(mapping.lhs) then
      candidates[#candidates + 1] = mapping
      lhs[#lhs + 1] = mapping.lhs
    end
  end

  if #candidates == 0 then
    return true
  end

  local ok, translated = pcall(vim.fn.NvimConfigTranslateLeaders, lhs)
  if not ok or #translated ~= #candidates then
    return false
  end

  for index, mapping in ipairs(candidates) do
    local russian_lhs = translated[index]

    if russian_lhs ~= "" and not existing[russian_lhs] then
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
  return true
end

function M.sync_global()
  local complete = true
  for _, mode in ipairs(modes) do
    complete = copy_mappings(mode) and complete
  end
  global_synced = complete
  return complete
end

function M.sync_buffer(bufnr)
  if not bufnr or not vim.api.nvim_buf_is_valid(bufnr) then
    return false
  end

  local complete = true
  for _, mode in ipairs(modes) do
    complete = copy_mappings(mode, bufnr) and complete
  end
  return complete
end

function M.sync(bufnr)
  M.sync_global()
  M.sync_buffer(bufnr)
end

function M.setup()
  local group = vim.api.nvim_create_augroup("russian-leader-keymaps", { clear = true })

  vim.api.nvim_create_autocmd({ "BufEnter", "LspAttach" }, {
    group = group,
    callback = function(event)
      vim.schedule(function()
        if not global_synced then
          M.sync_global()
        end
        M.sync_buffer(event.buf)
      end)
    end,
  })

  vim.api.nvim_create_autocmd("User", {
    group = group,
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
  vim.defer_fn(function()
    if not global_synced then
      M.sync(vim.api.nvim_get_current_buf())
    end
  end, 1000)
end

return M
