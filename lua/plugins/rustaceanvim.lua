local defaults = require("lsp.defaults")

local on_attach = function(_, bufnr)
  local format_sync_grp = vim.api.nvim_create_augroup("Format", {})
  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.rs",
    callback = function()
      vim.lsp.buf.format({ timeout_ms = 200 })
    end,
    group = format_sync_grp,
  })

  vim.opt.updatetime = 300

  local keymap = vim.keymap -- for conciseness

  local opts = { noremap = true, silent = true }

  opts.buffer = bufnr

  -- Rebuild Macros
  opts.desc = "[R]ebuild [M]acros"
  keymap.set("n", "<leader>rm", function()
    if vim.fn.expand("%:t") == "Cargo.toml" then
      -- vim.cmd.RustLsp("reloadMacros")
      require("ferris.methods.rebuild_macros")
    end
  end, opts)

  -- Reload Workspace
  opts.desc = "[R]eload [W]orkspace"
  keymap.set("n", "<leader>rw", function()
    if vim.fn.expand("%:t") == "Cargo.toml" then
      -- vim.cmd.RustLsp("reloadMacros")
      local workspaces = require("ferris.methods.reload_workspace")
      workspaces()
    end
  end, opts)
end

return {
  "mrcjkb/rustaceanvim",
  version = "^6", -- Recommended
  lazy = false, -- This plugin is already lazy
  config = function()
    vim.g.rustaceanvim = {
      tools = {
        float_win_config = {
          border = "rounded",
        },
        server = {
          on_attach = function(client, bufnr)
            -- you can also put keymaps in here
            defaults.on_attach({ data = { client_id = client.id }, buf = bufnr })

            vim.opt.updatetime = 300
            vim.keymap.set("n", "<leader>dr", function()
              vim.cmd.RustLsp("debuggables")
            end, { desc = "Rust Debuggables", buffer = bufnr })
            on_attach(client, bufnr)
          end,
          default_settings = {
            -- rust-analyzer language server configuration
            ["rust-analyzer"] = {
              -- checkOnSave = { command = "clippy" },
              checkOnSave = { command = false },
              -- diagnostics = {
              --   -- enable = diagnostics == "rust-analyzer",
              --   enable = true,
              --   disabled = { "inactive-code" },
              --   experimental = {
              --     enable = false,
              --   },
              -- },
              files = {
                excludeDirs = {
                  ".direnv",
                  ".git",
                  ".github",
                  ".gitlab",
                  "bin",
                  "node_modules",
                  "target",
                  "venv",
                  ".venv",
                },
                watcher = "notify",
              },
              -- cachePriming = {
              --   enable = true,
              -- },
            },
          },
        },
      },
    }
  end,
}
