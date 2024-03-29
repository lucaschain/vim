save-conf() {
  cp ~/.config/lvim/config.lua ~/dev/vim
  cp -R ~/.config/lvim/lua/* ~/dev/vim/lua
  cp ~/.bash_aliases ~/dev/vim
  cp ~/.tmux.conf ~/dev/vim
}

load-conf() {
  cp $HOME/dev/vim/config.lua ~/.config/lvim/config.lua
  cp -R $HOME/dev/vim/lua/* $HOME/.config/lvim/lua/
  cp $HOME/dev/vim/.tmux.conf $HOME/.tmux.conf
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

rconf() {
  lvim $HOME/.bashrc
  source $HOME/.bashrc
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

dev () {
  cd $HOME/dev/$@
}
complete -W "$(ls $HOME/dev)" dev

kx () {
  kubectl ctx $@
}

kn () {
  kubectl ns $@
}

drain() {
  kubectl drain $1 --ignore-daemonsets --delete-emptydir-data
}

bwlogin() {
  export BW_SESSION=$(bw unlock --raw)
}

# Andela
source $HOME/.andela_aliases
