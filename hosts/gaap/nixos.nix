{ pkgs, inputs, username, ... }: {
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    tmp.useTmpfs = true;
  };

  virtualisation.vmVariant.virtualisation = {
    host.pkgs = import inputs.nixpkgs {
      system = "x86_64-linux";
      config.allowUnfree = true;
    };
    memorySize = 1024 * 16;
    cores = 12;
    graphics = false;
  };

  console.keyMap = "jp106";

  users.users."${username}" = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" ];
    hashedPassword =
      "$6$xzVNYSD7yHJuO./x$5fCLN3.ENzMJDWkgegYazIgw/NkWYC2jMSiTDqma84wjEhbYRgeDPcHb.nc55WPD3qpACqGakvM4kXHZihgly0";
  };

  programs = {
    zsh.enable = true;
    git.enable = true;
  };

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ "root" "${username}" ];
  };

  system.stateVersion = "24.05";
}
