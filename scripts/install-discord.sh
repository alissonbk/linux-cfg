#!/bin/zsh

set -e;

ov=$(sudo cat /opt/discord/resources/build_info.json | jq '.version' | tr -d "\"");

IFS='.' read -r a b c <<< "$ov"

c=$((c + 1))
version="$a.$b.$c";

echo "new_version: $version\n";

pushd /tmp
wget https://stable.dl2.discordapp.net/apps/linux/$version/discord-$version.tar.gz;

tar -xvf discord-$version.tar.gz;

sudo cp -r Discord/* /opt/discord/;
sudo cp -r Discord/* /usr/share/discord/;
popd;

echo "updated successfully discord-$version";
