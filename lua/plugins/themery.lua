return {
	"zaldih/themery.nvim",
	config = function()
		require("themery").setup({
			themes = {
				{
					name = "Rose Pine",
					colorscheme = "rose-pine-moon",
					before = [[ vim.opt.background = "dark" ]],
				},
				{
					name = "Ayu",
					colorscheme = "ayu-mirage",
					before = [[ vim.opt.background = "dark" ]],
					after = [[-- Same as before, but after if you need it]],
				},
				{
					name = "Dusk Fox",
					colorscheme = "duskfox",
					before = [[ vim.opt.background = "dark" ]],
					after = [[-- Same as before, but after if you need it]],
				},
				{
					name = "Day Fox",
					colorscheme = "dayfox",
					before = [[ vim.opt.background = "light" ]],
					after = [[-- Same as before, but after if you need it]],
				},
				{
					name = "Nord Fox",
					colorscheme = "nordfox",
					before = [[ vim.opt.background = "dark" ]],
					after = [[-- Same as before, but after if you need it]],
				},
				{
					name = "Night Fox",
					colorscheme = "nightfox",
					before = [[ vim.opt.background = "dark" ]],
					after = [[-- Same as before, but after if you need it]],
				},
				{
					name = "Catppuccin",
					colorscheme = "catppuccin-mocha",
					before = [[ vim.opt.background = "dark" ]],
					after = [[-- Same as before, but after if you need it]],
				},
				-- {
				-- 	name = "Dust Fox",
				-- 	colorscheme = "dustfox",
				-- 	before = [[ vim.opt.background = "dark" ]],
				-- 	after = [[-- Same as before, but after if you need it]],
				-- },
				-- {
				-- 	name = "Dust Fox",
				-- 	colorscheme = "dustfox",
				-- 	before = [[ vim.opt.background = "dark" ]],
				-- 	after = [[-- Same as before, but after if you need it]],
				-- },
			},
			livePreview = true,
		})
	end,
}
