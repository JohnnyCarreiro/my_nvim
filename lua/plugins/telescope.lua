return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      -- telescope.load_extension("scope")

      telescope.setup({
        picker = {
          find_files = {
            hidden = true,
            no_ignore = true,
            find_command = {
              "fd",
              "--type",
              "f",
              "--no-ignore-vcs",
              "--color=never",
              "--hidden",
              "--follow",
            },
          },
        },
        defaults = {
          path_display = { "truncate " },
          mappings = {
            i = {
              ["<C-k>"] = actions.move_selection_previous, -- move to prev result
              ["<C-j>"] = actions.move_selection_next, -- move to next result
              ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            },
            file_ignore_patterns = {
              "node_modules",
              "*.class",
            },
          },
        },
      })

      telescope.load_extension("fzf")

      -- set keymaps
      local keymap = vim.keymap -- for conciseness
      local builtin = require("telescope.builtin")
      keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Fuzzy find file in cwd" })
      keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Fuzzy find recent files" })
      keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Find Strings in cwd" })
      keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find on open buffers" })
      keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Open find helpes" })
      keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Find Keymaps" })
      keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "Find Word under Cursor" })
      keymap.set("n", "<leader>fr", builtin.resume, { desc = "Resume last Telescope search" })
    end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      local actions = require("telescope.actions")

      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
        defaults = {
          mappings = {
            n = {
              ["q"] = actions.close,
            },
          },
        },
      })
      require("telescope").load_extension("ui-select")
    end,
  },
}
