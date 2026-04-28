{ pkgs, ... }:
{
  imports = [ ../../home/cui/minimal.nix ];

  nix.package = pkgs.nix;

  programs = {
    git.settings.user = {
      name = "yadokani389";
      email = "yadokani389@gmail.com";
    };
  };

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
