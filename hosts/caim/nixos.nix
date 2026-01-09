{
  inputs,
  pkgs,
  ...
}:
let
  my-username = "kani";
  my-hashedPassword = "$6$xzVNYSD7yHJuO./x$5fCLN3.ENzMJDWkgegYazIgw/NkWYC2jMSiTDqma84wjEhbYRgeDPcHb.nc55WPD3qpACqGakvM4kXHZihgly0";
  server-username = "procon-server";
  server-hashedPassword = "$6$8hFdyawkKpPjCu0T$CH1UjkJ6bqujsXVRNY0HxNeUPZFsE2v8CdzkQXnOVLfC3tQF1T6sMzU0Hg/aPgp9BUgPkUAxKM77.1PHZqG6b/";
  hostname = "caim";
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
    kernel.sysctl."net.ipv4.ip_forward" = 1;
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

  console.keyMap = "jp106";

  services = {
    tailscale.enable = true;
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
