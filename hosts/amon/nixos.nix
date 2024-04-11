{ inputs, pkgs, hostname, config, ... }: {
  imports = [
    inputs.hyprland.nixosModules.default
    ./hardware-configuration.nix
    ../nixos.nix
    ../desktop
  ];

  networking.hostName = hostname;

  console.keyMap = "jp106";

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    nvidia = {
      modesetting.enable = true;
      open = false;

      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };

  programs.zsh.interactiveShellInit = ''
    if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
       WLR_NO_HARDWARE_CURSORS=1 Hyprland #prevents cursor disappear when using Nvidia drivers
    fi
  '';
}
