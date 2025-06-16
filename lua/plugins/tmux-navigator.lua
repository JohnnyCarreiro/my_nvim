local keymap = vim.keymap
vim.g.tmux_navigator_no_mappings = 1 -- evita que o plugin sobrescreva teclas

return {
  "christoomey/vim-tmux-navigator",
  config = function()
    keymap.set("n", "<C-h>", ":TmuxNavigateLeft<CR>", { desc = "Navigate left" })
    keymap.set("n", "<C-j>", ":TmuxNavigateDown<CR>", { desc = "Navigate down" })
    keymap.set("n", "<C-k>", ":TmuxNavigateUp<CR>", { desc = "Navigate up" })
    keymap.set("n", "<C-l>", ":TmuxNavigateRight<CR>", { desc = "Navigate right" })
  end,
}
