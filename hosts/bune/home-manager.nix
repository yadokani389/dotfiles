{ pkgs, ... }:
{
  imports = [ ../../home/cui/minimal.nix ];

  nix.package = pkgs.nix;

  home.stateVersion = "26.05";
  home.packages = with pkgs; [
    ps
    wol
    findutils
    which
    gnused
    gnugrep
    openssh
    gawk
  ];
}
