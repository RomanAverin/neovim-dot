return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "franco-ruggeri/codecompanion-spinner.nvim",
    { "nvim-lua/plenary.nvim", branch = "master" },
    "ravitemer/mcphub.nvim",
    { "MeanderingProgrammer/render-markdown.nvim", ft = "markdown" },
  },
  init = function()
    require("codecompanion-notify"):init()
  end,
  opts = {
    language = "Russian",
    display = {
      action_palette = {
        width = 95,
        height = 10,
        prompt = "Prompt ", -- Prompt used for interactive LLM calls
        provider = "fzf_lua", -- Can be "default", "telescope", "fzf_lua", "mini_pick" or "snacks". If not specified, the plugin will autodetect installed providers.
        opts = {
          show_default_actions = true, -- Show the default actions in the action palette?
          show_default_prompt_library = true, -- Show the default prompt library in the action palette?
          title = "CodeCompanion actions",
        },
        chat = {
          show_token_count = true,
          start_in_insert_mode = true,
        },
      },
    },
    adapters = {
      http = {
        anthropic = function()
          return require("codecompanion.adapters").extend("anthropic", {
            env = {
              -- api_key = vim.env.ANTROPIC_API_KEY,
              api_key = "cmd:op read op://personal/Antropic_nvim_apikey/password --no-newline",
            },
          })
        end,
        openai = function()
          return require("codecompanion.adapters").extend("openai", {
            opts = {
              vision = true,
              stream = true,
            },
            schema = {
              model = {
                default = "gpt-5-mini",
              },
            },
            env = {
              api_key = "cmd:op read op://Private/CodeCompanion_ChatGPT_API/password --no-newline",
            },
          })
        end,
        openrouter = function()
          return require("codecompanion.adapters").extend("openai_compatible", {
            env = {
              url = "https://openrouter.ai/api",
              -- api_key = "OPENROUTER_API_KEY",
              api_key = "cmd:op read op://Private/CodeCompanion_OpenRoute_API/password --no-newline",
              chat_url = "/v1/chat/completions",
            },
            schema = {
              model = {
                default = "gpt-5-mini",
              },
            },
          })
        end,
      },
      opts = {
        show_model_choices = true,
        allow_insecure = true,
        proxy = "socks5://127.0.0.1:1081",
      },
    },
    strategies = {
      chat = {
        adapter = "openrouter",
        model = "claude-sonnet-4.5",
        slash_commands = {
          ["file"] = {
            -- Location to the slash command in CodeCompanion
            callback = "strategies.chat.slash_commands.file",
            description = "Select a file using fzf",
            opts = {
              provider = "fzf_lua", -- Can be "default", "telescope", "fzf_lua", "mini_pick" or "snacks"
              contains_code = true,
            },
          },
        },
      },
      inline = { adapter = "openrouter", model = "gpt-5-mini" },
      cmd = { adapter = "openrouter", model = "gpt-5-mini" },
    },

    extensions = {
      spinner = {},
      mcphub = {
        callback = "mcphub.extensions.codecompanion",
        opts = {
          make_vars = true,
          make_slash_commands = true,
          show_result_in_chat = true,
        },
      },
    },
  },
}
