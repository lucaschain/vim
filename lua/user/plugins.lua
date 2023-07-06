lvim.plugins = {
  { "lunarvim/colorschemes" },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({})
    end,
  },
  { "ray-x/aurora" },
  { "svermeulen/text-to-colorscheme.nvim" },
  { "Decodetalkers/csharpls-extended-lsp.nvim" },
  { "klen/nvim-test" },
}
require('text-to-colorscheme').setup {
  ai = {
    openai_api_key = os.getenv("OPENAI_API_KEY"),
    gpt_model = "gpt-3.5-turbo"
  },
}
