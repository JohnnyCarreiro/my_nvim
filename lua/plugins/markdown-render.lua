return {
	"MeanderingProgrammer/render-markdown.nvim",
	opts = {},
	-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
	-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
	config = function(_, opts)
		local markdown = require("render-markdown")
		local keymap = vim.keymap
		markdown.setup(opts)
		keymap.set("n", "<leader>md", function()
			markdown.toggle()
		end, { desc = "Render Markdown" })
	end,
}
