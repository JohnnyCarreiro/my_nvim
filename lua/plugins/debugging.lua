return {
	"mfussenegger/nvim-dap",
	dependencies = { "rcarriga/nvim-dap-ui" },
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		local keymap = vim.keymap

		require("dapui").setup()

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
		keymap.set("n", "<Leader>db", dap.toggle_breakpoint, { desc = "Set Debugging Breakpoint" })
		keymap.set("n", "<Leader>dc", dap.continue, { desc = "In Debug, continue" })
		keymap.set("n", "<leader>dt", dapui.toggle, { desc = "Toggle Debug UI" })

		dap.configurations.dart = {
			{
				type = "dart",
				request = "launch",
				name = "Launch dart",
				dartSdkPath = "/Users/johnnycarreiro/development/flutter/bin/cache/dart-sdk/bin", -- ensure this is correct
				flutterSdkPath = "Users/johnnycarreiro/development/flutter/bin/flutter", -- ensure this is correct
				program = "${workspaceFolder}/lib/main.dart", -- ensure this is correct
				cwd = "${workspaceFolder}",
			},
			{
				type = "flutter",
				request = "launch",
				name = "Launch flutter",
				dartSdkPath = "/Users/johnnycarreiro/development/flutter/bin/cache/dart-sdk/bin", -- ensure this is correct
				flutterSdkPath = "Users/johnnycarreiro/development/flutter/bin/flutter", -- ensure this is correct
				program = "${workspaceFolder}/lib/main.dart", -- ensure this is correct
				cwd = "${workspaceFolder}",
			},
		}
		-- Dart CLI adapter (recommended)
		dap.adapters.dart = {
			type = "executable",
			command = "dart", -- if you're using fvm, you'll need to provide the full path to dart (dart.exe for windows users), or you could prepend the fvm command
			args = { "debug_adapter" },
			-- windows users will need to set 'detached' to false
			options = {
				detached = false,
			},
		}
		dap.adapters.flutter = {
			type = "executable",
			command = "flutter", -- if you're using fvm, you'll need to provide the full path to flutter (flutter.bat for windows users), or you could prepend the fvm command
			args = { "debug_adapter" },
			-- windows users will need to set 'detached' to false
			options = {
				detached = false,
			},
		}
	end,
}
