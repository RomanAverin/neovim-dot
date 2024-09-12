return {
  "nvimdev/dashboard-nvim",
  lazy = false,
  opts = function()
    local table_logo = {
      [[                                                                     ]],
      [[       ███████████           █████      ██                     ]],
      [[      ███████████             █████                             ]],
      [[      ████████████████ ███████████ ███   ███████     ]],
      [[     ████████████████ ████████████ █████ ██████████████   ]],
      [[    ██████████████    █████████████ █████ █████ ████ █████   ]],
      [[  ██████████████████████████████████ █████ █████ ████ █████  ]],
      [[ ██████  ███ █████████████████ ████ █████ █████ ████ ██████ ]],
    }
    local function joinStrings(arr, delimiter)
      return table.concat(arr, delimiter)
    end
    local logo = joinStrings(table_logo, "\n")

    logo = string.rep("\n", 8) .. logo .. "\n\n"

    local opts = {
      theme = "hyper",
      shortcut_type = "number",
      config = {
        header = vim.split(logo, "\n"),
        shortcut = {
          { desc = "󰊳 Update", group = "@property", action = "Lazy update", key = "u" },
          {
            icon = " ",
            icon_hl = "@variable",
            desc = "Files",
            group = "Label",
            action = "Telescope find_files",
            key = "f",
          },
          {
            desc = "  Keymaps",
            group = "DiagnosticHint",
            action = "Telescope keymaps",
            key = "m",
          },
          {
            desc = " dotfiles",
            group = "Number",
            action = "Telescope dotfiles",
            key = "d",
          },
        },
      },
    }

    -- open dashboard after closing lazy
    if vim.o.filetype == "lazy" then
      vim.api.nvim_create_autocmd("WinClosed", {
        pattern = tostring(vim.api.nvim_get_current_win()),
        once = true,
        callback = function()
          vim.schedule(function()
            vim.api.nvim_exec_autocmds("UIEnter", { group = "dashboard" })
          end)
        end,
      })
    end

    return opts
  end,
}
