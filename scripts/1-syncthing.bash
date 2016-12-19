#!/bin/bash
set -eux

syncthing_url='https://github.com/syncthing/syncthing/releases/download/v0.14.3/syncthing-linux-amd64-v0.14.3.tar.gz'
syncthing_gz="$(basename "${syncthing_url}")"
syncthing_dir="$(sed -e 's/\.tar\.gz$//' <<< "${syncthing_gz}")"

apt-get install -y wget

# install sycthing
cd /tmp
wget "${syncthing_url}"
tar zxf "${syncthing_gz}"
cd "${syncthing_dir}"
install --mode=755 syncthing /usr/local/bin

adduser --disabled-password --disabled-login --gecos '' --home "/var/lib/syncthing" syncthing
cd /var/lib/syncthing
chown -R syncthing:syncthing .
initctl start syncthing
