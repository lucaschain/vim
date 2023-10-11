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

tfa () {
  # do not run if AWS_VAULT is not set
  if [ -z "$AWS_VAULT" ]; then
    echo "Gin login first"
    return 1
  fi


  export MONGODB_ATLAS_PUBLIC_KEY=$(gin param get atlantis production ATLASMONGODB_API_PUBLIC_KEY)
  export MONGODB_ATLAS_PRIVATE_KEY=$(gin param get atlantis production ATLASMONGODB_API_PRIVATE_KEY)
  terraform $@
}
