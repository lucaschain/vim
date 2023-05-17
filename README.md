vim
===

My vim config files

## Requirements

- https://github.com/junegunn/fzf
- https://github.com/fwcd/KotlinLanguageServer
- https://github.com/razzmatazz/csharp-language-server

## Installing plugins

```
cd ~/.vim/bundle
git clone https://github.com/scrooloose/nerdtree.git
git clone https://github.com/junegunn/fzf
git clone https://github.com/junegunn/fzf.vim
git clone https://github.com/airblade/vim-gitgutter.git
git clone https://github.com/bronson/vim-trailing-whitespace.git
git clone https://github.com/tpope/vim-fugitive.git
git clone https://github.com/wellle/targets.vim
git clone https://github.com/kien/ctrlp.vim
git clone https://github.com/neoclide/coc.nvim
git clone https://github.com/neovim/nvim-lspconfig
git clone https://github.com/chrisbra/csv.vim

```

## .bashrc

```bash
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"
```
