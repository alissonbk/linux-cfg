#!/bin/bash


pacman -S xorg-server\
    xorg-xinit\
    lightdm\
    lightdm-gtk-greeter\
    i3-wm\
    dmenu\
    i3status\
    i3lock\
    xterm;

systemctl enable --now lightdm;