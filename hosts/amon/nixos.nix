{
  pkgs,
  hostname,
  config,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../nixos.nix
    ../desktop
  ];

  time.hardwareClockInLocalTime = true;

  boot = {
    kernelPackages = pkgs.linuxPackages_6_12;
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
    binfmt.emulatedSystems = [ "aarch64-linux" ];
  };

  networking = {
    networkmanager.enable = true;
    hostName = hostname;
    firewall = {
      enable = true;
      allowedTCPPortRanges = [
        {
          from = 1714;
          to = 1764;
        } # KDE Connect
        {
          from = 1420;
          to = 1423;
        }
        {
          from = 33110;
          to = 33120;
        }
      ];
      allowedUDPPortRanges = [
        {
          from = 1714;
          to = 1764;
        }
        # KDE Connect
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
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      extraCompatPackages = [
        pkgs.proton-ge-bin
      ];
    };
  };

  virtualisation.waydroid.enable = true;

  powerManagement.cpuFreqGovernor = "ondemand";
}
