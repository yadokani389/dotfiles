{
  inputs,
  pkgs,
  config,
  ...
}:
let
  my-username = "kani";
  my-hashedPassword = "$6$xzVNYSD7yHJuO./x$5fCLN3.ENzMJDWkgegYazIgw/NkWYC2jMSiTDqma84wjEhbYRgeDPcHb.nc55WPD3qpACqGakvM4kXHZihgly0";
  server-username = "procon-server";
  server-hashedPassword = "$6$8hFdyawkKpPjCu0T$CH1UjkJ6bqujsXVRNY0HxNeUPZFsE2v8CdzkQXnOVLfC3tQF1T6sMzU0Hg/aPgp9BUgPkUAxKM77.1PHZqG6b/";
  hostname = "caim";

  server-uid = config.users.users."${server-username}".uid;
in
{
  imports = [
    ./hardware-configuration.nix
    (import ../nixos.nix my-username my-hashedPassword hostname)
    ../desktop

    inputs.home-manager.nixosModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users."${my-username}" = import ./home-manager.nix my-username;
        users."${server-username}" = import ./home-manager.nix server-username;
        extraSpecialArgs = { inherit inputs; };
      };
    }
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    initrd.kernelModules = [ "joydev" ];
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

  users.users.root = {
    hashedPassword = my-hashedPassword;
  };

  users.users."${server-username}" = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "audio"
      "video"
    ];
    hashedPassword = server-hashedPassword;
  };

  nix.settings.trusted-users = [ "${server-username}" ];

  # networking.nftables.enable = true;
  # networking.nftables.ruleset = ''
  # table inet filter {
  #    chain output {
  #       type filter hook output priority 0;
  #
  #    meta skuid ${server-uid} oifname != "tailscale0" \
  #       ip daddr 100.64.0.0/10 reject
  #    }
  #   }
  #  '';

  console.keyMap = "jp106";

  services = {
    tailscale = {
      enable = true;
      useRoutingFeatures = "client";
    };
    thermald.enable = true;

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

  system.stateVersion = "25.11";
}
