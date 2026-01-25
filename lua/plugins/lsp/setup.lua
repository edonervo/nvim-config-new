local servers = {
  "lua_ls",
  "pyright",
  "jsonls",
}

-- Make sure Neovim can find pipx-installed tools like ruff
vim.env.PATH = vim.env.HOME .. "/.local/bin:" .. vim.env.PATH

local settings = {
  ui = {
    border = "none",
    icons = {
      package_installed = "◍",
      package_pending = "◍",
      package_uninstalled = "◍",
    },
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
}

require("mason").setup(settings)
require("mason-lspconfig").setup({
  ensure_installed = servers,
  automatic_installation = true,
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

--[[ local null_ls_status_ok, null_ls = pcall(require, "null-ls") ]]
--[[ if not null_ls_status_ok then ]]
--[[   return ]]
--[[ end ]]
--[[]]
--[[ -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting ]]
--[[ local formatting = null_ls.builtins.formatting ]]
--[[ -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics ]]
--[[ local diagnostics = null_ls.builtins.diagnostics ]]
--[[]]
--[[ null_ls.setup { ]]
--[[   debug = false, ]]
--[[   sources = { ]]
--[[     formatting.prettier.with { extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }, ]]
--[[     formatting.black.with { extra_args = { "--fast" } }, ]]
--[[     -- formatting.yapf, ]]
--[[     formatting.stylua, ]]
--[[     --[[ diagnostics.ruff ]]
--[[   }, ]]
--[[ } ]]
--[[]]
local opts = {}

for _, server in pairs(servers) do
  opts = {
    on_attach = require("plugins.lsp.handlers").on_attach,
    capabilities = require("plugins.lsp.handlers").capabilities,
  }

  server = vim.split(server, "@")[1]

  local require_ok, conf_opts = pcall(require, "plugins.lsp.settings." .. server)
  if require_ok then
    opts = vim.tbl_deep_extend("force", conf_opts, opts)
  end

  vim.lsp.config(server, opts)
  vim.lsp.enable(server)
end
