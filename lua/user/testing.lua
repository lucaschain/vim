require('nvim-test').setup({
  termOpts = {
    direction = "float"
  }
})

lvim.builtin.which_key.mappings["t"] = {
  name = "Test",
  s = { "<cmd>TestSuite<cr>", "Run suite" },
  f = { "<cmd>TestFile<cr>", "Run file" },
  n = { "<cmd>TestNearest<cr><cr>", "Run nearest to cursor" },
  l = { "<cmd>TestLast<cr>", "Rerun last tast" },
  v = { "<cmd>TestVisit<cr>", "Open last test in a buffer" },
  i = { "<cmd>TestInfo<cr>", "Show information on test plugin" },
}
