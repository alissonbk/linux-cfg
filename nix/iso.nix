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

  services.xserver.videoDrivers = [ "modesetting" ];
  services.spice-vdagentd.enable = false;
}
