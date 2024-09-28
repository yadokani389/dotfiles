{ inputs, pkgs, ... }: {

  imports = [ ./programs ./scripts ./themes ];

  home.packages = (with pkgs; [
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
  ]) ++ [ inputs.nixvim.packages."${pkgs.system}".default ];
}
