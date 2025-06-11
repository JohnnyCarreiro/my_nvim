return {
	"shellRaining/hlchunk.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("hlchunk").setup({
			chunk = {
				enable = true,
				priority = 15,
				style = {
					{ fg = "#65D1FF" },
					{ fg = "#c21f30" },
				},
				use_treesitter = true,
				chars = {
					horizontal_line = "─",
					vertical_line = "│",
					left_top = "╭",
					left_bottom = "╰",
					right_arrow = ">",
				},
				textobject = "",
				max_file_size = 1024 * 1024,
				error_sign = true,
				-- animation related
				duration = 200,
				delay = 300,
				exclude_filetypes = {
					aerial = true,
					dashboard = true,
					-- some other filetypes
				},
			},
			line_num = {
				enable = true,
				style = "#65D1FF",
				priority = 10,
				use_treesitter = false,
			},
		})
	end,
}
