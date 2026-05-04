#!/bin/bash


pacman -S xorg-server\
    xorg-xinit\
    lightdm\
    lightdm-gtk-greeter\
    i3-wm\
    dmenu\
    i3status\
    i3lock\
    nix\
    zsh\
    i3-sensible-terminal;

systemctl enable --now lightdm;

nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager;
nix-channel --update;

nix-shell '<home-manager>' -A install;

NIXPKGS_ALLOW_UNFREE=1 nix run github:nix-community/home-manager -- switch --impure --flake .#alissonbk