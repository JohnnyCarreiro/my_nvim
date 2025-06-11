require("config.keymaps")
require("config.options")
require("config.lazy")
require("lsp.langs")


local server_address = "/tmp/nvim-server." .. vim.fn.getpid() .. ".pipe"
vim.fn.serverstart(server_address)

vim.cmd([[
  if !exists("v:servername")
    call serverstart(']] .. server_address .. [[')
  endif
]])

-- Vamos armazenar o endereço do servidor em uma variável global para passá-lo para o script Fish
vim.g.nvim_server_address = server_address
