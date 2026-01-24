{
  config,
  pkgs,
  lib,
  ...
}:
let
  username = "alissonbk";
in
{
  imports = [
    ./zsh
  ];
  home.username = username;
  home.homeDirectory = lib.mkForce "/home/${username}";

  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  # Packages that were previously in users.users.packages
  home.packages = with pkgs; [
    firefox
    google-chrome
    thunderbird
    vscode
    jetbrains-toolbox
    #terminator
    alacritty
    git
  ];

  # i3 (user-level configuration)
  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3;
    config = null;
    extraConfig = builtins.readFile ./i3config;
  };
  # xdg.configFile."i3/config".text = builtins.readFile ./i3config;

  # Picom belongs here (user compositor)
  services.picom = {
    enable = true;
    fade = true;
    shadow = true;
    inactiveOpacity = 0.8;
    settings.blur.strength = 5;
  };

  # File configs
  home.file.".config/terminator/config".text = builtins.readFile ./terminatorconfig;

  home.activation.installApps = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    # Apps folder
    mkdir -p "$HOME/Apps"
    cp -r ${"../scripts"}/. "$HOME/Apps/"
    chmod +0755 "$HOME/Apps"

    # Wallpapers
    mkdir -p "$HOME/wallpapers"
    cp -r ${"$HOME/wallpapers"}/. "$HOME/wallpapers/"
    chmod +0755 "$HOME/wallpapers"
  '';
}
