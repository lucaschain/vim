vim
===

My vim config files

## Installing plugins

```
cd ~/.vim/bundle
git clone https://github.com/scrooloose/nerdtree.git
git clone https://github.com/sheerun/vim-polyglot.git
git clone https://github.com/junegunn/fzf
git clone https://github.com/airblade/vim-gitgutter.git
git clone https://github.com/bronson/vim-trailing-whitespace.git
git clone https://github.com/tpope/vim-fugitive.git
```
## .bashrc

```bash
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"
```
