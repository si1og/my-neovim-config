---@type vim.lsp.Config

local function get_jdtls_jvm_args()
  local args = {}

  for arg in (os.getenv("JDTLS_JVM_ARGS") or ""):gmatch("%S+") do
    table.insert(args, "--jvm-arg=" .. arg)
  end

  return unpack(args)
end

local multi_module_root_markers = {
  "mvnw",
  "gradlew",
  "settings.gradle",
  "settings.gradle.kts",
  ".git",
}

local single_module_root_markers = {
  "build.xml",
  "pom.xml",
  "build.gradle",
  "build.gradle.kts",
}

return {
  cmd = function(dispatchers, config)
    local workspace_dir = vim.fn.stdpath("cache") .. "/jdtls/workspace"
    local data_dir = workspace_dir

    if config.root_dir then
      data_dir = data_dir .. "/" .. vim.fn.fnamemodify(config.root_dir, ":p:h:t")
    end

    local cmd = {
      "jdtls",
      "-data",
      data_dir,
      get_jdtls_jvm_args(),
    }

    return vim.lsp.rpc.start(cmd, dispatchers, {
      cwd = config.cmd_cwd,
      env = config.cmd_env,
      detached = config.detached,
    })
  end,
  filetypes = { "java" },
  root_markers = {
    multi_module_root_markers,
    single_module_root_markers,
  },
  init_options = {},
}
