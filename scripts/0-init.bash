#!/bin/bash
set -eux

# to make apt-get no-interactive
export DEBIAN_FRONTEND=noninteractive

# atach swapfile
fallocate -l 2G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo "/swapfile none swap sw 0 0" > /etc/fstab
sysctl --load /etc/sysctl.d/10-swappiness.conf

apt-get update -y
apt-get upgrade -y

# locale setup
apt-get install -y language-pack-ja
update-locale LANGUAGE=ja_JP.UTF-8 LC_ALL=ja_JP.UTF-8 LANG=ja_JP.UTF-8
echo "Asia/Tokyo" > /etc/timezone
dpkg-reconfigure -f noninteractive tzdata

# Remove older kernels
apt-get autoremove -y
apt-get autoclean
apt-get autoremove -y
apt-get autoclean

# Change sshd port
sed -i~ -e 's/^Port 22$/Port 29308/' /etc/ssh/sshd_config
service ssh reload
