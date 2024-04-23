{ inputs, pkgs, username, system, ... }: {
  imports = [ ../../home/cui/home.nix ];

  home = {
    # homeDirectory = "/home/${username}";
    stateVersion = "24.05";
  };
}
