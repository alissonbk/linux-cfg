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
      "-vga qxl"
      "-device virtio-vga"
      "-display gtk,gl=off"
    ];
  };

  # Copy paste qemu - host
  services.spice-vdagentd.enable = true;
}
