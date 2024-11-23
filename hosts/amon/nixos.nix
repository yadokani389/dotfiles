{ pkgs, hostname, username, config, ... }: {
  imports = [ ./hardware-configuration.nix ../nixos.nix ../desktop ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    initrd.kernelModules = [ "joydev" ];
    kernelParams = [ "nvidia-drm.fbdev=1" ];
    tmp.useTmpfs = true;
    loader = {
      efi.canTouchEfiVariables = true;
      timeout = 1;
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        default = "saved";
        useOSProber = true;
      };
    };
  };

  networking = {
    networkmanager.enable = true;
    hostName = hostname;
    firewall = {
      enable = true;
      allowedTCPPortRanges = [{
        from = 1714;
        to = 1764;
      } # KDE Connect
        ];
      allowedUDPPortRanges = [{
        from = 1714;
        to = 1764;
      } # KDE Connect
        ];
    };
  };

  console.keyMap = "jp106";

  services = {
    tailscale.enable = true;
    xserver = {
      videoDrivers = [ "nvidia" ];
      desktopManager.gnome.enable = true;
    };
  };

  hardware = {
    graphics.enable = true;
    nvidia = {
      modesetting.enable = true;
      open = false;

      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.production;
    };
  };

  programs = {
    hyprland.enable = true;
    weylus = {
      enable = true;
      openFirewall = true;
      users = [ username ];
    };
  };

  virtualisation.waydroid.enable = true;
}
