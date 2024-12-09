{ pkgs, ... }: {

  imports = [ ./programs ./themes ];

  home.packages = with pkgs; [
    gnumake
    gh
    cava
    tty-clock
    btop
    playerctl
    neofetch
    typstyle
    tinymist
    tdf
    sptlrx
    cargo-compete
    pahcer
    evcxr
  ];
}
