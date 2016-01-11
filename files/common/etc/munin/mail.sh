#!/bin/bash
set -eu

group=$1
host=$2

subject="Munin Alert ${group}::${host}"

{
    echo "See http://k-ui.jp/munin/$group/$host"
    echo ""
    echo "--"
    echo ""
    cat
} | /usr/local/bin/notify-to-gmail "$subject"
