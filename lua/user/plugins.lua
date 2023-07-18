lvim.plugins = {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({})
    end,
  },
  { "ray-x/aurora" },
  { "Decodetalkers/csharpls-extended-lsp.nvim" },
  { "klen/nvim-test" },
  {
    "casonadams/simple-diagnostics.nvim",
    config = function()
      require("simple-diagnostics").setup({
        virtual_text = true,
        message_area = true,
        signs = true,
      })
    end,
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r", mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R", mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      {
        "<c-s>",
        mode = { "c" },
        function() require("flash").toggle() end,
        desc =
        "Toggle Flash Search"
      },
    },
  }
}

vim.diagnostic.config({ virtual_text = false })
