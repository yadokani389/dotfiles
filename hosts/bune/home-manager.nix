{ pkgs, ... }: {
  imports = [ ../../home/cui/home.nix ];

  home.stateVersion = "24.05";

  home.packages = with pkgs; [ gnused gnugrep openssh gawk ps wol ];
}
