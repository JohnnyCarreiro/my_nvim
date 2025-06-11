local function has_file(bufnr, filenames)
  local path = vim.api.nvim_buf_get_name(bufnr)
  local dir = vim.fs.dirname(path)
  local found = vim.fs.find(filenames, { path = dir, upward = true })
  return #found > 0
end

local js_formatters = function(bufnr)
  local has_prettier = has_file(bufnr, {
    ".prettierrc",
    ".prettierrc.js",
    ".prettierrc.json",
    "prettier.config.js",
  })

  local has_eslint = has_file(bufnr, {
    ".eslintrc",
    ".eslintrc.js",
    ".eslintrc.cjs",
    ".eslintrc.json",
    "eslint.config.js",
  })

  if has_eslint and has_prettier then
    return { "eslint_d", "prettierd", "prettier" }
  elseif has_eslint then
    return { "eslint_d" }
  elseif has_prettier then
    return { "prettierd", "prettier" }
  else
    return { "biome" }
  end
end

return {
  "stevearc/conform.nvim",
  lazy = true,
  event = { "BufReadPre", "BufNewFile" },
  cmd = { "ConformInfo" },
  opts = {
    formatters = {
      biome = {
        command = "biome",
        args = { "format", "--stdin-file-path", "$FILENAME" },
        stdin = true,
      },
      eslint_d = {
        command = "eslint_d",
        args = { "--stdin", "--stdin-filename", "$FILENAME", "--fix-to-stdout" },
        stdin = true,
        root_patterns = { ".eslintrc", ".eslintrc.js", ".eslintrc.cjs", "eslint.config.js" },
      },
      prettierd = {
        command = "prettierd",
        args = { "$FILENAME" },
        root_patterns = { ".prettierrc", ".prettierrc.js", "prettier.config.js" },
      },
      prettier = {
        command = "prettier",
        args = { "--stdin-filepath", "$FILENAME" },
        stdin = true,
        root_patterns = { ".prettierrc", ".prettierrc.js", "prettier.config.js" },
      },
    },

    formatters_by_ft = {
      lua = { "stylua" },
      rust = { "rustfmt" },
      javascript = js_formatters,
      typescript = js_formatters,
      javascriptreact = js_formatters,
      typescriptreact = js_formatters,
    },

    format_on_save = {
      timeout_ms = 1000,
      lsp_format = "fallback",
    },
  },
}

-- return {
--   "stevearc/conform.nvim",
--   lazy = true,
--   event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
--   cmd = { "ConformInfo" },
--   opts = {
--     -- formatters = {
--     --   biome = {
--     --     require_cwd = true,
--     --   },
--     -- },
--     formatters = {
--       biome = {
--         command = "biome",
--         args = { "format", "--stdin-file-path", "$FILENAME" },
--         stdin = true,
--       },
--     },
--     formatters_by_ft = {
--       lua = { "stylua" },
--       -- Conform will run multiple formatters sequentially
--       -- You can customize some of the format options for the filetype (:help conform.format)
--       rust = { "rustfmt" },
--       -- Conform will run the first available formatter
--       javascript = { "prettierd", "prettier", "biome", stop_after_first = true },
--       typescript = { "prettierd", "prettier", "biome", stop_after_first = true },
--       javascriptreact = { "prettierd", "prettier", "biome", stop_after_first = true },
--       typescriptreaact = { "prettierd", "prettier", "biome", stop_after_first = true },
--       -- javascript = { "biome" },
--       -- typescript = { "biome" },
--       -- javascriptreact = { "biome" },
--       -- typescriptreact = { "biome" },
--     },
--     format_on_save = {
--       -- These options will be passed to conform.format()
--       timeout_ms = 1000,
--       lsp_format = "fallback",
--       -- async = true
--     },
--   },
--   --   config = function()
--   --     local conform = require("conform")
--   --     vim.keymap.set({ "n", "v" }, "<leader>cf", function()
--   --       conform.format({
--   --         lsp_fallback = true,
--   --         async = false,
--   --         timeout_ms = 2000,
--   --       })
--   --     end, { desc = "Format file or range (in visual mode)" })
--   --   end,
-- }
