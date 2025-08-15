-- Reload plugins
vim.keymap.set("n", "<leader>ur", function()
  local plugins = require("lazy").plugins()
  local plugin_names = {}
  for _, plugin in ipairs(plugins) do
    table.insert(plugin_names, plugin.name)
  end

  vim.ui.select(plugin_names, {
    title = "Reload plugin",
  }, function(selected)
    require("lazy").reload({ plugins = { selected } })
  end)
end, { desc = "Reload plugin" })

-- Toggle diagnostic virtual_lines
vim.keymap.set("n", "<leader>uv", function()
  local virtual_lines_config = not vim.diagnostic.config().virtual_lines
  local config = vim.diagnostic.config()
  config.virtual_lines = virtual_lines_config

  vim.diagnostic.config(config)
end, { desc = "Toggle diagnostic virtual_lines" })
