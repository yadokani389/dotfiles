{ inputs, pkgs, username, ... }: {
  imports = [ ../../home/cui/home.nix ];

  home = {
    inherit username;
    # homeDirectory = "/home/${username}";
    stateVersion = "24.05";
  };
}
