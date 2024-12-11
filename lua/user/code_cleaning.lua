local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { exe = "isort", filetypes = { "python" } },
  { exe = "black", filetypes = { "python" } },
}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { name = "mypy", args = { "--python-executable=python" } },
}

lvim.format_on_save = true
