-- Configuração do LSP
local lsp_config = require("lspconfig")
local defaults = require("lsp.defaults")
local util = lsp_config.util
vim.g.lazyvim_php_lsp = "intelephense"

lsp_config.phpactor.setup({
	capabilities = defaults.capabilities,
	on_attach = function(client, bufnr)
		-- Desativar diagnósticos do Phpactor
		client.server_capabilities.diagnosticProvider = false
		defaults.on_attach()(client, bufnr)
	end,
	root_dir = util.root_pattern("composer.json", ".git"),
	filetypes = { "php", "blade" },
	init_options = {
		-- Desativar diagnósticos em diferentes eventos
		["language_server.diagnostics_on_update"] = false,
		["language_server.diagnostics_on_save"] = false,
		["language_server.diagnostics_on_open"] = false,

		-- Opcional: excluir certos caminhos de diagnósticos
		["language_server.diagnostic_exclude_paths"] = {
			"vendor/**/*",
			"node_modules/**/*",
		},

		["language_server_phpstan.enabled"] = false,
		["language_server_psalm.enabled"] = false,
		["indexer.exclude_patterns"] = {
			"*/vendor/*",
			"*/node_modules/*",
		},
		["indexer.include_patterns"] = {
			"app/**/*.php",
			"src/**/*.php",
			"routes/**/*.php",
			"config/**/*.php",
		},
	},
	settings = {
		phpactor = {
			completion = {
				addUseDeclaration = true,
			},
		},
	},
})
-- Configure intelephense (para funcionalidades gratuitas)
lsp_config.intelephense.setup({
	capabilities = defaults.capabilities,
	on_attach = function(client, bufnr)
		-- Configurações específicas para Laravel
		client.server_capabilities.hoverProvider = true
		client.server_capabilities.renameProvider = false -- Para evitar erro em renomeações dinâmicas
		defaults.on_attach()(client, bufnr)
	end,
	root_dir = util.root_pattern("composer.json", ".git"),
	init_options = {
		storagePath = vim.fn.stdpath("cache") .. "/intelephense",
	},
	settings = {
		intelephense = {
			files = {
				maxSize = 1000000,
				includePaths = {
					"./vendor",
					"./app",
					"./src",
					"./routes",
				},
			},
			diagnostics = {
				undefinedTypes = false,
				undefinedFunctions = false,
				undefinedMethods = false,
			},
			environment = {
				phpVersion = "8.1",
			},
			completion = {
				fullyQualifyGlobalConstantsAndFunctions = true,
				triggerParameterHints = true,
				insertUseDeclaration = true,
			},
		},
	},
})
