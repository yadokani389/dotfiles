username:
{ pkgs, ... }:
{
  imports = [ ../../home/cui/minimal.nix ];

  programs.home-manager.enable = true;

  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "26.05";

    packages = with pkgs; [ xclip ];
  };
}
