return {
	"chrisgrieser/nvim-spider",
	lazy = true,
	event = "VeryLazy",
	config = function()
		local spider = require("spider")
		spider.setup({
			skipInsignificantPunctuation = true,
			consistentOperatorPending = false,
			subwordMovement = true,
			-- customPatterns = {
			-- 	"_%a", -- Para capturar a primeira letra maiúscula ou minúscula após o "_"
			-- },
		})
		spider.motion("w", {
			customPatterns = { patterns = { "_%a" }, overrideDefault = false },
		})
		-- vim.keymap.set({ "n", "o", "x" }, "w", "<cmd>lua require('spider').motion('w')<CR>", { desc = "Spider-w" })
		-- vim.keymap.set({ "n", "o", "x" }, "e", "<cmd>lua require('spider').motion('e')<CR>", { desc = "Spider-e" })
		-- vim.keymap.set({ "n", "o", "x" }, "b", "<cmd>lua require('spider').motion('b')<CR>", { desc = "Spider-b" })
	end,
}
