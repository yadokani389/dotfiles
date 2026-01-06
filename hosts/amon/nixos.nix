{
  inputs,
  pkgs,
  config,
  ...
}:
let
  username = "kani";
  hashedPassword = "$6$xzVNYSD7yHJuO./x$5fCLN3.ENzMJDWkgegYazIgw/NkWYC2jMSiTDqma84wjEhbYRgeDPcHb.nc55WPD3qpACqGakvM4kXHZihgly0";
  hostname = "amon";
in
{
  imports = [
    ./hardware-configuration.nix
    (import ../nixos.nix username hashedPassword hostname)
    ../desktop

    inputs.home-manager.nixosModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users."${username}" = import ./home-manager.nix username;
        extraSpecialArgs = { inherit inputs; };
      };
    }
  ];

  time.hardwareClockInLocalTime = true;

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
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
    firewall = {
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
        {
          from = 59100;
          to = 59100;
        } # AudioRelay
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
    xserver.videoDrivers = [ "nvidia" ];
    desktopManager.gnome.enable = true;
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
    niri.enable = true;
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

  system.stateVersion = "25.05";
}
