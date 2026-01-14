{
  lib,
  config,
  pkgs,
  ...
}:
let
  username = "alissonbk";
in
{
  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # networking
  networking.networkmanager.enable = true;
  networking.hostName = username;
  networking.wireless.enable = true; # wpa_supplicant

  users.groups.${username} = { };

  # User with wheel permission
  users.users.${username} = {
    isNormalUser = true;
    description = username;
    group = username;
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true; # because the shell is imported from the home.nix
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };
  security.sudo.wheelNeedsPassword = false;

  # X configuration
  services.xserver = {
    enable = true;
    desktopManager = {
      xterm.enable = false;
    };
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu
        i3status
        i3lock
        i3blocks
      ];
    };
  };
  services.displayManager = {
    defaultSession = "none+i3";
  };
  console.keyMap = "br-abnt2";
  services.xserver.xkb = {
    layout = "br";
    variant = "abnt2";
  };
  programs.dconf.enable = true;
  services.xserver.windowManager.i3.package = pkgs.i3;
  services.xserver.videoDrivers = [ "qxl" ]; # for vm
  services.printing.enable = true; # Enable CUPS to print documents.
  services.displayManager.autoLogin.user = username;
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images

  # For copy/paste to work
  services.spice-vdagentd.enable = true;

  # Enable ssh
  services.sshd.enable = true;

  # Included packages here
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    dig
    net-tools
    wget
    vim
    curl
    cmatrix
    neofetch
    rofi
    thunar
    htop
    git
    ristretto
    feh
    lxappearance
    imagemagick
    zip
    jq
    unzip
    qemu_kvm
    nitrogen
    redshift
    flameshot
    i3lock
    pulsemixer
    spotify
    gnome-calculator
    htop
    bat
    bat-extras.batdiff
    bat-extras.batman
    bat-extras.batgrep
    eza
    discord
    unzip
    zip
    ripgrep
    kubectl
    podman
    fzf
    git-credential-oauth
  ];

  fonts.packages = with pkgs; [
    dejavu_fonts
    meslo-lgs-nf
    # fira-code
    noto-fonts
  ];

  services.picom = {
    enable = true;
    fade = true;
    #    vSync = true;
    shadow = true;
    fadeDelta = 4;
    inactiveOpacity = 0.8;
    activeOpacity = 1;
    #    backend = "glx";
    settings = {
      blur = {
        #method = "dual_kawase";
        #	background = true;
        strength = 5;
      };
    };
  };

  system.stateVersion = "25.11";
}
