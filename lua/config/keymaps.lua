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

-- Free Alt+h/j/k/l for tmux
local del = vim.keymap.del
-- A-j/A-k (move lines) set by LazyVim
pcall(del, "n", "<A-j>")
pcall(del, "n", "<A-k>")
pcall(del, "i", "<A-j>")
pcall(del, "i", "<A-k>")
pcall(del, "v", "<A-j>")
pcall(del, "v", "<A-k>")
-- A-h/A-l not set by LazyVim globally, but delete just in case
pcall(del, "n", "<A-h>")
pcall(del, "n", "<A-l>")
pcall(del, "i", "<A-h>")
pcall(del, "i", "<A-l>")
pcall(del, "v", "<A-h>")
pcall(del, "v", "<A-l>")
