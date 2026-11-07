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
  local file = vim.fn.fnamemodify(path, ":t:r")
  local parts = vim.split(file, "%%", { plain = true })
  local dir = parts[1]:gsub("%%", "/")

  if jit.os:find("Windows") then
    dir = dir:gsub("^(%w)/", "%1:/")
  end

  return {
    key = file,
    path = path,
    dir = dir,
    branch = parts[2],
  }
end

local function session_items()
  local persistence = require("persistence")
  local names = read_names()
  local items = {}

  for _, path in ipairs(persistence.list()) do
    local item = decode_session(path)
    item.name = names[item.key]
    item.relative_dir = vim.fn.fnamemodify(item.dir, ":~")
    items[#items + 1] = item
  end

  return items, names
end

local function switch_session(item)
  if not item then
    return
  end

  local persistence = require("persistence")
  persistence.save()
  persistence.fire("LoadPre")
  vim.fn.chdir(item.dir)
  vim.cmd("silent! source " .. vim.fn.fnameescape(item.path))
  persistence.fire("LoadPost")
end

function M.open()
  local persistence = require("persistence")
  persistence.save()

  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

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

  local function open_selected(prompt_bufnr)
    local entry = action_state.get_selected_entry()
    actions.close(prompt_bufnr)
    switch_session(entry and entry.value)
  end

  picker = pickers.new({}, {
    prompt_title = "Sessions  <Tab>/<CR> open  •  <C-r>/r rename",
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
      return true
    end,
  })

  picker:find()
end

return M
