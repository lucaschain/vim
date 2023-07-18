require('dap-python').setup()


lvim.builtin.which_key.mappings["d"]["T"] = {
  { "<cmd> lua require('dap-python').test_method()<cr>", "Run test method" }
}
