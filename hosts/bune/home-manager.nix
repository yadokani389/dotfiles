{ inputs, pkgs, username, ... }: {
  imports = [ ../../home/cui/home.nix ];

  home = {
    # homeDirectory = "/home/${username}";
    stateVersion = "24.05";
  };
}
