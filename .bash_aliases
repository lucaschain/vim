vim_dev_folder=$HOME/dev/vim
nvim_config_folder=$HOME/.config/nvim
save-conf() {
  mkdir -p $vim_dev_folder/lua
  cp -R $nvim_config_folder/lua/* $vim_dev_folder/lua
  cp $HOME/.bash_aliases $vim_dev_folder
  cp ~/.tmux.conf ~/dev/vim
}

load-conf() {
  mkdir -p $nvim_config_folder/lua
  cp -R $vim_dev_folder/lua/* $nvim_config_folder/lua/
  cp $vim_dev_folder/.tmux.conf $HOME/.tmux.conf
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

# dev() {
#   cd $HOME/dev/$@
# }
# complete -W "$(ls $HOME/dev)" dev

dev() {
  cd "$HOME/dev/$@"
}
_dev_completion() {
  local cur=${COMP_WORDS[COMP_CWORD]}
  local dev_root="$HOME/dev"

  # Find all directories under dev_root
  COMPREPLY=($(compgen -o dirnames -S / -f "$dev_root/$cur" | sed "s|^$dev_root/||"))

  # Add space after completion when not ending with /
  if [[ ${COMPREPLY[0]} =~ /$ ]]; then
    compopt -o nospace
  fi
}
complete -F _dev_completion dev

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

_pokedex_completion() {
  local cur prev opts
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD - 1]}"

  local pokedex_file="$HOME/Apps/pokedex/pokemon_names.txt"

  if [ -f "$pokedex_file" ]; then
    mapfile -t pokemon_names <"$pokedex_file"

    COMPREPLY=($(compgen -W "${pokemon_names[*]}" -- "${cur}"))
  else
    echo "Pokemon names file not found: $pokedex_file" >&2
  fi

  return 0
}

complete -F _pokedex_completion pokedex

b64d() {
  echo $1 | base64 -d
}

b64e() {
  echo -n $1 | base64 -w0
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
  cd ~/Apps
  ./kdenlive_latest.AppImage
}

rme() {
  wine /home/chain/Documents/rme/Editor_x64.exe
}

cputemp() {
  paste <(cat /sys/class/thermal/thermal_zone*/type) <(cat /sys/class/thermal/thermal_zone*/temp) | column -s $'\t' -t | sed 's/\(.\)..$/.\1°C/'
  nvidia-smi
}

proton() {
  ~/Apps/proton.sh $1
}

wine32() {
  WINEARCH=win32 WINEPREFIX=~/.wine32 $@
}

apps() {
  cd $HOME/Apps/$@
}
complete -W "$(ls $HOME/Apps)" apps

awslogin() {
  firefox "https://usemesmer.awsapps.com/start/#/console?account_id=108782057018&role_name=Engineer"
}

vpnoff() {
  local env=$1
  openvpn3 session-manage -D --config /home/chain/.vpn/chain-dev.ovpn || true
  openvpn3 session-manage -D --config /home/chain/.vpn/chain-staging.ovpn || true
}

vpnon() {
  if [ -z "$1" ]; then
    echo "Usage: vpnon <environment>"
    return 1
  fi
  local env=$1
  vpnoff
  openvpn3 session-start --config /home/chain/.vpn/chain-$1.ovpn
}

set-ssm() {
  if [ $# -ne 1 ]; then
    echo "Usage: set-ssm <parameter-name>"
    echo "Example: set-ssm /app/db/password"
    return 1
  fi

  PARAM_NAME="$1"

  read -s -p "Enter value for $PARAM_NAME: " PARAM_VALUE
  echo ""

  if [ -z "$PARAM_VALUE" ]; then
    echo "Error: No value entered"
    return 1
  fi

  echo "Saving value to SSM parameter: $PARAM_NAME (as SecureString)"
  aws ssm put-parameter \
    --name "$PARAM_NAME" \
    --value "$PARAM_VALUE" \
    --type "SecureString" \
    --overwrite

  if [ $? -eq 0 ]; then
    echo "Successfully set parameter $PARAM_NAME"
  else
    echo "Error: Failed to save parameter $PARAM_NAME"
    return 1
  fi
}

copy-ssm() {
  if [ $# -ne 2 ]; then
    echo "Usage: copy-ssm <source-parameter> <destination-parameter>"
    echo "Example: copy-ssm /app/db/password /staging/app/db/password"
    return 1
  fi

  SOURCE_PARAM="$1"
  DEST_PARAM="$2"

  echo "Reading value from SSM parameter: $SOURCE_PARAM"
  PARAM_VALUE=$(aws ssm get-parameter --name "$SOURCE_PARAM" --with-decryption --query 'Parameter.Value' --output text)

  if [ -z "$PARAM_VALUE" ]; then
    echo "Error: Could not retrieve value from $SOURCE_PARAM"
    return 1
  fi

  echo "Saving value to SSM parameter: $DEST_PARAM (as SecureString)"
  aws ssm put-parameter --name "$DEST_PARAM" --value "$PARAM_VALUE" --type "SecureString" --overwrite

  echo "Successfully copied parameter from $SOURCE_PARAM to $DEST_PARAM"
}

get-ssm() {
  if [ $# -ne 1 ]; then
    echo "Usage: get-ssm <parameter-name>"
    echo "Example: get-ssm /app/db/password"
    return 1
  fi

  PARAM_NAME="$1"

  echo "Retrieving value for SSM parameter: $PARAM_NAME"
  PARAM_VALUE=$(aws ssm get-parameter --name "$PARAM_NAME" --with-decryption --query 'Parameter.Value' --output text)

  if [ $? -eq 0 ]; then
    echo $PARAM_VALUE
  else
    echo "Error: Failed to retrieve parameter $PARAM_NAME"
    return 1
  fi
}

## switch to env
senv() {
  if [ $# -ne 1 ]; then
    echo "Usage: senv <env-name>"
    echo "Example: senv dev"
    return 1
  fi

  NEWENV="$1"

  vpnon $NEWENV
  kx $NEWENV-mesmer
}
