{ inputs, pkgs, hostname, username, config, ... }: {
  imports = [
    inputs.hyprland.nixosModules.default
    ./hardware-configuration.nix
    ../nixos.nix
    ../desktop
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    initrd.kernelModules = [ "joydev" ];
    kernelParams = [ "nvidia-drm.fbdev=1" ];
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
  };

  console.keyMap = "jp106";

  services = {
    xserver.videoDrivers = [ "nvidia" ];
    # tailscale.enable = true;
  };

  hardware = {
    graphics.enable = true;
    nvidia = {
      modesetting.enable = true;
      open = false;

      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };

  programs.hyprland.enable = true;

  programs.zsh.interactiveShellInit = ''
    if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
       WLR_NO_HARDWARE_CURSORS=1 Hyprland #prevents cursor disappear when using Nvidia drivers
    fi
  '';
}
