#!/bin/bash
set -eux

add-apt-repository -y ppa:nginx/stable
apt-get update
apt-get install -y nginx

cd /etc/nginx/sites-enabled
rm -f default
ln -fs /etc/nginx/sites-available/k-ui.jp

service nginx restart
