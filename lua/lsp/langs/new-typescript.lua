local lspconfig = require("lspconfig")
local defaults = require("lsp.defaults") -- Assumo que 'lsp.defaults' contém suas configurações padrão
local util = require("lspconfig.util")

lspconfig["vtsls"].setup({
  cmd = { "vtsls", "--stdio" }, -- O comando para iniciar o vtsls
  capabilities = defaults.capabilities,
  on_attach = function(client, bufnr)
    defaults.on_attach({ data = { client_id = client.id }, buf = bufnr })

    -- A lógica para inlay hints no on_attach está correta em si.
    -- O problema anterior era na forma como as *settings* eram passadas.
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
            vim.notify("Inlay hints enabled for buffer " .. bufnr, vim.log.levels.INFO)
          else
            vim.notify(
              "Inlay hints request returned empty or nil for buffer "
                .. bufnr
                .. ". Check VTSLS settings and project context.",
              vim.log.levels.WARN
            )
          end
        end)
      end, 500) -- Pode ajustar este delay se o monorepo for muito grande
    else
      vim.notify("VTSLS client does NOT support textDocument/inlayHint for buffer " .. bufnr, vim.log.levels.WARN)
    end
  end,

  -- Raiz do projeto:
  -- Mantenha a mesma lógica de root_dir que funcionou para o ts_ls,
  -- priorizando 'nx.json', 'workspace.json' e 'tsconfig.base.json' para monorepos NX.
  root_dir = util.root_pattern("nx.json", "workspace.json", "tsconfig.base.json", "tsconfig.json", "package.json"),

  settings = {
    typescript = {
      -- CORRIGIDO: Usando a estrutura de inlayHints recomendada pelo VTSLS
      inlayHints = {
        parameterNames = { enabled = "literals" }, -- Usando "literals" conforme sua recomendação
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      },
      preferences = {
        importModuleSpecifierPreference = "non-relative",
        includePackageJsonAutoImports = "auto",
      },
      updateImportsOnFileMove = { enabled = "always" },
      suggest = {
        completeFunctionCalls = true,
      },
      tsserver = {
        maxTsServerMemory = 8192,
      },
    },
    javascript = {
      -- CORRIGIDO: Aplicando a mesma estrutura para JavaScript
      inlayHints = {
        parameterNames = { enabled = "literals" },
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      },
      preferences = {
        importModuleSpecifierPreference = "non-relative",
        includePackageJsonAutoImports = "auto",
      },
      updateImportsOnFileMove = { enabled = "always" },
      suggest = {
        completeFunctionCalls = true,
      },
    },
    init_options = {
      allowImportingTsExtensions = true,
      hostInfo = "neovim",
    },
    filetypes = {
      "typescript",
      "javascript",
      "javascriptreact",
      "typescriptreact",
      "tsx",
      "jsx",
      "vue",
      "astro",
      "svelte",
    },
  },
})
