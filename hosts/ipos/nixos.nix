{ inputs, pkgs, hostname, config, ... }: {
  imports = [
    inputs.hyprland.nixosModules.default
    ./hardware-configuration.nix
    ../nixos.nix
    ../desktop
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    initrd.kernelModules = [ "joydev" ];
    kernelParams = [ "i915.force_probe=a7a1" ];
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
  };

  console.keyMap = "jp106";

  hardware.opengl.enable = true;

  services = {
    thermald.enable = true;
    tlp.enable = true;
  };

  programs.hyprland.enable = true;

  programs.zsh.interactiveShellInit = ''
    if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
       Hyprland
    fi
  '';
}
