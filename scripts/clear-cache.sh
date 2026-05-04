#!/bin/bash

rm -rf ~/.cache/yay ~/.local/share/Trash ~/.var/app/com.spotify.Client/cache; 
nix store gc
