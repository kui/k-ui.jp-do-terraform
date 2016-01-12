#!/bin/bash
set -eu

cd "$(dirname $0)/.."

id_file="$1"
ip="$2"

cat <<EOF
Host k-ui.jp
User root
HostName ${ip}
Port 29308
StrictHostKeyChecking no
UserKnownHostsFile /dev/null
IdentityFile ${id_file}
PreferredAuthentications publickey
EOF
