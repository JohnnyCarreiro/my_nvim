local lspconfig = require("lspconfig")
local default_config = require("lsp.defaults")
local home = os.getenv("HOME")
local java_home = os.getenv("JAVA_HOME") or "/usr/lib/jvm/default-java" -- Fallback para JAVA_HOME
local lombok_jar = home .. "/.local/share/lombok/lombok.jar"
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.expand("~/.local/share/nvim/jdtls-workspace/") .. project_name
local mason_path = vim.fn.stdpath("data") .. "/mason"
local spring_boot_bundles = require("spring_boot").java_extensions()

local bundles = {
  mason_path .. "/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar",
}

vim.list_extend(bundles, vim.split(vim.fn.glob(mason_path .. "/packages/java-test/extension/server/*.jar"), "\n"))

if spring_boot_bundles and type(spring_boot_bundles) == "table" then
  for _, bundle in ipairs(spring_boot_bundles) do
    table.insert(bundles, bundle)
  end
end

-- JAVA_HOME Validation
if not vim.fn.isdirectory(java_home) then
  vim.notify("JAVA_HOME não está configurado corretamente: " .. java_home, vim.log.levels.ERROR)
  return
end

-- JDTLS Path
local jdtls_path = home .. "/.local/share/nvim/mason/packages/jdtls"
local launcher_jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
local config_dir = jdtls_path .. "/config_mac"

if launcher_jar == "" or not vim.fn.filereadable(launcher_jar) then
  vim.notify("Wasn't possible to found th JDTLS launcher on:" .. launcher_jar, vim.log.levels.ERROR)
  return
end

if not vim.fn.isdirectory(config_dir) then
  vim.notify("Configuração do JDTLS não encontrada em: " .. config_dir, vim.log.levels.ERROR)
  return
end

-- JDTLS config
lspconfig.jdtls.setup({
  cmd = {
    java_home .. "/bin/java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-javaagent:" .. lombok_jar,
    "-Xms1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    "-jar",
    launcher_jar,
    "-configuration",
    config_dir,
    "-data",
    workspace_dir,
  },
  capabilities = default_config.capabilities,
  on_attach = function(client, bufnr)
    -- Mapeamento de teclas para funcionalidades do JDTLS
    local opts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "<leader>oi", "<cmd>JdtOrganizeImports<CR>", opts)
    vim.keymap.set("n", "<leader>ev", "<cmd>JdtExtractVariable<CR>", opts)
    vim.keymap.set("n", "<leader>ec", "<cmd>JdtExtractConstant<CR>", opts)
    vim.keymap.set("n", "<leader>tc", "<cmd>JdtTestClass<CR>", opts)
    vim.keymap.set("n", "<leader>tm", "<cmd>JdtTestMethod<CR>", opts)
    default_config.on_attach()(client, bufnr)
  end,

  -- vim.api.nvim_create_autocmd("FileType", {
  -- 	pattern = "java",
  -- 	callback = function()
  -- 		vim.g.nvim_tree_group_empty = 1
  -- 	end,
  -- }),

  -- root_dir = lspconfig.util.root_pattern(".git", "mvnw", "gradlew", "pom.xml", "build.gradle"),
  root_dir = vim.fs.dirname(
    vim.fs.find({ "gradlew", ".git", "mvnw", "pom.xml", "build.gradle", "settings.gradle" }, { upward = true })[1]
  ),
  settings = {
    java = {
      configuration = {
        updateBuildConfiguration = "automatic",
        runtimes = {
          { name = "JavaSE", path = java_home },
        },
      },
      contentProvider = { preferred = "fernflower" },
      format = {
        enabled = true,
      },
    },
    gradle = {
      enabled = true,
      home = home .. "/.gradle",
    },
    spring = {
      boot = {
        enabled = true,
      },
    },
  },
  init_options = {
    bundles = bundles, -- debugging config, if needed
  },
})

vim.filetype.add({
  extension = {
    yaml = "yaml",
    properties = "properties",
  },
})

require("lspconfig").yamlls.setup({
  settings = {
    yaml = {
      schemas = {
        ["https://json.schemastore.org/spring-boot"] = "*.spring-boot.yaml",
        -- ["https://raw.githubusercontent.com/spring-projects/sts4/vscode-extensions/spring-configuration-metadata.json"] = "application*.yaml",
      },
    },
  },
})
