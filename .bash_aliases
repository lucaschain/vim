save-conf() {
  cp ~/.config/lvim/config.lua ~/dev/vim
  cp -R ~/.config/lvim/lua/* ~/dev/vim/lua
  cp ~/.bash_aliases ~/dev/vim
  cp ~/.tmux.conf ~/dev/vim
}

lvconf() {
  cd $HOME/.config/lvim && lvim config.lua
  save-conf
}

aconf() {
  lvim $HOME/.bash_aliases
  source $HOME/.bash_aliases
  save-conf
}

vim () {
  if [ -f "pyproject.toml" ]; then
    poetry run lvim "$@"
  else
    lvim "$@"
  fi
}

