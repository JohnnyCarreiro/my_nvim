-- lua/lsp/default.lua
local M = {}

-- Default capabilities with cmp_nvim_lsp
local original_capabilities = vim.lsp.protocol.make_client_capabilities()
local capabilities = require("blink.cmp").get_lsp_capabilities(original_capabilities)

-- capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false
M.capabilities = capabilities

-- Default on_attach
M.on_attach = function(event)
  vim.opt.updatetime = 300
  vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })

  local map = function(keys, func, desc, mode)
    mode = mode or "n"
    vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
  end

  map("gd", require("fzf-lua").lsp_definitions, "[G]oto [D]efinition")

  -- map("gd", function()
  --   local params = vim.lsp.util.make_position_params()
  --   vim.lsp.buf_request(0, "textDocument/definition", params, function(_, result)
  --     local items = result
  --     if type(result) == "table" and result.result then
  --       items = result.result
  --     end
  --
  --     if not items or vim.tbl_isempty(items) then
  --       vim.notify("No definition found", vim.log.levels.ERROR)
  --     elseif #items == 1 then
  --       vim.lsp.buf.definition(params)
  --     else
  --       require("fzf-lua").lsp_definitions()
  --     end
  --   end)
  -- end, "[G]oto [D]efinition")

  map("gr", require("fzf-lua").lsp_references, "[G]oto [R]eferences")
  map("gI", require("fzf-lua").lsp_implementations, "[G]oto [I]mplementation")
  map("<leader>D", require("fzf-lua").lsp_typedefs, "Type [D]efinition")
  map("<leader>ds", require("fzf-lua").lsp_document_symbols, "[D]ocument [S]ymbols")
  map("<leader>ws", require("fzf-lua").lsp_live_workspace_symbols, "[W]orkspace [S]ymbols")
  map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
  map("<leader>ca", function()
    if vim.fn.expand("%:t") == "Cargo.toml" then
      vim.cmd.RustLsp("codeAction")
    else
      vim.lsp.buf.code_action()
    end
  end, "[C]ode [A]ction", { "n", "x" })
  map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
  map("<leader>rs", ":LspRestart<CR>", "[R]estart LSP[S]erver")
  map("K", function()
    if vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
      require("crates").show_popup()
      -- vim.cmd.RustLsp({ "hover", "actions" })
    else
      vim.lsp.buf.hover()
    end
  end, "[C]ode [A]ction", { "n", "x" })

  -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
  ---@param client vim.lsp.Client
  ---@param method vim.lsp.protocol.Method
  ---@param bufnr? integer some lsp support methods only in specific files
  ---@return boolean
  local function client_supports_method(client, method, bufnr)
    if vim.fn.has("nvim-0.11") == 1 then
      return client:supports_method(method, bufnr)
    else
      return client.supports_method(method, { bufnr = bufnr })
    end
  end

  -- The following two autocommands are used to highlight references of the
  -- word under your cursor when your cursor rests there for a little while.
  --    See `:help CursorHold` for information about when this is executed
  --
  -- When you move your cursor, the highlights will be cleared (the second autocommand).
  local client = vim.lsp.get_client_by_id(event.data.client_id)
  if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
    local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      buffer = event.buf,
      group = highlight_augroup,
      callback = vim.lsp.buf.document_highlight,
    })

    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
      buffer = event.buf,
      group = highlight_augroup,
      callback = vim.lsp.buf.clear_references,
    })

    vim.api.nvim_create_autocmd("LspDetach", {
      group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
      callback = function(event2)
        vim.lsp.buf.clear_references()
        vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
      end,
    })
  end

  if client and client_supports_method(client, "textDocument/inlayHint", event.buf) then
    vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
    map("<leader>th", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
    end, "[T]oggle Inlay [H]ints")
  end
end

return M
