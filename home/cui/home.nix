{ inputs, pkgs, system, ... }: {

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
    tty-clock
    eza
    btop
    fzf
    zoxide
    playerctl
    neofetch
    ripgrep
    typst

    inputs.nixvim.packages."${system}".default

    #development
    cmake
    ninja
    pkgconf
    go
    gopls
    gcc
    nodejs
    (fenix.complete.withComponents [
      "cargo"
      "clippy"
      "rust-src"
      "rustc"
      "rustfmt"
    ])
    rust-analyzer-nightly
  ];
}
