---@type vim.lsp.Config
return {
  cmd = { 'yaml-language-server', '--stdio' },
  filetypes = { 'yaml', 'yaml.docker-compose', 'yaml.gitlab', 'yaml.helm-values' },
  root_markers = { 'docker-compose.yaml', 'docker-compose.yml', 'compose.yaml', 'compose.yml', '.git' },
  settings = {
    redhat = {
      telemetry = {
        enabled = false,
      },
    },
    yaml = {
      validate = true,
      completion = true,
      hover = true,
      format = {
        enable = true,
      },
      schemaStore = {
        enable = true,
      },
      schemas = {
        ['https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json'] = {
          'docker-compose*.yml',
          'docker-compose*.yaml',
          'compose*.yml',
          'compose*.yaml',
        },
      },
    },
  },
  on_init = function(client)
    client.server_capabilities.documentFormattingProvider = true
  end,
}
