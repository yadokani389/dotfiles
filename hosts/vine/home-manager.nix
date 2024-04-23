{ inputs, pkgs, username, system, ... }: {
  imports = [ ../../home/cui/home.nix ];

  programs.home-manager.enable = true;

  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "24.05";

    packages = with pkgs; [ xclip ];
  };
}
