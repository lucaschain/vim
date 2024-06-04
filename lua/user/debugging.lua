-- Python DAP
require('dap-python').setup()


lvim.builtin.which_key.mappings["d"]["T"] = {
  { "<cmd> lua require('dap-python').test_method()<cr>", "Run test method" }
}


lvim.lsp.buffer_mappings.visual_mode['<C-d>'] = { 'c<c-r>=system(\'base64 --decode\', @")<cr><esc>', "Decode base64" }
lvim.lsp.buffer_mappings.visual_mode['<C-e>'] = { 'c<c-r>=system(\'base64\', @")<cr><esc>', "Encode base64" }

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

require("dap-vscode-js").setup({
  -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
  debugger_path = "/home/chain/.local/share/lunarvim/site/pack/lazy/opt/vscode-js-debug",      -- Path to vscode-js-debug installation.
  -- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
  adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }, -- which adapters to register in nvim-dap
  -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
  -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
  -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
})


for _, language in ipairs({ "typescript", "javascript" }) do
  require("dap").configurations[language] = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      cwd = "${workspaceFolder}",
    },
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach",
      processId = require 'dap.utils'.pick_process,
      cwd = "${workspaceFolder}",
    },
    {
      type = "pwa-node",
      request = "launch",
      name = "Debug Jest Tests",
      -- trace = true, -- include debugger info
      runtimeExecutable = "node",
      runtimeArgs = {
        "./node_modules/jest/bin/jest.js",
        "--runInBand",
      },
      rootPath = "${workspaceFolder}",
      cwd = "${workspaceFolder}",
      console = "integratedTerminal",
      internalConsoleOptions = "neverOpen",
    }
  }
end
