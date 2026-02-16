return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },

    config = function()
      require("codecompanion").setup({
        strategies = {
          chat = {
            adapter = "claude_code",
          },
          inline = {
            adapter = "claude_code",
          },
          cmd = {
            adapter = "claude_code",
          },
        },
        adapters = {
          acp = {
            claude_code = function()
              return require("codecompanion.adapters").extend("claude_code", {
                env = {
                  CLAUDE_CODE_OAUTH_TOKEN = "CLAUDE_OAUTH_TOKEN",
                },
              })
            end,
          },
        },
        extensions = {
          mcphub = {
            callback = "mcphub.extensions.codecompanion",
            opts = {
              make_tools = true,
              show_server_tools_in_chat = true,
              show_result_in_chat = true,
              make_slash_commands = true,
              make_vars = true,
            },
          },
        },
      })

      -- Keymaps
      vim.keymap.set({ "n", "v" }, "<leader>Cc", "<cmd>CodeCompanionChat<cr>", { desc = "CodeCompanion Chat" })
      vim.keymap.set({ "n", "v" }, "<leader>Ca", "<cmd>CodeCompanionActions<cr>", { desc = "CodeCompanion Actions" })
      vim.keymap.set({ "n", "v" }, "<leader>Ct", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "Toggle Chat" })
      vim.keymap.set("v", "<leader>Ce", "<cmd>CodeCompanion<cr>", { desc = "Inline Edit" })
    end,
  },
  {
    "ravitemer/mcphub.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    build = "npm install -g mcp-hub@latest", -- Installs `mcp-hub` node binary globally
    config = function()
      require("mcphub").setup()
    end,
  },
}
