vim
===

My vim config files

## Requirements
https://github.com/junegunn/fzf

## Installing plugins

```
cd ~/.vim/bundle
git clone https://github.com/scrooloose/nerdtree.git
git clone https://github.com/sheerun/vim-polyglot.git
git clone https://github.com/junegunn/fzf.vim
git clone https://github.com/airblade/vim-gitgutter.git
git clone https://github.com/bronson/vim-trailing-whitespace.git
git clone https://github.com/tpope/vim-fugitive.git
git clone https://github.com/dustinfarris/vim-htmlbars-inline-syntax.git

```

## .bashrc

```bash
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"
```
