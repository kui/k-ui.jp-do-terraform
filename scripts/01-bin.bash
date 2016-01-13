#!/bin/bash
set -eux
cd "$(dirname "$0")"

find ./bin -type f -maxdepth 1 -exec install --mode 755 {} /usr/local/bin \;
