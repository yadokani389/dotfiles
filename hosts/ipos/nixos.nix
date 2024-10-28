{ pkgs, hostname, ... }: {
  imports = [ ./hardware-configuration.nix ../nixos.nix ../desktop ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    initrd.kernelModules = [ "joydev" ];
    kernelParams = [ "i915.force_probe=a7a1" ];
    tmp.useTmpfs = true;
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        default = "saved";
        useOSProber = true;
        configurationLimit = 5;
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

  services.tailscale.enable = true;

  hardware.graphics.enable = true;

  services = {
    thermald.enable = true;
    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "performance";

        CPU_ENERGY_PERF_POLICY_ON_BAT = "performance";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 100;

        STOP_CHARGE_THRESH_BAT0 = 90;
      };
    };
    logind.lidSwitch = "ignore";

    xserver.desktopManager.gnome.enable = true;
  };

  programs.hyprland.enable = true;

  virtualisation.waydroid.enable = true;
}
