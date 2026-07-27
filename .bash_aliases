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
    uv run nvim "$@"
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
  kubectx $@
}

kn() {
  kubens $@
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
  [ -f /tmp/vpn.pid ] && sudo kill $(cat /tmp/vpn.pid) 2>/dev/null && rm /tmp/vpn.pid
  sudo killall openvpn 2>/dev/null || true
}

vpnon() {
  if [ -z "$1" ]; then
    echo "Usage: vpnon <environment>"
    return 1
  fi
  vpnoff
  sudo openvpn --config /home/chain/.vpn/chain-$1.ovpn --daemon
  echo $! >/tmp/vpn.pid
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

copy-ssm-prod() {
  if [ $# -ne 1 ]; then
    echo "Usage: copy-ssm-prod <source-parameter>"
    echo "Example: copy-ssm-prod /app/dev/db/password"
    return 1
  fi

  NEW_PARAM=$(echo -n $1 | sed 's/dev/prod/g')
  copy-ssm $1 $NEW_PARAM
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
  kx $NEWENV
}

## update security group with IP address
# Usage: let-me-in <security-group-name>
let-me-in() {
  local sg_name="$1"

  if [ -z "$sg_name" ]; then
    echo "Usage: let-me-in <security-group-name>" >&2
    return 1
  fi

  # Get current public IP
  local ip
  ip=$(curl -s https://ipconfig.io/ip)
  if [ -z "$ip" ]; then
    echo "Failed to get IP from ipconfig.io" >&2
    return 1
  fi
  local new_cidr="${ip}/32"

  # Find SG by name using filters (works across VPCs, not just default)
  local sg_json
  if ! sg_json=$(aws ec2 describe-security-groups \
    --filters "Name=group-name,Values=${sg_name}" \
    --output json 2>/dev/null); then
    echo "Failed to describe security groups for name '${sg_name}'" >&2
    return 1
  fi

  local group_count
  group_count=$(echo "$sg_json" | jq '.SecurityGroups | length')

  if [ "$group_count" -eq 0 ]; then
    echo "No security group found with name '${sg_name}'" >&2
    return 1
  fi

  if [ "$group_count" -gt 1 ]; then
    echo "Warning: multiple security groups found with name '${sg_name}', using the first one." >&2
  fi

  # Extract group-id (first match)
  local group_id
  group_id=$(echo "$sg_json" | jq -r '.SecurityGroups[0].GroupId // empty')
  if [ -z "$group_id" ] || [ "$group_id" = "null" ]; then
    echo "Could not determine security group ID for '${sg_name}'" >&2
    return 1
  fi

  # Find the first IPv4 rule with description == "lchain-pc"
  local match
  match=$(echo "$sg_json" | jq -c '
    .SecurityGroups[0].IpPermissions[]? as $p
    | $p.IpRanges[]?
    | select(.Description == "lchain-pc")
    | {
        IpProtocol: $p.IpProtocol,
        FromPort: $p.FromPort,
        ToPort: $p.ToPort,
        CidrIp: .CidrIp
      }
  ' | head -n1)

  if [ -z "$match" ]; then
    echo "No rule with description 'lchain-pc' found in security group '${sg_name}'."
    echo "Creating a new rule: tcp/22 from ${new_cidr} with description 'lchain-pc'."

    if ! aws ec2 authorize-security-group-ingress \
      --group-id "$group_id" \
      --ip-permissions "IpProtocol=tcp,FromPort=22,ToPort=22,IpRanges=[{CidrIp=${new_cidr},Description=lchain-pc}]"; then
      echo "Failed to create new rule." >&2
      return 1
    fi

    echo "New rule created successfully."
    return 0
  fi

  local proto from_port to_port old_cidr
  proto=$(echo "$match" | jq -r '.IpProtocol')
  from_port=$(echo "$match" | jq -r '.FromPort')
  to_port=$(echo "$match" | jq -r '.ToPort')
  old_cidr=$(echo "$match" | jq -r '.CidrIp')

  echo "Updating SG '${sg_name}' (${group_id}) rule 'lchain-pc'"
  echo "  Protocol : $proto"
  echo "  Ports    : $from_port-$to_port"
  echo "  Old CIDR : $old_cidr"
  echo "  New CIDR : $new_cidr"

  # Revoke old rule
  if ! aws ec2 revoke-security-group-ingress \
    --group-id "$group_id" \
    --ip-permissions "IpProtocol=${proto},FromPort=${from_port},ToPort=${to_port},IpRanges=[{CidrIp=${old_cidr},Description=lchain-pc}]"; then
    echo "Failed to revoke old rule (${old_cidr})" >&2
    return 1
  fi

  # Authorize new rule
  if ! aws ec2 authorize-security-group-ingress \
    --group-id "$group_id" \
    --ip-permissions "IpProtocol=${proto},FromPort=${from_port},ToPort=${to_port},IpRanges=[{CidrIp=${new_cidr},Description=lchain-pc}]"; then
    echo "Failed to authorize new rule (${new_cidr})" >&2
    return 1
  fi

  echo "Security group rule updated successfully."
}

kesh() {
  if [ -z "$1" ]; then
    echo "Usage: kesh <pod_name> [command]" >&2
    return 1
  fi
  local pod="$1"
  shift
  if [ $# -eq 0 ]; then
    kubectl exec -it "$pod" -- sh
  else
    kubectl exec -it "$pod" -- "$@"
  fi
}
