require("neotest").setup({
  output = {
    open_on_run = true,
  },
  adapters = {
    require("neotest-dotnet")({
      discovery_root = "solution"
    }),
    require("neotest-jest")({}),
    require("neotest-python")({})
  }
})

lvim.builtin.which_key.mappings["t"] = {
  name = "Test",
  f = { "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", "Run file" },
  n = { "<cmd>lua require('neotest').run.run() <cr>", "Run nearest to cursor" },
  a = { "<cmd>lua require('neotest').run.attach()<cr>", "Attach to nearest test" },
  s = { "<cmd>lua require('neotest').run.stop()<cr>", "Stop nearest test" },
}



lvim.keys.normal_mode["<C-t>"] = "<cmd>lua require('neotest').run.run();require('neotest').run.attach();<cr>"
lvim.keys.normal_mode["<C-j>"] = "<cmd>lua require('neotest').output_panel.toggle()<cr>"
