{ pkgs, ... }: {

  imports = [ ./programs ./themes ];

  home.packages = with pkgs; [
    gh
    cava
    btop
    playerctl
    tdf
    sptlrx
    cargo-compete
    pahcer
    evcxr
  ];
}
