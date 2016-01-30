#!/bin/bash
set -eux

apt-get install -y wget

cd /tmp
wget 'https://nodejs.org/dist/v4.2.4/node-v4.2.4-linux-x64.tar.gz'
mkdir -p /opt
tar zxf node-v4.2.4-linux-x64.tar.gz -C /opt
ln -s /opt/node-v4.2.4-linux-x64 /opt/node

export PATH=/opt/node/bin:"$PATH"
