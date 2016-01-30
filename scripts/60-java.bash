#!/bin/bash
set -eux

debconf-set-selections <<<'debconf shared/accepted-oracle-license-v1-1 select true'

add-apt-repository -y ppa:webupd8team/java
apt-get update
apt-get install -y oracle-java8-installer
