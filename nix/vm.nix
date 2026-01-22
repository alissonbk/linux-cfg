{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./system.nix
  ];

  # VM config
  virtualisation.vmVariant = {
    virtualisation.resolution = {
      x = 1280;
      y = 1024;
    };
    virtualisation.qemu.options = [
      # Better display option
      "-vga virtio"
      "-display gtk,zoom-to-fit=false,show-cursor=on"
      # Enable copy/paste
      # https://www.kraxel.org/blog/2021/05/qemu-cut-paste/
      "-chardev qemu-vdagent,id=ch1,name=vdagent,clipboard=on"
      "-device virtio-serial-pci"
      "-device virtserialport,chardev=ch1,id=ch1,name=com.redhat.spice.0"
    ];
  };
}
