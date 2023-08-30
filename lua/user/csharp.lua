vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "csharp_ls", "omnisharp" })

local config = {
  handlers = {
    ["textDocument/definition"] = require('omnisharp_extended').handler,
  },
}
require("lvim.lsp.manager").setup("omnisharp", config)
