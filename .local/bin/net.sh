#!/bin/sh

INTERFACE=$(ip route | awk '/^default/ {print $5 ; exit}')


# path to store the old results in
path="/tmp/$(basename $0)-${INTERFACE}"

update() {
    sum=0
    for arg; do
        read -r i < "$arg"
        sum=$(( sum + i ))
    done
    cache=${XDG_CACHE_HOME:-$HOME/.cache}/${1##*/}
    [ -f "$cache" ] && read -r old < "$cache" || old=0
    printf %d\\n "$sum" > "$cache"
    printf %d\\n $(( sum - old ))
}

rx=$(update /sys/class/net/$INTERFACE/statistics/rx_bytes)
tx=$(update /sys/class/net/$INTERFACE/statistics/tx_bytes)

printf "🔽 %1sB 🔼 %1sB\\n" $(numfmt --to=iec $rx) $(numfmt --to=iec $tx)
