{ inputs, pkgs, hostname, config, ... }: {
  imports = [ ./hardware-configuration.nix ../nixos.nix ];

  networking.hostName = hostname;

  console.keyMap = "jp106";

  programs.zsh.interactiveShellInit = ''
    if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
       Hyprland
    fi
  '';

  hardware.opengl.enable = true;
}
