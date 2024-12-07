{ pkgs, username, ... }: {
  imports = [ ../../home/cui/minimal.nix ];

  programs.home-manager.enable = true;

  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "24.05";

    packages = with pkgs; [ xclip ];
  };
}
