local M = {}

local names_file = vim.fn.stdpath("state") .. "/sessions/names.json"

local function read_names()
  local ok, lines = pcall(vim.fn.readfile, names_file)
  if not ok or #lines == 0 then
    return {}
  end

  local decoded_ok, names = pcall(vim.json.decode, table.concat(lines, "\n"))
  return decoded_ok and type(names) == "table" and names or {}
end

local function write_names(names)
  vim.fn.mkdir(vim.fn.fnamemodify(names_file, ":h"), "p")
  vim.fn.writefile({ vim.json.encode(names) }, names_file)
end

local function decode_session(path)
  if vim.fn.exists("*NvimConfigDecodeSession") ~= 1 then
    return nil
  end

  local file = vim.fn.fnamemodify(path, ":t:r")
  local ok, decoded = pcall(vim.fn.NvimConfigDecodeSession, path)
  if not ok then
    return nil
  end
  local dir = decoded[1]

  if jit.os:find("Windows") then
    dir = dir:gsub("^(%w)/", "%1:/")
  end

  return {
    key = file,
    path = path,
    dir = dir,
    branch = decoded[2] ~= "" and decoded[2] or nil,
  }
end

local function session_items()
  local persistence = require("persistence")
  local names = read_names()
  local items = {}

  for _, path in ipairs(persistence.list()) do
    local item = decode_session(path)
    if item then
      item.name = names[item.key]
      item.relative_dir = vim.fn.fnamemodify(item.dir, ":~")
      items[#items + 1] = item
    end
  end

  return items, names
end

local function switch_session(item)
  if not item then
    return
  end

  local persistence = require("persistence")
  local session_persistence = require("config.session_persistence")
  if persistence.active() then
    session_persistence.save()
  end
  persistence.fire("LoadPre")
  session_persistence.close_all_buffers()
  vim.fn.chdir(item.dir)
  vim.cmd("silent! source " .. vim.fn.fnameescape(item.path))
  session_persistence.remove_directory_buffers()
  persistence.fire("LoadPost")
  if not persistence.active() then
    persistence.start()
  end
end

function M.open()
  local persistence = require("persistence")
  require("config.session_persistence").save()

  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  local function translated(key)
    return vim.fn.NvimConfigTranslateKeys(key)
  end

  local picker
  local items, names = session_items()

  local function finder()
    return finders.new_table({
      results = items,
      entry_maker = function(item)
        local label = item.name and (item.name .. "  " .. item.relative_dir) or item.relative_dir
        if item.branch then
          label = label .. "  [" .. item.branch .. "]"
        end

        return {
          value = item,
          display = label,
          ordinal = table.concat({ item.name or "", item.relative_dir, item.branch or "" }, " "),
          path = item.path,
        }
      end,
    })
  end

  local function rename_session(prompt_bufnr)
    local entry = action_state.get_selected_entry()
    if not entry then
      return
    end

    vim.ui.input({
      prompt = "Session name: ",
      default = entry.value.name or "",
    }, function(name)
      if name == nil then
        return
      end

      name = vim.trim(name)
      names[entry.value.key] = name ~= "" and name or nil
      write_names(names)
      entry.value.name = names[entry.value.key]
      picker:refresh(finder(), { reset_prompt = false })
    end)
  end

  local function delete_session()
    local entry = action_state.get_selected_entry()
    if not entry then
      return
    end

    local item = entry.value
    local label = item.name or item.relative_dir
    local choice = vim.fn.confirm('Delete session "' .. label .. '"?', "&Delete\n&Cancel", 2)
    if choice ~= 1 then
      return
    end

    if vim.fn.delete(item.path) ~= 0 then
      vim.notify("Failed to delete session: " .. item.path, vim.log.levels.ERROR)
      return
    end

    if item.path == persistence.current() then
      persistence.stop()
    end

    names[item.key] = nil
    write_names(names)
    items = vim.tbl_filter(function(candidate)
      return candidate.path ~= item.path
    end, items)
    picker:refresh(finder(), { reset_prompt = false })
  end

  local function open_selected(prompt_bufnr)
    local entry = action_state.get_selected_entry()
    if not entry or not require("config.session_persistence").confirm_discard_modified() then
      return
    end
    actions.close(prompt_bufnr)
    switch_session(entry.value)
  end

  picker = pickers.new({}, {
    prompt_title = "Sessions  <Tab>/<CR> open  •  r/к rename  •  d/в delete",
    initial_mode = "normal",
    finder = finder(),
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        open_selected(prompt_bufnr)
      end)

      map("i", "<Tab>", open_selected)
      map("n", "<Tab>", open_selected)
      map("i", "<C-r>", rename_session)
      map("n", "r", rename_session)
      map("n", translated("r"), rename_session)
      map("n", "d", delete_session)
      map("n", translated("d"), delete_session)
      map("n", translated("j"), actions.move_selection_next)
      map("n", translated("k"), actions.move_selection_previous)
      return true
    end,
  })

  picker:find()
end

return M
