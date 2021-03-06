#!/bin/bash
set -eux

syncthing_url='https://github.com/syncthing/syncthing/releases/download/v0.14.15/syncthing-linux-amd64-v0.14.15.tar.gz'
syncthing_gz="$(basename "${syncthing_url}")"
syncthing_dir="$(sed -e 's/\.tar\.gz$//' <<< "${syncthing_gz}")"

apt-get install -y wget

adduser --disabled-password --disabled-login --gecos '' --home "/var/lib/syncthing" syncthing
cd /var/lib/syncthing
chown -R syncthing:syncthing .

# install sycthing
sudo -usyncthing bash <<EOF
cd /var/lib/syncthing
wget "${syncthing_url}"
tar zxf "${syncthing_gz}"
cd "${syncthing_dir}"
install --mode=755 syncthing /var/lib/syncthing
EOF

initctl start syncthing
