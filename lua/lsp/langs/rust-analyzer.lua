local lspconfig = require("lspconfig")
local defaults = require("lsp.defaults")

local on_attach = function(_, bufnr)
  -- local format_sync_grp = vim.api.nvim_create_augroup("Format", {})
  -- vim.api.nvim_create_autocmd("BufWritePre", {
  --   pattern = "*.rs",
  --   callback = function()
  --     vim.lsp.buf.format({ timeout_ms = 200 })
  --   end,
  --   group = format_sync_grp,
  -- })

  -- Auto-format on save
  local format_sync_grp = vim.api.nvim_create_augroup("LspFormat", {})
  vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = bufnr,
    callback = function()
      vim.lsp.buf.format({ timeout_ms = 200 })
    end,
    group = format_sync_grp,
  })

  vim.opt.updatetime = 300

  vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })

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
      require("ferris.methods.reload_workspace")
    end
  end, opts)

  -- set keybinds
  opts.desc = "Show LSP references"
  keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

  opts.desc = "Go to declaration"
  keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

  opts.desc = "Show LSP definitions"
  keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions
end

lspconfig["rust_analyzer"].setup({
  cmd = { "/Users/johnnycarreiro/.cargo/bin/rust-analyzer" },
  capabilities = defaults.capabilities,
  on_attach = function(client, bufnr)
    defaults.on_attach({ data = { client_id = client.id }, buf = bufnr })
    if client.supports_method("textDocument/inlayHint") then
      vim.defer_fn(function()
        vim.lsp.buf_request(bufnr, "textDocument/inlayHint", {
          textDocument = { uri = vim.uri_from_bufnr(bufnr) },
          range = {
            start = { line = 0, character = 0 },
            ["end"] = { line = vim.api.nvim_buf_line_count(bufnr), character = 0 },
          },
        }, function(_, result)
          if result and not vim.tbl_isempty(result) then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
          end
        end)
      end, 500)
    end
    on_attach(client, bufnr)
  end,
  settings = {
    ["rust-analyzer"] = {
      assist = {
        importEnforceGranularity = true,
        importPrefix = "crate",
      },
      cargo = {
        allFeatures = true,
        loadOutDirsFromCheck = true,
        buildScripts = {
          enable = true,
        },
      },
      -- Add clippy lints for Rust.
      checkOnSave = { command = "clippy" },
      check = { command = "clippy" },
      procMacro = {
        enable = true,
        ignored = {
          ["async-trait"] = { "async_trait" },
          ["napi-derive"] = { "napi" },
          ["async-recursion"] = { "async_recursion" },
        },
      },
      rustfmt = {
        overrideCommand = { tab_spaces = 2 },
      },
      diagnostics = {
        enable = true,
        experimental = {
          enable = true,
        },
      },
    },
  },
})
