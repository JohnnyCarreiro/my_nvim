-- local lspconfig = require("lspconfig")
-- local defaults = require("lsp.defaults")
-- local util = require("lspconfig.util")
--
-- lspconfig["ts_ls"].setup({
--   cmd = { "typescript-language-server", "--stdio" },
--   capabilities = defaults.capabilities,
--   on_attach = function(client, bufnr)
--     defaults.on_attach({ data = { client_id = client.id }, buf = bufnr })
--     if client.supports_method("textDocument/inlayHint") then
--       vim.defer_fn(function()
--         vim.lsp.buf_request(bufnr, "textDocument/inlayHint", {
--           textDocument = { uri = vim.uri_from_bufnr(bufnr) },
--           range = {
--             start = { line = 0, character = 0 },
--             ["end"] = { line = vim.api.nvim_buf_line_count(bufnr), character = 0 },
--           },
--         }, function(_, result)
--           if result and not vim.tbl_isempty(result) then
--             vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
--           end
--         end)
--       end, 500)
--     end
--   end,
--   root_dir = util.root_pattern("tsconfig.app.json", "tsconfig.json", "package.json", "nx.json"),
--   settings = {
--     typescript = {
--       inlayHints = {
--         includeInlayParameterNameHints = "all",
--         includeInlayParameterNameHintsWhenArgumentMatchesName = false,
--         includeInlayFunctionParameterTypeHints = true,
--         includeInlayVariableTypeHints = false, -- set to false for less noisy experience
--         includeInlayVariableTypeHintsWhenTypeMatchesName = false,
--         includeInlayPropertyDeclarationTypeHints = true,
--         includeInlayFunctionLikeReturnTypeHints = true,
--         includeInlayEnumMemberValueHints = true,
--       },
--     },
--     javascript = {
--       inlayHints = {
--         includeInlayParameterNameHints = "all",
--         includeInlayParameterNameHintsWhenArgumentMatchesName = false,
--         includeInlayFunctionParameterTypeHints = true,
--         includeInlayVariableTypeHints = false,
--         includeInlayVariableTypeHintsWhenTypeMatchesName = false,
--         includeInlayPropertyDeclarationTypeHints = true,
--         includeInlayFunctionLikeReturnTypeHints = true,
--         includeInlayEnumMemberValueHints = true,
--       },
--     },
--         init_options = {
--           -- Incluir o `allowImportingTsExtensions` para resolver problemas com importações
--           -- de arquivos .ts/.tsx em arquivos .js/.jsx quando não há um index.ts.
--           -- Isso pode ser útil em alguns cenários de monorepo.
--           allowImportingTsExtensions = true,
--           hostInfo = "neovim",
--           -- Exemplo de como você habilitaria plugins como o @vue/typescript-plugin
--           -- Se você tiver projetos Vue no seu monorepo, descomente e configure.
--           -- plugins = {
--           --   {
--           --     name = "@vue/typescript-plugin",
--           --     location = "PASTA_DO_SEU_NODE_MODULES/@vue/typescript-plugin/index.js", -- Ajuste este caminho
--           --     languages = { "vue" },
--           --   },
--           },
--
--     -- init_options = {
--     -- 	plugins = {
--     -- 		{
--     -- 			name = "@vue/typescript-plugin",
--     -- 			location = vue_language_server_path,
--     -- 			languages = { "vue" },
--     -- 		},
--     -- 	},
--     -- },
--     filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact" },
--   },
-- })
--
-- -- lspconfig["biome"].setup({
-- --   capabilities = defaults.capabilities,
-- --   on_attach = function(client, bufnr)
-- --     defaults.on_attach({ data = { client_id = client.id }, buf = bufnr })
-- --   end,
-- --   cmd = { "biome", "lsp-proxy" },
-- --   -- cmd = { "biome" },
-- --   filetypes = {
-- --     "javascript",
-- --     "javascriptreact",
-- --     "json",
-- --     "jsonc",
-- --     "typescript",
-- --     "typescript.tsx",
-- --     "typescriptreact",
-- --     "astro",
-- --     "svelte",
-- --     "vue",
-- --     "css",
-- --   },
-- -- })
--
-- -- lspconfig["biome"].setup({})
-- lspconfig.biome.setup({
--   cmd_env = {
--     BIOME_UNSAFE_PARAMETER_DECORATORS_ENABLED = "1",
--   },
--   init_options = {
--     settings = {
--       javascript = {
--         parser = {
--           unsafeParameterDecoratorsEnabled = true,
--         },
--       },
--     },
--   },
--   on_attach = function(client, bufnr)
--     -- Optionally disable code diagnostics if you're using ESLint
--     client.server_capabilities.diagnosticProvider = true
--   end,
-- })

-- local lspconfig = require("lspconfig")
-- local defaults = require("lsp.defaults") -- Assumo que 'lsp.defaults' contém suas configurações padrão
-- local util = require("lspconfig.util")
--
-- lspconfig["ts_ls"].setup({
--   cmd = { "typescript-language-server", "--stdio" },
--   capabilities = defaults.capabilities,
--   on_attach = function(client, bufnr)
--     defaults.on_attach({ data = { client_id = client.id }, buf = bufnr })
--
--     -- Ativar inlay hints se o cliente suportar
--     if client.supports_method("textDocument/inlayHint") then
--       vim.defer_fn(function()
--         vim.lsp.buf_request(bufnr, "textDocument/inlayHint", {
--           textDocument = { uri = vim.uri_from_bufnr(bufnr) },
--           range = {
--             start = { line = 0, character = 0 },
--             ["end"] = { line = vim.api.nvim_buf_line_count(bufnr), character = 0 },
--           },
--         }, function(_, result)
--           if result and not vim.tbl_isempty(result) then
--             vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
--           end
--         end)
--       end, 500)
--     end
--   end,
--
--   -- Raiz do projeto:
--   -- Priorize 'nx.json' ou 'workspace.json' (se estiver usando uma versão mais antiga do NX)
--   -- para garantir que o TS LS identifique corretamente o root do monorepo.
--   -- Se o NX estiver configurado para ter tsconfig.base.json na raiz, inclua-o também.
--   root_dir = util.root_pattern("nx.json", "workspace.json", "tsconfig.base.json", "tsconfig.json", "package.json"),
--
--   settings = {
--     typescript = {
--       -- Configurações de inlay hints (já estão boas)
--       inlayHints = {
--         includeInlayParameterNameHints = "all",
--         includeInlayParameterNameHintsWhenArgumentMatchesName = false,
--         includeInlayFunctionParameterTypeHints = true,
--         includeInlayVariableTypeHints = false,
--         includeInlayVariableTypeHintsWhenTypeMatchesName = false,
--         includeInlayPropertyDeclarationTypeHints = true,
--         includeInlayFunctionLikeReturnTypeHints = true,
--         includeInlayEnumMemberValueHints = true,
--       },
--       -- Habilita o auto-import de módulos do monorepo.
--       -- Isso é crucial para o TS LS entender as dependências internas.
--       -- Certifique-se de que o TypeScript do seu projeto NX esteja configurado
--       -- para resolver os paths corretamente (paths no tsconfig.json base).
--       preferences = {
--         importModuleSpecifierPreference = "non-relative",
--       },
--     },
--     javascript = {
--       -- As configurações de inlay hints para JavaScript também estão boas.
--       inlayHints = {
--         includeInlayParameterNameHints = "all",
--         includeInlayParameterNameHintsWhenArgumentMatchesName = false,
--         includeInlayFunctionParameterTypeHints = true,
--         includeInlayVariableTypeHints = false,
--         includeInlayVariableTypeHintsWhenTypeMatchesName = false,
--         includeInlayPropertyDeclarationTypeHints = true,
--         includeInlayFunctionLikeReturnTypeHints = true,
--         includeInlayEnumMemberValueHints = true,
--       },
--       preferences = {
--         importModuleSpecifierPreference = "non-relative",
--       },
--     },
--     -- Inicialização do servidor de linguagem com plugins específicos (se necessário).
--     -- Para NX, geralmente não é necessário um plugin extra para TypeScript em si,
--     -- mas se você tiver frameworks específicos como Vue ou Svelte em seu monorepo,
--     -- a seção `plugins` abaixo pode ser útil.
--     init_options = {
--       -- Incluir o `allowImportingTsExtensions` para resolver problemas com importações
--       -- de arquivos .ts/.tsx em arquivos .js/.jsx quando não há um index.ts.
--       -- Isso pode ser útil em alguns cenários de monorepo.
--       allowImportingTsExtensions = true,
--       hostInfo = "neovim",
--       -- Exemplo de como você habilitaria plugins como o @vue/typescript-plugin
--       -- Se você tiver projetos Vue no seu monorepo, descomente e configure.
--       -- plugins = {
--       --   {
--       --     name = "@vue/typescript-plugin",
--       --     location = "PASTA_DO_SEU_NODE_MODULES/@vue/typescript-plugin/index.js", -- Ajuste este caminho
--       --     languages = { "vue" },
--       --   },
--       -- },
--     },
--     filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "tsx", "jsx" },
--   },
-- })

-- lspconfig.biome.setup({
--   cmd_env = {
--     BIOME_UNSAFE_PARAMETER_DECORATORS_ENABLED = "1",
--   },
--   init_options = {
--     settings = {
--       javascript = {
--         parser = {
--           unsafeParameterDecoratorsEnabled = true,
--         },
--       },
--     },
--   },
--   on_attach = function(client, bufnr)
--     -- Desabilite diagnósticos se quiser que o ESLint seja o principal
--     client.server_capabilities.diagnosticProvider = true
--
--     -- Habilite formatação se você quiser que o Biome formate
--     -- client.server_capabilities.documentFormattingProvider = true
--     -- client.server_capabilities.documentRangeFormattingProvider = true
--
--     -- Remova as linhas que forçam outras capacidades para false,
--     -- pois o Biome não as anuncia de qualquer forma, e o fzf-lua já está filtrando.
--   end,
--   root_dir = util.root_pattern("biome.json", "nx.json", "package.json"),
-- })

local lspconfig = require("lspconfig")
local defaults = require("lsp.defaults")
local util = require("lspconfig.util")

-- Função auxiliar para encontrar o caminho do plugin Vue (se necessário)
-- Você precisará ajustar este caminho para o seu ambiente.
local function find_vue_typescript_plugin_path()
  -- Tenta encontrar o plugin dentro de node_modules na raiz do seu monorepo
  -- ou em algum local centralizado que você usa para dependências.
  local paths = {
    vim.fn.expand("~/.config/nvm/current/lib/node_modules/@vue/typescript-plugin/index.js"), -- Exemplo NVM
    vim.fn.expand(vim.fn.getcwd() .. "/node_modules/@vue/typescript-plugin/index.js"), -- Na raiz do projeto atual
    vim.fn.expand(vim.fn.getcwd() .. "/../../node_modules/@vue/typescript-plugin/index.js"), -- Em um nível superior para monorepos
    -- Adicione outros caminhos onde o plugin pode estar instalado no seu ambiente
  }

  for _, path in ipairs(paths) do
    if vim.fn.filereadable(path) then
      return path
    end
  end
  return nil -- Retorna nil se o plugin não for encontrado
end

-- Se você usa Vue no seu monorepo, descomente e use esta linha
local vue_language_server_path = find_vue_typescript_plugin_path()

lspconfig["ts_ls"].setup({
  cmd = { "typescript-language-server", "--stdio" },
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
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = false, -- set to false for less noisy experience
        includeInlayVariableTypeHintsWhenTypeMatchesName = false,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
      -- **ADICIONADO PARA MONOREPOS:**
      -- Configurações específicas para o serviço de linguagem TypeScript
      -- dentro do contexto de um monorepo.
      tsserver = {
        -- Permite que o servidor de linguagem TypeScript procure por tsconfig.json
        -- em diretórios pai, o que é crucial em monorepos onde os projetos
        -- podem estar aninhados.
        -- Se true, o tsserver pode inferir projetos a partir de um tsconfig pai.
        implicitProjectConfig = {
          checkJs = true,
          allowJs = true,
          jsx = "Preserve",
        },
        -- **ESSENCIAL PARA MONOREPOS NX:**
        -- Habilita o uso de "project references" (referências de projeto)
        -- e inferência de projetos baseada em arquivos de configuração.
        -- Isso é fundamental para que o TypeScript entenda as dependências
        -- entre os diferentes projetos dentro do monorepo.
        -- O `discover` permite que o tsserver procure arquivos de configuração
        -- e referências de projeto.
        -- O `disableAutomaticTypeAcquisition` pode ser útil em monorepos
        -- grandes para evitar que o tsserver tente baixar tipos automaticamente
        -- para cada subprojeto, o que pode ser lento. Gerencie os tipos via `package.json`.
        -- A inclusão de `nodeModules` no `typeAcquisition` é importante para
        -- garantir que os tipos instalados via npm/yarn sejam reconhecidos.
        -- O `enable` para `typeAcquisition` deve ser `true` se você quer que ele
        -- tente inferir tipos em alguns casos, mas controle os `include` e `exclude`
        -- para evitar sobrecarga.
        projectReferences = true,
        disableAutomaticTypeAcquisition = true, -- Pode ser útil para performance em monorepos grandes.
        -- typeAcquisition: {
        --   enable: true,
        --   include: ["node_modules"],
        --   exclude: [],
        -- },
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = false,
        includeInlayVariableTypeHintsWhenTypeMatchesName = false,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
    -- **AJUSTES EM init_options:**
    -- A estrutura estava um pouco incorreta, `init_options` deve ser um irmão de `typescript` e `javascript`
    -- dentro de `settings`.
    init_options = {
      -- Incluir o `allowImportingTsExtensions` para resolver problemas com importações
      -- de arquivos .ts/.tsx em arquivos .js/.jsx quando não há um index.ts.
      -- Isso pode ser útil em alguns cenários de monorepo, especialmente com bundlers.
      allowImportingTsExtensions = true,
      hostInfo = "neovim",
      -- **PLUGINS PARA MONOREPO:**
      -- Se você tem projetos Vue no seu monorepo Nx, você precisa ativar o plugin `@vue/typescript-plugin`.
      -- A localização do plugin é crucial. Certifique-se de que `vue_language_server_path`
      -- aponte para o `index.js` do plugin Vue dentro do seu `node_modules`.
      plugins = {
        -- Descomente e ajuste se você usa Vue.js
        -- {
        --   name = "@vue/typescript-plugin",
        --   location = vue_language_server_path, -- Usando a função auxiliar para encontrar o caminho
        --   languages = { "vue" },
        -- },
      },
    },
    filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" }, -- Adicionado "vue" para suportar arquivos .vue
  },
})

lspconfig.biome.setup({})
