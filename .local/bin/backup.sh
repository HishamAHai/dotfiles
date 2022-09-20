#!/usr/bin/env bash

SOURCE="$1/"
TARGET="$2"
PS3="Choose the operation you want:"

select option in backup restore
do
    if [[ ${option} == "backup" ]]; then
        rsync -a --progress --info=progress2 "$SOURCE" "$TARGET"
    elif [[ ${option} == "restore" ]]; then
        rsync -a --progress --info=progress2 "$TARGET" "$SOURCE"
    fi
    break
done
