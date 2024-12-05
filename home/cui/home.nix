{ inputs, pkgs, ... }: {

  imports = [ ./programs ./themes ];

  home.packages = (with pkgs; [
    gnumake
    curl
    nix-direnv
    gh
    bat
    lazydocker
    lazygit
    appimage-run
    unzip
    cava
    wget
    tty-clock
    eza
    btop
    fzf
    zoxide
    playerctl
    neofetch
    ripgrep
    typst
    typstyle
    tinymist
    any-nix-shell
    cachix
    tdf
    comma
    sptlrx
    cargo-compete
    pahcer
    yazi
    hstr
  ]) ++ [ inputs.nixvim.packages."${pkgs.system}".default ];
}
