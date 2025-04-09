save-conf() {
  cp -R $HOME/.config/nvim/lua/* $HOME/dev/vim/lua
  cp $HOME/.bash_aliases $HOME/dev/vim
  cp ~/.tmux.conf ~/dev/vim
}

load-conf() {
  mkdir -p $HOME/.config/nvim/lua
  cp -R $HOME/dev/vim/lua/* $HOME/.config/nvim/lua/
  cp $HOME/dev/vim/.tmux.conf $HOME/.tmux.conf
}

aconf() {
  nvim $HOME/.bash_aliases
  source $HOME/.bash_aliases
  save-conf
}

rconf() {
  nvim $HOME/.bashrc
  source $HOME/.bashrc
  save-conf
}

vim() {
  if [ -f "pyproject.toml" ]; then
    poetry run nvim "$@"
  else
    nvim "$@"
  fi
}

dev() {
  cd $HOME/dev/$@
}
complete -W "$(ls $HOME/dev)" dev

kx() {
  kubectl ctx $@
}

kn() {
  kubectl ns $@
}

drain() {
  kubectl drain $1 --ignore-daemonsets --delete-emptydir-data
}

bwlogin() {
  export BW_SESSION=$(bw unlock --raw)
}

localdb() {
  db_name=$1
  clionly=${2:-false}
  db_url="postgres://postgres:postgres@localhost:5432/$db_name"

  if [ $clionly = true ]; then
    pgcli $db_url
  else
    DBUI_URL=$db_url vim "+:DBUI"
  fi
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

  gpg -d $filename >$filename.gpg
  mv $filename.gpg $filename
}

pokedex() {
  firefox https://bulbapedia.bulbagarden.net/wiki/$1\#Evolution_data
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

alias tg=terragrunt

netshoot() {
  k run -it --rm --restart=Never --image nicolaka/netshoot -- bash
}

jw() {
  jwt decode --date=local $1
}

kdenlive() {
  cd ~/Documents
  ./kdenlive.AppImage
}

rme() {
  wine /home/chain/Documents/rme/Editor_x64.exe
}

cputemp() {
  paste <(cat /sys/class/thermal/thermal_zone*/type) <(cat /sys/class/thermal/thermal_zone*/temp) | column -s $'\t' -t | sed 's/\(.\)..$/.\1°C/'
  nvidia-smi
}
