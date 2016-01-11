#!/bin/bash
set -eux

apt-get install -y wget

# install sycthing
cd /tmp
wget 'https://github.com/syncthing/syncthing/releases/download/v0.12.11/syncthing-linux-amd64-v0.12.11.tar.gz'
tar zxf syncthing-linux-amd64-v0.12.11.tar.gz
cd syncthing-linux-amd64-v0.12.11
install --mode=755 syncthing /usr/local/bin

adduser --disabled-password --disabled-login --gecos '' --home "/var/lib/syncthing" syncthing
cd /var/lib/syncthing
chown -R syncthing:syncthing .
initctl start syncthing
