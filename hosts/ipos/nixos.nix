{
  inputs,
  pkgs,
  config,
  ...
}:
let
  username = "kani";
  hashedPassword = "$6$xzVNYSD7yHJuO./x$5fCLN3.ENzMJDWkgegYazIgw/NkWYC2jMSiTDqma84wjEhbYRgeDPcHb.nc55WPD3qpACqGakvM4kXHZihgly0";
  hostname = "ipos";
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

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
    initrd.kernelModules = [ "joydev" ];
    kernelParams = [
      "i915.force_probe=a7a1"
      "kvm.enable_virt_at_load=0"
    ];
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
    firewall = {
      allowedTCPPorts = [
        5900 # wayvnc
      ];
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
        } # KDE Connect
      ];
    };
  };

  console.keyMap = "jp106";

  services = {
    tailscale = {
      enable = true;
      useRoutingFeatures = "client";
    };
    thermald.enable = true;
    logind.settings.Login.HandleLidSwitch = "ignore";

    desktopManager.gnome.enable = true;
  };

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vpl-gpu-rt

      intel-compute-runtime
    ];
  };

  programs = {
    hyprland.enable = true;
    niri.enable = true;
  };

  system.stateVersion = "24.05";
}
