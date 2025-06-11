-- Custom fold function combining Tree-sitter and fallback for Rust comments
function ExtendedFoldExpr(lnum)
  -- Try to get Tree-sitter fold level
  local ts_fold = vim.treesitter.foldexpr and vim.treesitter.foldexpr(lnum) or "0"

  -- If Tree-sitter returns a valid fold level, use it
  if ts_fold ~= "0" then
    return ts_fold
  end

  -- Fallback for Rust `///` doc comments
  local line = vim.api.nvim_buf_get_lines(0, lnum - 1, lnum, false)[1]
  if line and line:match("^///") then
    local start_line = lnum
    local end_line = lnum

    -- Find the start of the comment block
    while start_line > 1 do
      local prev_line = vim.api.nvim_buf_get_lines(0, start_line - 2, start_line - 1, false)[1]
      if not prev_line or not prev_line:match("^///") then
        break
      end
      start_line = start_line - 1
    end

    -- Find the end of the comment block
    while true do
      local next_line = vim.api.nvim_buf_get_lines(0, end_line, end_line + 1, false)[1]
      if not next_line or not next_line:match("^///") then
        break
      end
      end_line = end_line + 1
    end

    return tostring(start_line + 1)
  end

  -- Default: no fold
  return "0"
end

function HighlightedFoldtext()
  local pos = vim.v.foldstart
  local line = vim.api.nvim_buf_get_lines(0, pos - 1, pos, false)[1]
  local lang = vim.treesitter.language.get_lang(vim.bo.filetype)
  local parser = vim.treesitter.get_parser(0, lang)
  local query = vim.treesitter.query.get(parser:lang(), "highlights")

  if query == nil then
    return vim.fn.foldtext()
  end

  local tree = parser:parse({ pos - 1, pos })[1]
  local result = {}

  local line_pos = 0
  local prev_range = nil

  for id, node, _ in query:iter_captures(tree:root(), 0, pos - 1, pos) do
    local name = query.captures[id]
    local start_row, start_col, end_row, end_col = node:range()
    if start_row == pos - 1 and end_row == pos - 1 then
      local range = { start_col, end_col }
      if start_col > line_pos then
        table.insert(result, { line:sub(line_pos + 1, start_col), "Folded" })
      end
      line_pos = end_col
      local text = vim.treesitter.get_node_text(node, 0)
      if prev_range ~= nil and range[1] == prev_range[1] and range[2] == prev_range[2] then
        result[#result] = { text, "@" .. name }
      else
        table.insert(result, { text, "@" .. name })
      end
      prev_range = range
    end
  end

  -- Adiciona um fallback para nós de comentários
  if #result == 0 then
    table.insert(result, { line, "Folded" })
  end

  -- if #result == 0 then
  --    -- Verifica se a linha começa com '///' (comentário Rust)
  --    if line:match("^///") then
  --      table.insert(result, { line, "Folded" })
  --    else
  --      table.insert(result, { line, "Comment" })
  --    end
  --  end

  if line:match("^///") then
    table.insert(result, { line, "Comment" })
    -- Formata o resultado para exibição no foldtext
    return table.concat(vim.tbl_map(function(item)
      return item[1]
    end, result))
    -- local fold_text = ""
    -- for _, item in ipairs(result) do
    --   fold_text = fold_text .. item[1]
    -- end

    -- -- Adiciona a quantidade de linhas no fold
    -- local fold_count = vim.v.foldend - vim.v.foldstart + 1
    -- fold_text = fold_text .. string.format(" ... [%d lines]", fold_count)

    -- return fold_text
  end

  return result
end

-- local bg = vim.api.nvim_get_hl(0, { name = "StatusLine" }).bg
local hl = vim.api.nvim_get_hl(0, { name = "Folded" })
-- hl.bg = bg
vim.api.nvim_set_hl(0, "Folded", hl)

vim.opt.foldtext = [[luaeval('HighlightedFoldtext')()]]

-- Set fold method and custom fold expression
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "v:lua.ExtendedFoldExpr(v:lnum)"
-- vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"

return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      -- "windwp/nvim-ts-autotag",
    },
    config = function()
      -- import nvim-treesitter plugin
      local treesitter = require("nvim-treesitter.configs")
      vim.wo.foldmethod = "expr"
      -- vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.wo.foldenable = true
      vim.wo.foldlevel = 20
      --- @class ParserInfo[]
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.blade = {
        install_info = {
          url = "https://github.com/EmranMR/tree-sitter-blade",
          files = {
            "src/parser.c",
            -- 'src/scanner.cc',
          },
          branch = "main",
          generate_requires_npm = true,
          requires_generate_from_grammar = true,
        },
        filetype = "blade",
      }
      vim.filetype.add({
        pattern = {
          [".*%.blade%.php"] = "blade",
        },
      })

      -- configure treesitter
      treesitter.setup({ -- enable syntax highlighting
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = { "php" },
        },
        -- enable indentation
        indent = { enable = true },
        -- enable autotagging (w/ nvim-ts-autotag plugin)
        -- autotag = {
        --   enable = true,
        -- },
        fold = { enable = true },
        -- ensure these language parsers are installed
        ensure_installed = {
          "json",
          "javascript",
          "typescript",
          "tsx",
          "yaml",
          "html",
          "css",
          "prisma",
          "markdown",
          "markdown_inline",
          "graphql",
          "bash",
          "lua",
          "vim",
          "dockerfile",
          "gitignore",
          "query",
          "java",
          "rust",
          "ron",
          "php",
          "blade",
          "php_only",
          "java",
          "vue",
        },

        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
          },
        },
      })

      -- enable nvim-ts-context-commentstring plugin for commenting tsx and jsx
      require("ts_context_commentstring").setup({})
    end,
  },
  {
    "nvim-treesitter/playground",
  },
  {
    "stsewd/tree-sitter-comment",
  },
}
-- return {}
