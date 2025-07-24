return {
  "pmizio/typescript-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  opts = {
    settings = {
      complete_function_calls = true,
      tsserver_file_preferences = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = false,
        includeInlayVariableTypeHintsWhenTypeMatchesName = false,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
      tsserver_format_options = {
        allowIncompleteCompletions = false,
        allowRenameOfImportPath = false,
      },
      tsserver_max_memory = "auto",
      -- tsserver_max_memory = 3072,
      -- tsserver_max_memory = 2049,
      -- tsserver_max_memory = 1792, -- 1.75GB
    },
  },
  config = function(_, opts)
    require("typescript-tools").setup(opts)
    vim.api.nvim_create_user_command("RestartTS", function()
      for _, client in pairs(vim.lsp.get_active_clients()) do
        if client.name == "typescript-tools" then
          vim.lsp.stop_client(client.id)
          vim.notify("Restarted TypeScript Tools LSP", vim.log.levels.INFO)
        end
      end
    end, { desc = "Restart TypeScript Tools LSP server" })
  end,
}
