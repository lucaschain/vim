return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gdscript = {
          -- Godot LSP settings
          cmd = vim.lsp.rpc.connect("127.0.0.1", 6005),
        },
      },
    },
  },
}
