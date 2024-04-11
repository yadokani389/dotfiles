{ inputs, pkgs, hostname, config, ... }: {
  imports = [ ./hardware-configuration.nix ../nixos.nix ];

  console.keyMap = "jp106";
}
