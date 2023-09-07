-- Python DAP
require('dap-python').setup()


lvim.builtin.which_key.mappings["d"]["T"] = {
  { "<cmd> lua require('dap-python').test_method()<cr>", "Run test method" }
}


-- Diagnostic View
--
lvim.builtin.which_key.mappings["d"]["d"] = {
  { "<cmd> lua vim.diagnostic.open_float(nil, {focus=false})<cr>", "Show full diagnostic message" }
}


vim.diagnostic.config({
  underline = true,
  signs = true,
  virtual_text = false,
  float = {
    show_header = true,
    source = 'if_many',
    border = 'rounded',
    focusable = false,
  },
  update_in_insert = false, -- default to false
  severity_sort = false,    -- default to false
})
