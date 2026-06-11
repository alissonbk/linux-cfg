#!/usr/bin/env bash
IP="${1:-192.168.75.107}"

PORT=$(rustscan -a "$IP" --range 30000-65535 --ulimit 5000 -b 1000 2>/dev/null \
    | awk -F: '/^Open / { print $2; exit }')

if [[ -z "$PORT" ]]; then
    echo "No open TCP port found on $IP"
    exit 1
fi

echo "Found port: $PORT"
sudo ~/Android/Sdk/platform-tools/adb connect "$IP:$PORT"
