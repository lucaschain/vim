lvim.plugins = {
  { "lunarvim/colorschemes" },
  { "github/copilot.vim" },
  { "ray-x/aurora" },
  { "svermeulen/text-to-colorscheme.nvim" },
  { "Decodetalkers/csharpls-extended-lsp.nvim" },
}

require('text-to-colorscheme').setup {
  ai = {
    openai_api_key = os.getenv("OPENAI_API_KEY")
    gpt_model = "gpt-3.5-turbo"
  },
}


local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { exe = "black", filetypes = { "python" } },
  { exe = "isort", filetypes = { "python" } }
}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { name = "mypy" },
}

vim.g.copilot_assume_mapped = true
vim.g.copilot_no_tab_map = true
vim.g.copilot_tab_fallback = ""
local cmp = require "cmp"
lvim.builtin.cmp.mapping["<C-e>"] = function(fallback)
  cmp.mapping.abort()
  local copilot_keys = vim.fn["copilot#Accept"]()
  if copilot_keys ~= "" then
    vim.api.nvim_feedkeys(copilot_keys, "i", true)
  else
    fallback()
  end
end

lvim.format_on_save = true

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "csharp_ls" })

local config = {
  handlers = {
    ["textDocument/definition"] = require('csharpls_extended').handler,
  },
  cmd = { "csharp-ls" },
}
require("lvim.lsp.manager").setup("csharp_ls", config)
