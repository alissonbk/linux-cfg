#!/bin/bash

export NIXPKGS_ALLOW_UNFREE=1;
nix run github:nix-community/home-manager -- switch --impure --flake .#alissonbk
