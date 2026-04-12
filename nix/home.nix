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

  home.stateVersion = "26.05";

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

  # Picom
  services.picom = {
    enable = true;
    fade = true;
    shadow = true;
    inactiveOpacity = 0.8;
    settings.blur.strength = 5;
  };

  # File configs
  #home.file.".config/terminator/config".text = builtins.readFile ./terminatorconfig;
  programs.alacritty = {
    enable = true;
  };

  home.activation.copyFiles = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    copy_dir() {
      local src="$1" dest="$HOME/$2"
      rm -rf "$dest"
      mkdir -p "$dest"
      cp -rT --no-preserve=mode "$src" "$dest"
      chmod -R 755 "$dest"
    }
    copy_file() {
      local src="$1" dest="$HOME/$2"
      rm -rf "$dest"
      cp -rT --no-preserve=mode "$src" "$dest"
      chmod -R 755 "$dest"
    }

    copy_file "${./i3config}" ".config/i3/config"
    mkdir -p "$HOME/.config/alacritty"
    copy_file "${../dotfiles/.config/alacritty/alacritty-nix.toml}" ".config/alacritty/alacritty.toml"
    copy_dir "${../scripts}"    "Apps"
    copy_dir "${../wallpapers}" "wallpapers"
  '';
}
