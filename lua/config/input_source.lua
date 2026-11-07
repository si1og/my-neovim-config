local M = {
  label = "--",
  source = nil,
  job = nil,
}

local watcher = vim.fn.expand("~/.local/bin/nvim-input-source-watch")

local function label_for(source)
  if vim.fn.exists("*NvimConfigInputSourceLabel") ~= 1 then
    return nil
  end

  local ok, label = pcall(vim.fn.NvimConfigInputSourceLabel, source)
  return ok and label or nil
end

local function refresh_statusline()
  vim.schedule(function()
    local ok, lualine = pcall(require, "lualine")
    if ok then
      lualine.refresh({ place = { "statusline" } })
    end
  end)
end

function M.setup()
  if M.job or vim.fn.executable(watcher) ~= 1 then
    return
  end

  M.job = vim.fn.jobstart({ watcher }, {
    stdout_buffered = false,
    on_stdout = function(_, data)
      for _, source in ipairs(data or {}) do
        source = vim.trim(source)
        if source ~= "" then
          M.source = source
          M.label = nil
          refresh_statusline()
        end
      end
    end,
    on_exit = function()
      M.job = nil
      M.label = "--"
      M.source = nil
      refresh_statusline()
    end,
  })

  vim.api.nvim_create_autocmd("VimLeavePre", {
    group = vim.api.nvim_create_augroup("input-source-watcher", { clear = true }),
    once = true,
    callback = function()
      if M.job then
        vim.fn.jobstop(M.job)
      end
    end,
  })
end

function M.status()
  if not M.label and M.source then
    M.label = label_for(M.source)
  end
  return M.label or "--"
end

return M
