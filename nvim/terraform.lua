require'lspconfig'.terraform_lsp.setup{
  cmd = { "terraform-ls", "serve", "-log-file", "/tmp/lsplog.txt" },
  filetypes = { "tf", "terraform", "hcl" },
  root_dir = require'lspconfig'.util.root_pattern(".git", ".terraform", ".gitignore"),
  settings = {
    rootMarkers = { ".terraform", ".git" },
    languages = {
      hcl = {
        format = {
          enable = true,
          args = { "terraform", "fmt", "-" },
          stdin = true
        }
      }
    }
  }
}
