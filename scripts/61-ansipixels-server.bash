#!/bin/bash
set -eux

service_name="ansipixels"
home="/var/lib/${service_name}"
dest="${home}/server"
git_url="https://github.com/kui/ansipixels-server.git"
init="/etc/init.d/${service_name}"

apt-get install -y git

adduser --system --home "$home" "${service_name}"

sudo -u "${service_name}" -H bash -l <<EOF
set -eux
cd "$home"
git clone "$git_url" "$dest"
cd "$dest"
./mvnw compile
EOF

cd "$dest"
./scripts/gen-init.sh "${service_name}" > "$init"
chmod +x "$init"
update-rc.d ansipixels defaults

service "${service_name}" start

cd /etc/nginx/sites-enabled
ln -s /etc/nginx/sites-available/ansipixels
