local dap = require("dap")
local dapui = require("dapui")
-- local home = os.getenv("HOME")

-- -- Configuração do DAP para Java
-- dap.adapters.java = function(callback, config)
-- 	require("jdtls").setup_dap({ hotcodereplace = "auto" })
-- end

dap.configurations.java = {
	{
		type = "java",
		request = "attach",
		name = "Debug (Attach) - Remote",
		hostName = "127.0.0.1",
		port = 5005,
	},
}

-- DAP-UI opcional para visualizar informações
dapui.setup()

dap.listeners.before.attach.dapui_config = function()
	dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
	dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
	dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
	dapui.close()
end

-- Mapear teclas para DAP
vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continuar Depuração" })
vim.keymap.set("n", "<leader>dst", dap.terminate, { desc = "Parar Depuração" })
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Alternar Breakpoint" })
vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Abrir REPL" })
vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step Into" })
vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step Over" })
vim.keymap.set("n", "<leader>du", dap.step_out, { desc = "Step Out" })
vim.keymap.set("n", "<leader>dt", dapui.toggle, { desc = "Toggle Debug UI" })

-- Integrar DAP-UI ao ciclo de inicialização/encerramento
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end
