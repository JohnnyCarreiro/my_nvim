return {
  "shortcuts/no-neck-pain.nvim",
  version = "*",
  config = function()
    require("no-neck-pain").setup({
      --- @type integer|"textwidth"|"colorcolumn"
      width = 130,
      --- @type integer
      minSideBufferWidth = 10,
      -- Disables the plugin if the last valid buffer in the list have been closed.
      --- @type boolean
      disableOnLastBuffer = true,
      -- When `true`, disabling the plugin closes every other windows except the initially focused one.
      --- @type boolean
      killAllBuffersOnDisable = false,
      -- When `true`, deleting the main no-neck-pain buffer with `:bd`, `:bdelete` does not disable the plugin, it fallbacks on the newly focused window and refreshes the state by re-creating side-windows if necessary.
      --- @usage: the default value will change to `true` in the next major release (^2.x.y).
      --- @type boolean
      fallbackOnBufferDelete = true,

      -- Adds autocmd (@see `:h autocmd`) which aims at automatically enabling the plugin.
      --- @type table
      autocmds = {
        -- Mude esta linha para `false`
        --- @type boolean
        enableOnVimEnter = false,
        -- Adicione esta linha para ativar o plugin ao ler um buffer (abrir um arquivo)
        -- --- @type boolean
        -- enableOnBufRead = true,
        -- When `true`, entering one of no-neck-pain side buffer will automatically skip it and go to the next available buffer.
        --- @type boolean
        skipEnteringNoNeckPainBuffer = true,
      },
      mappings = {
        -- When `true`, creates all the mappings that are not set to `false`.
        --- @type boolean
        enabled = true,
        -- Sets a global mapping to Neovim, which allows you to toggle the plugin.
        -- When `false`, the mapping is not created.
        --- @type string
        toggle = "<Leader>np",
        -- Sets a global mapping to Neovim, which allows you to toggle the left side buffer.
        -- When `false`, the mapping is not created.
        --- @type string
        toggleLeftSide = "<Leader>nql",
        -- Sets a global mapping to Neovim, which allows you to toggle the right side buffer.
        -- When `false`, the mapping is not created.
        --- @type string
        toggleRightSide = "<Leader>nqr",
        -- Sets a global mapping to Neovim, which allows you to increase the width (+5) of the main window.
        -- When `false`, the mapping is not created.
        --- @type string | { mapping: string, value: number }
        widthUp = "<Leader>n=",
        -- Sets a global mapping to Neovim, which allows you to decrease the width (-5) of the main window.
        -- When `false`, the mapping is not created.
        --- @type string | { mapping: string, value: number }
        widthDown = "<Leader>n-",
        -- Sets a global mapping to Neovim, which allows you to toggle the scratchPad feature.
        -- When `false`, the mapping is not created.
        --- @type string
        scratchPad = "<Leader>ns",
      },
      integrations = {
        NeoTree = {
          -- The position of the tree.
          --- @type "left"|"right"
          position = "left",
          -- When `true`, if the tree was opened before enabling the plugin, we will reopen it.
          reopen = true,
        },
        NvimDAPUI = {
          -- The position of the tree.
          --- @type "none"
          position = "none",
          -- When `true`, if the tree was opened before enabling the plugin, we will reopen it.
          reopen = true,
        },
      },
    })
  end,
}
