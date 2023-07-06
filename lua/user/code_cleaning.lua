local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { exe = "black", filetypes = { "python" } },
  { exe = "isort", filetypes = { "python" } }
}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { name = "mypy" },
}

lvim.format_on_save = true
