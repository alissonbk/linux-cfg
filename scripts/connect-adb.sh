#!/usr/bin/env bash

IP="${1:-192.168.75.107}"

PORT=$(nmap -Pn -sT -T5 -p 30000-65535 "$IP" \
    | awk '/tcp[[:space:]]+open/ {
        split($1,a,"/");
        print a[1];
        exit
    }')

if [[ -z "$PORT" ]]; then
    echo "No open TCP port found on $IP"
    exit 1
fi

echo "Found port: $PORT"
sudo ~/Android/Sdk/platform-tools/adb connect "$IP:$PORT"
