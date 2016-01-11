#!/bin/bash
set -eux

home='/var/lib/blog'
git_url='https://github.com/kui/k-ui.jp.git'

apt-get install -y git build-essential graphviz

adduser --system --home "$home" blog
chown blog:nogroup -R "$home"

sudo -u blog -H bash -l <<EOF
set -eux
cd "$home"
git clone "$git_url" k-ui.jp
cd k-ui.jp
make
EOF
