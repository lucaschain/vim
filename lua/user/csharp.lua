vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "csharp_ls" })

local config = {
  handlers = {
    ["textDocument/definition"] = require('csharpls_extended').handler,
  },
  cmd = { "csharp-ls" },
}
require("lvim.lsp.manager").setup("csharp_ls", config)
