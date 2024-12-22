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
      };
    };
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
    thermald.enable = true;
    logind.lidSwitch = "ignore";

    xserver.desktopManager.gnome.enable = true;
  };

  hardware.graphics.enable = true;

  programs.hyprland.enable = true;

  virtualisation.waydroid.enable = true;
}
