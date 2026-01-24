{
  lib,
  config,
  pkgs,
  ...
}:
let
  username = "alissonbk";
  locale_en = "en_US.UTF-8";
  locale_ptbr = "pt_BR.UTF-8";
in
{
  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n.defaultLocale = locale_en;

  i18n.extraLocaleSettings = {
    LANG = locale_en;
    LC_ADDRESS = locale_ptbr;
    LC_IDENTIFICATION = locale_ptbr;
    LC_MEASUREMENT = locale_ptbr;
    LC_MONETARY = locale_ptbr;
    LC_NAME = locale_en;
    LC_NUMERIC = locale_ptbr;
    LC_PAPER = locale_ptbr;
    LC_TELEPHONE = locale_ptbr;
    LC_TIME = locale_ptbr;
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
      "docker"
      "podman"
      "dialout"
      "input"
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
    displayManager.lightdm = {
      enable = true;
      greeters.gtk = {
        enable = true;
        theme.name = "Adwaita";
        iconTheme.name = "Adwaita";
        cursorTheme.name = "Adwaita";
      };
    };
  };
  # services.displayManager = {
  #   defaultSession = "none+i3";
  # };
  console.keyMap = "br-abnt2";
  services.xserver.xkb = {
    layout = "br";
    variant = "abnt2";
  };
  programs.dconf.enable = true;
  services.xserver.windowManager.i3.package = pkgs.i3;
  services.printing.enable = true; # Enable CUPS to print documents.
  services.displayManager.autoLogin.user = username;
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images

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
    sxiv
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
    adwaita-icon-theme
    gnome-themes-extra
  ];

  fonts.packages = with pkgs; [
    dejavu_fonts
    meslo-lgs-nf
    # fira-code
    noto-fonts
  ];

  # Driver stuff
  hardware.enableRedistributableFirmware = true;
  hardware.graphics.enable = true;
  hardware.bluetooth.enable = true;

  services.picom = {
    enable = true;
    fade = true;
    vSync = true;
    shadow = true;
    fadeDelta = 4;
    inactiveOpacity = 0.8;
    activeOpacity = 1;
    # glx - xrender
    backend = "glx";
    settings = {
      blur = {
        method = "dual_kawase";
        background = true;
        strength = 5;
      };
    };
  };

  system.stateVersion = "25.11";
}
