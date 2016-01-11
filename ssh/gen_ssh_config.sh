#!/bin/bash
set -eu

cd "$(dirname $0)/.."

if [[ "$#" != 2 ]]; then
    echo "$0 config_file ip_addr" >&2
    exit 1
fi

config_file="$1"
if [[ -z "$config_file" ]]; then
    echo "Empty config file name" >&2
    exit 1
fi

tfstate="$2"
if [[ -z "$tfstate" ]]; then
    echo "Empty .tfsate file" >&2
    exit 1
elif [[ ! -e "$tfstate" ]]; then
    echo "Does not exist .tfstate: $tfstate" >&2
    exit 1
fi

ip="$(terraform show "$tfstate" | grep ipv4_address | awk '{ print $3 }')"

cat <<EOF > "$config_file"
Host k-ui.jp
User root
HostName $ip
Port 29308
StrictHostKeyChecking no
UserKnownHostsFile /dev/null
IdentityFile ./ssh/id_rsa
PreferredAuthentications publickey
EOF
