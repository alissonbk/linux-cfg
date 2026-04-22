#!/bin/bash

rm -rf ~/.cache/yay ~/.local/share/Trash; 
nix store gc
