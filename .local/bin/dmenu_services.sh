#!/bin/sh

service=$(systemctl list-unit-files --all --type=service --no-legend \
    | awk '{print $0}' \
    | dmenu -i -l 10 -p "Systemd Service: ")
    if [ ! -z "$service" ]; then
        action="$(echo -e "Start\nStop\nStatus" | \
            dmenu -i -p "Start/Stop service:")"
        if [[ $action == "Start" ]]; then
            systemctl start $service
        elif [[ $action == "Stop" ]]; then
            systemctl stop $service
        else
            $TERMINAL --hold -e systemctl status $service
        fi
    fi
