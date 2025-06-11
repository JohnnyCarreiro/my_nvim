local lsp_config = require("lspconfig")
local defaults = require("lsp.defaults")

lsp_config["tailwindcss"].setup({
	capabilities = defaults.capabilities,
	on_attach = function(client, bufnr)
  if defaults.on_attach then
    defaults.on_attach({
      data = { client_id = client and client.id or nil }, 
      buf = bufnr
    })
  end
end,
	filetypes = {
		"html",
		"typescriptreact",
		"javascriptreact",
		"css",
		"sass",
		"scss",
		"less",
		"typescript",
		"javascript",
	},
})
