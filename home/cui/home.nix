{ inputs, pkgs, ... }: {

  imports = [ ./programs ./scripts ./themes ];

  home.packages = with pkgs; [
    ranger
    gnumake
    curl
    nix-direnv
    gh
    bat
    lazydocker
    appimage-run
    unzip
    cava
    wget
    wl-clipboard
    tty-clock
    eza
    btop
    tokyo-night-gtk
    fzf
    zoxide
    playerctl
    sptlrx
    neofetch
    ripgrep

    inputs.nixvim.packages."x86_64-linux".default

    #development
    cmake
    ninja
    pkgconf
    go
    gopls
    gcc
    nodejs
    inputs.OpenSiv3D.packages."x86_64-linux".default
  ];
}
