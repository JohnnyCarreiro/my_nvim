-- tabs & indentation
vim.opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
vim.opt.shiftwidth = 2 -- 2 spaces for indent width
vim.opt.expandtab = true -- expand tab to spaces
vim.opt.autoindent = true -- copy indent from current line when starting new one

vim.opt.wrap = true
vim.opt.guicursor = "n:block"
vim.opt.guicursor = "i:blinkon1"
vim.opt.textwidth = 90

-- vim.opt.clipboard:append("unnamedplus") -- use system clipboard as default register
if vim.fn.has("clipboard") == 1 then
  vim.opt.clipboard:append("unnamedplus")
end

vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.autoindent = true -- Keep identation from previous line

-- Enable break indent
vim.opt.breakindent = true

-- Always show relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- show line under cursor
vim.opt.cursorline = true

-- Store undos between sessions
vim.opt.undofile = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
-- vim.opt.signcolumn = "yes"

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
-- vim.opt.list = true
-- vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 5

-- control commentaries block
vim.opt.foldlevel = 99 -- Impede que outros folds venham fechados
-- vim.opt.foldexpr = "v:lua.ExtendedFoldExpr()" -- Usa a função personalizada
-- vim.opt.foldtext = "v:lua.HighlightedFoldtext()" -- Aplica o highlight nos folds
--
-- vim.api.nvim_create_autocmd("BufReadPost", {
--   callback = function()
--     vim.cmd([[ silent! normal! zR ]]) -- Abre todos os folds
--     vim.cmd([[ silent! g/^\/\*\*/norm zc ]]) -- Fecha apenas os comentários de documentação
--     vim.cmd([[ silent! g/^\/\//norm zc ]]) -- Fecha apenas os comentários de documentação de linha
--   end
-- })
