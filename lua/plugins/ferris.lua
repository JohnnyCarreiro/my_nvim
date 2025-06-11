local defaults = require("lsp.defaults")

return {
  "vxpm/ferris.nvim",
  lazy = false,
  config = function()
    require("ferris").setup({
      on_attach = function(client, bufnr)
        defaults.on_attach({ data = { client_id = client.id }, buf = bufnr })
      end,
    })
  end,
}
