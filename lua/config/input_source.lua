local M = {
  label = "--",
  job = nil,
}

local watcher = vim.fn.expand("~/.local/bin/nvim-input-source-watch")

local function label_for(source)
  local id = source:lower()
  if id:find("russian", 1, true) or id:find("cyrillic", 1, true) then
    return "RU"
  end
  if id:find("abc", 1, true) or id:find("us", 1, true) or id:find("british", 1, true) then
    return "EN"
  end

  local name = source:match("([^.]+)$") or source
  return name:sub(1, 3):upper()
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
          M.label = label_for(source)
          refresh_statusline()
        end
      end
    end,
    on_exit = function()
      M.job = nil
      M.label = "--"
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
  return M.label
end

return M
