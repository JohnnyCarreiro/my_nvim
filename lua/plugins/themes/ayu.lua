return {
	"Shatur/neovim-ayu",
	-- priority = 1000,
	config = function()
		require("ayu").setup({
			terminal = false,
		})
		-- vim.cmd([[colorscheme ayu-dark]])
	end,
}
