return {
	"rose-pine/neovim",
	name = "rose-pine",
	priority = 1000,
	config = function()
		-- load the colorscheme here
		vim.cmd([[colorscheme rose-pine-moon]])
		require("rose-pine").setup({
			variant = "auto", -- auto, main, moon, or dawn
			dark_variant = "main", -- main, moon, or daw
			enable = {
				terminal = true,
				legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
				migrations = true, -- Handle deprecated options automatically
			},
		})
	end,
}
