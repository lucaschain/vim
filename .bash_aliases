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

localdb() {
  db_name=$1;
  clionly=${2:-false};
  db_url="postgres://postgres:postgres@localhost:5432/$db_name";

  if [ $clionly = true ]; then
    pgcli $db_url
  else
    DBUI_URL=$db_url vim "+:DBUI"
  fi;
}


protect() {
  filename=$1

  if [ -z "$filename" ]; then
    echo "Usage: protect <filename>"
    return 1
  fi

  gpg -c $filename
  mv $filename.gpg $filename
}

unprotect() {
  filename=$1

  if [ -z "$filename" ]; then
    echo "Usage: unprotect <filename>"
    return 1
  fi

  gpg -d $filename > $filename.gpg
  mv $filename.gpg $filename
}

pokedex() {
  /mnt/c/Program\ Files/Mozilla\ Firefox/firefox.exe https://bulbapedia.bulbagarden.net/wiki/$1\#Evolution_data
}

b64d() {
  echo $1 | base64 -d
}

b64e() {
  echo -n $1 | base64
}

source <(kubectl completion bash)
alias k=kubectl
complete -o default -F __start_kubectl k

# Xylo
source $HOME/.xylo_aliases.sh


alias tg=terragrunt

netshoot() {
  k run -it --rm --restart=Never --image nicolaka/netshoot -- bash
}

jw() {
  jwt decode --date=local $1
}
