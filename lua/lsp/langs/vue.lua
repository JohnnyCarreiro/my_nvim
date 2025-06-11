local lsp_config = require("lspconfig")
local defaults = require("johnny.lsp.defaults")
local util = require("lspconfig/util")
local mason_registry = require("mason-registry")
local vue_language_server_path = mason_registry.get_package("vue-language-server"):get_install_path()
	.. "/node_modules/@vue/language-server"

lsp_config["volar"].setup({
	cmd = { vue_language_server_path, "--stdio" },
	-- cmd = { "vue-language-server", "--stdio" },
	capabilities = defaults.capabilities,
	on_attach = defaults.on_attach,
	filetypes = { "vue" }, -- Apenas para arquivos Vue
	root_dir = util.root_pattern("package.json", "vue.config.js", "vite.config.ts", "nuxt.config.ts", ".git"),
	init_options = {
		vue = {
			hybridMode = false, -- Habilitar modo não-híbrido (recomendado para standalone Volar)
		},
		languageFeatures = {
			implementation = true,
			references = true,
			definition = true,
			typeDefinition = true,
			callHierarchy = true,
			hover = true,
			rename = true,
			renameFileRefactoring = true,
			signatureHelp = true,
			codeAction = true,
			workspaceSymbol = true,
			completion = {
				defaultTagNameCase = "both",
				defaultAttrNameCase = "kebabCase",
				getDocumentNameCasesRequest = false,
				getDocumentSelectionRequest = false,
			},
			schemaRequestService = true,
			documentHighlight = true,
			documentLink = true,
			codeLens = { showReferencesNotification = true },
			semanticTokens = true,
			diagnostics = true,
		},
		documentFeatures = {
			selectionRange = true,
			foldingRange = true,
			linkedEditingRange = true,
			documentSymbol = true,
			documentColor = true,
			documentFormatting = {
				defaultPrintWidth = 100,
			},
		},
	},
})

vim.filetype.add({
	extension = {
		vue = "vue",
	},
})

vim.cmd([[
  autocmd BufWritePre *.vue lua vim.lsp.buf.format({ async = true })
]])
