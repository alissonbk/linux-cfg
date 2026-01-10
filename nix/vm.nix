# Build this VM with nix build  ./#nixosConfigurations.vm.config.system.build.vm
# Then run is with: ./result/bin/run-nixos-vm
# To be able to connect with ssh enable port forwarding with:
# QEMU_NET_OPTS="hostfwd=tcp::2222-:22" ./result/bin/run-nixos-vm
# Then connect with ssh -p 2222 guest@localhost
{
  lib,
  config,
  pkgs,
  ...
}:
let
  username = "alisson";
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

  # User with wheel permission
  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [
      firefox
      google-chrome
      thunderbird
      discord
      kubectl
      docker
      vscode
      jetbrains-toolbox
      alacritty
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
    terminator
    flameshot
    i3lock
    pulsemixer
    spotify
    gnome-calculator
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

  system.stateVersion = "26.05";
}
