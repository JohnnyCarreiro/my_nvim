-- return -- lazy.nvim ou packer.nvim
-- {
--   "ojroques/nvim-osc52",
--   config = function()
--     require("osc52").setup()
--     vim.keymap.set("n", "<leader>y", require("osc52").copy_operator, { expr = true })
--     vim.keymap.set("n", "<leader>p", '"+p') -- se quiser colar do clipboard
--     vim.keymap.set("v", "<leader>y", require("osc52").copy_visual)
--   end,
-- }

return {
  "ojroques/nvim-osc52",
  config = function()
    local osc52 = require("osc52")

    osc52.setup({
      max_length = 0, -- sem limite de bytes
      silent = false, -- mostra mensagem no Neovim
      trim = false, -- não corta espaço final
    })

    -- Redefinir yank para sempre copiar via OSC52
    local function copy()
      if vim.v.event.operator == "y" and vim.v.event.regname == "" then
        osc52.copy_register("")
      end
    end

    vim.api.nvim_create_autocmd("TextYankPost", {
      callback = copy,
    })
  end,
}
