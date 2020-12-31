vim
===

My vim config files

## Requirements
https://github.com/junegunn/fzf
https://github.com/fwcd/KotlinLanguageServer

## Installing plugins

```
cd ~/.vim/bundle
git clone https://github.com/scrooloose/nerdtree.git
git clone https://github.com/sheerun/vim-polyglot.git
git clone https://github.com/junegunn/fzf.vim
git clone https://github.com/airblade/vim-gitgutter.git
git clone https://github.com/bronson/vim-trailing-whitespace.git
git clone https://github.com/tpope/vim-fugitive.git
git clone https://github.com/wellle/targets.vim
#git clone https://github.com/w0rp/ale
git clone https://github.com/kien/ctrlp.vim
git clone https://github.com/hashivim/vim-terraform.git

```

## .bashrc

```bash
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"
```
