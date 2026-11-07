local M = {}

local function is_file_buffer(bufnr)
  if not vim.api.nvim_buf_is_valid(bufnr) or vim.bo[bufnr].buftype ~= "" then
    return false
  end

  local name = vim.api.nvim_buf_get_name(bufnr)
  if name == "" then
    return false
  end

  local stat = (vim.uv or vim.loop).fs_stat(name)
  return not stat or stat.type ~= "directory"
end

function M.has_file_buffers()
  return vim.iter(vim.api.nvim_list_bufs()):any(is_file_buffer)
end

function M.save()
  if not M.has_file_buffers() then
    return false
  end

  local unlisted = {}
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].buflisted and not is_file_buffer(bufnr) then
      vim.bo[bufnr].buflisted = false
      unlisted[#unlisted + 1] = bufnr
    end
  end

  local ok, err = pcall(require("persistence").save)
  for _, bufnr in ipairs(unlisted) do
    if vim.api.nvim_buf_is_valid(bufnr) then
      vim.bo[bufnr].buflisted = true
    end
  end
  if not ok then
    error(err)
  end
  return true
end

function M.confirm_discard_modified()
  local modified = vim.iter(vim.api.nvim_list_bufs()):any(function(bufnr)
    return is_file_buffer(bufnr) and vim.bo[bufnr].modified
  end)
  if not modified then
    return true
  end

  return vim.fn.confirm("Discard unsaved changes and switch session?", "&Switch\n&Cancel", 2) == 1
end

function M.close_all_buffers()
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(bufnr) then
      pcall(vim.api.nvim_buf_delete, bufnr, { force = true })
    end
  end
end

function M.remove_directory_buffers()
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    local name = vim.api.nvim_buf_is_valid(bufnr) and vim.api.nvim_buf_get_name(bufnr) or ""
    local stat = name ~= "" and (vim.uv or vim.loop).fs_stat(name) or nil
    if stat and stat.type == "directory" then
      pcall(vim.api.nvim_buf_delete, bufnr, { force = true })
    end
  end
end

return M
