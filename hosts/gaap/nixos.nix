{ pkgs, inputs, hostname, username, ... }: {
  # imports = [ ../nixos.nix ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    tmp.useTmpfs = true;
  };

  virtualisation.vmVariant.virtualisation.host.pkgs = import inputs.nixpkgs {
    system = "x86_64-linux";
    config.allowUnfree = true;
    overlays = [ (import ../../pkgs/default.nix) ];
  };

  console.keyMap = "jp106";

  users.users."${username}" = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "audio" "video" ];
    hashedPassword =
      "$6$xzVNYSD7yHJuO./x$5fCLN3.ENzMJDWkgegYazIgw/NkWYC2jMSiTDqma84wjEhbYRgeDPcHb.nc55WPD3qpACqGakvM4kXHZihgly0";
  };

  programs = {
    zsh.enable = true;
    git.enable = true;
  };

  networking.hostName = hostname;

  nix = {
    package = pkgs.lix;

    settings = {
      auto-optimise-store = true;
      keep-outputs = true;
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "root" "${username}" ];

      substituters = [
        "https://cache.nixos.org?priority=10"
        "https://nix-community.cachix.org"
        "https://yadokani389.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "yadokani389.cachix.org-1:xHw9jijQFNDKlNprHbQpXX6cVOUO4m/n2lBfx6Bq4jg="
      ];
    };
  };

  system.stateVersion = "24.05";
}
