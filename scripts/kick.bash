#!/bin/bash
set -eu

main() {
    echo '## Start main'

    cd "$(dirname "$0")"

    DIR="$(pwd)"
    THIS="$DIR/$(basename "$0")"

    # to make apt-get no-interactive
    export DEBIAN_FRONTEND=noninteractive

    for s in "$DIR/"*; do
        if [[ ! "$(basename "$s")" =~ ^[0-9]+- ]]; then
            continue
        fi
        echo ------------------------------------------------------------
        echo -- execute: $s
        chmod +x "$s"
        "$s"
        echo -- done: $s
        echo ------------------------------------------------------------
    done

    echo '## Done main'
}

log() {
    while read line; do
        echo "$(date +%FT%T%z) | $line"
    done
}

main 2>&1 | log

reboot
