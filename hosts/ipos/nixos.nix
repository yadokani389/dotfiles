{ inputs, pkgs, hostname, config, ... }: {
  imports = [
    inputs.hyprland.nixosModules.default
    ./hardware-configuration.nix
    ../nixos.nix
    ../desktop
  ];

  networking.hostName = hostname;

  console.keyMap = "jp106";

  hardware.opengl.enable = true;

  services = {
    thermald.enable = true;
    tlp.enable = true;
  };

  programs.zsh.interactiveShellInit = ''
    if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
       Hyprland
    fi
  '';
}
