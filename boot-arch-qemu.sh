#!/bin/sh



qemu-system-x86_64 \
  -enable-kvm \
  -m 4G \
  -smp 4 \
  -cpu host \
  -cdrom $HOME/Downloads/archlinux-2026.04.01-x86_64.iso \
  -drive file=arch.qcow2,format=qcow2,if=virtio \
  -boot order=d \
  -display gtk \
  -net nic -net user