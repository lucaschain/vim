save-conf() {
  cp ~/.config/lvim/config.lua ~/dev/vim
  cp -R ~/.config/lvim/lua/* ~/dev/vim/lua
  cp ~/.bash_aliases ~/dev/vim
  cp ~/.tmux.conf ~/dev/vim
}

lvconf() {
  current_dir=$(pwd)
  cd $HOME/.config/lvim && lvim config.lua
  save-conf
  cd $current_dir
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

