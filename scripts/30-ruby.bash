#!/bin/bash
set -eux

# apt-get -y install autoconf bison build-essential libssl-dev libyaml-dev \
#         libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 \
#         libgdbm-dev wget

# cd /tmp
# wget 'https://cache.ruby-lang.org/pub/ruby/2.3/ruby-2.3.0.tar.gz'
# tar zxf ruby-2.3.0.tar.gz
# cd ruby-2.3.0

# ./configure
# make
# make install

add-apt-repository -y ppa:brightbox/ruby-ng
apt-get update
apt-get install -y ruby2.2 ruby2.2-dev

gem install bundler pry
