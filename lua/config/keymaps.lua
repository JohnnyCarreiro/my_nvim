-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

----------------------- General Keymaps -------------------
keymap.set({ "n", "v" }, "j", function()
  return vim.v.count > 0 and "j" or "gj"
end, { expr = true })

keymap.set({ "n", "v" }, "k", function()
  return vim.v.count > 0 and "k" or "gk"
end, { expr = true })

-- use jk to exit insert  and  visual mode
keymap.set({ "i", "v", "t", "s" }, "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- delete single character without copying into register
-- keymap.set("n", "x", '"_x')
-- disable inlay tab in insert mode
vim.api.nvim_set_keymap("i", "<Tab>", "<Tab>", { noremap = true })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- Move lines
keymap.set("n", "<CS-j>", ":m .+1<CR>==", { desc = "Move line down (n)" })
keymap.set("n", "<CS-k>", ":m .-2<CR>==", { desc = "Move line up (n)" })
keymap.set("v", "<CS-j>", ":m '>+1<CR>gv=gv", { desc = "Move line down (v)" })
keymap.set("v", "<CS-k>", ":m '<-2<CR>gv=gv", { desc = "Move line up (v)" })

-- Pane navigation
keymap.set("n", "C-h", ":wincmd h<CR>", {})
keymap.set("n", "C-j", ":wincmd j<CR>", {})
keymap.set("n", "C-k", ":wincmd k<CR>", {})
keymap.set("n", "C-l", ":wincmd l<CR>", {})
-- keymap.set("n", "C-h", ":wincmd h<CR>", { noremap = true, silent = true })
-- keymap.set("n", "C-j", ":wincmd j<CR>", { noremap = true, silent = true })
-- keymap.set("n", "C-k", ":wincmd k<CR>", { noremap = true, silent = true })
-- keymap.set("n", "C-l", ":wincmd l<CR>", { noremap = true, silent = true })

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- buffer commands
keymap.set({ "x", "n", "s" }, "<leader>w", "<cmd>w<CR>", { desc = "Save current buffer" }) -- Save current buffer
keymap.set({ "x", "n", "s" }, "<leader>W", "<cmd>wa<CR>", { desc = "Save all buffers" }) -- Save all buffers
keymap.set({ "x", "n", "s" }, "<leader>q", "<cmd>q<CR>", { desc = "Close NeoVim" }) -- Close NeoVim
keymap.set({ "x", "n", "s" }, "<leader>Q", "<cmd>q!<CR>", { desc = "Close And Save NeoVim" }) -- Close NeoVim
keymap.set("n", "<leader>bn", "<cmd>bn<CR>", { desc = "Move to Next Buffer" }) -- Move to next Buffer
keymap.set("n", "<leader>bb", "<cmd>bp<CR>", { desc = "Move to Previous Buffer" }) -- Move to Previous Buffer
keymap.set(
  "n",
  "<leader>bc",
  -- "<cmd>sleep 2m<cr> <cmd>NoNeckPain<cr> <cmd>sleep 100m<cr> <cmd>bd<CR> <cmd>NoNeckPain<cr>",
  "<cmd>bd<CR>",
  { silent = true, desc = "Close current Buffer" }
) -- Move to Previous Buffer
keymap.set("n", "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", { desc = "Toggle pin" }) -- Move to Previous Buffer
keymap.set("n", "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", { desc = "Delete non-pined Buffers" }) -- Move to Previous Buffer

-- Toggle Term
-- keymap.set("n", "<leader>t1", ":ToggleTerm direction=horizontal size=10<CR>", { desc = "Open a bottom Terminal" })
-- keymap.set("n", "<leader>t2", ":ToggleTerm direction=vertical size=40<CR>", { desc = "Open a bottom Terminal" })

-- inlay hints:
keymap.set({ "n", "i" }, "<C-i>", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggle inlay hints" })
-- Runs Dart Tool
keymap.set("n", "<leader>ft", "<cmd> Telescope flutter commands<cr>", { desc = "Runs flutter tools" })

-- Spider Motion
keymap.set({ "n", "o", "x" }, "w", "<cmd>lua require('spider').motion('w')<CR>", { desc = "Spider-w" })
keymap.set({ "n", "o", "x" }, "e", "<cmd>lua require('spider').motion('e')<CR>", { desc = "Spider-e" })
keymap.set({ "n", "o", "x" }, "b", "<cmd>lua require('spider').motion('b')<CR>", { desc = "Spider-b" })

-- DAP
-- local dap = require("dap")
-- keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, { desc = "Set Debugging Breakpoint" })
-- keymap.set("n", "<Leader>dc", dap.continue, { desc = "In Debug, continue" })
-- -- keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, {desc = "Set Debugging Breakpoint"})
-- keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, {desc = "Set Debugging Breakpoint"})
--

-- local buffersKeys = {
-- 	{ "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete Other Buffers" },
-- 	{ "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
-- 	{ "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
-- 	{ "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
-- 	{ "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
-- 	{ "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
-- 	{ "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
-- 	{ "[B", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
-- 	{ "]B", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
-- }

-- Todos
-- keys = {
--     { "]t", function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
--     { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },
--     { "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "Todo (Trouble)" },
--     { "<leader>xT", "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
--     { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
--     { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
--   }

-- Relood nvim configs
vim.api.nvim_set_keymap(
  "n",
  "<leader>so",
  ":source ~/.config/nvim/init.lua<CR>",
  { noremap = true, silent = true, desc = "reload config" }
)

-- File navigation
-- Go to the end of file
vim.api.nvim_set_keymap("n", "ge", "G", { noremap = true })
vim.api.nvim_set_keymap("v", "ge", "G", { noremap = true })

-- Go to the top of file
vim.api.nvim_set_keymap("n", "gg", "gg", { noremap = true })
vim.api.nvim_set_keymap("v", "gg", "gg", { noremap = true })

-- Go to the first character of the line
vim.api.nvim_set_keymap("n", "gs", "^", { noremap = true })
vim.api.nvim_set_keymap("v", "gs", "^", { noremap = true })

-- Go to the last character of the line
vim.api.nvim_set_keymap("n", "gl", "$", { noremap = true })
vim.api.nvim_set_keymap("v", "gl", "$", { noremap = true })

-- Go to the first character of the line in Insert mode
vim.api.nvim_set_keymap("i", "<C-gs>", "^", { noremap = true })

-- Go to the last character of the line in Insert mode
vim.api.nvim_set_keymap("i", "<C-gl>", "$", { noremap = true })

-- Move left and right in Insert mode
vim.api.nvim_set_keymap("i", "<C-h>", "<Left>", { noremap = true })
vim.api.nvim_set_keymap("i", "<C-l>", "<Right>", { noremap = true })

-- Redo
vim.api.nvim_set_keymap("n", "<S-u>", ":redo<CR>", { noremap = true })

vim.keymap.set("n", "-", "<cmd>Oil --float<CR>", { desc = "Open Parent Directory in Oil" })
vim.keymap.set("n", "<leader>gl", function()
  vim.diagnostic.open_float()
end, { desc = "Open Diagnostics in Float" })

vim.keymap.set("n", "<leader>cf", function()
  require("conform").format({
    timeout_ms = 1000,
    async = true,
    lsp_format = "fallback",
  })
end, { desc = "Format current file" })
