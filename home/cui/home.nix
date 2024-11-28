{ inputs, pkgs, ... }: {

  imports = [ ./programs ./scripts ./themes ];

  home.packages = (with pkgs; [
    gnumake
    curl
    nix-direnv
    gh
    bat
    lazydocker
    appimage-run
    unzip
    # cava
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
    (sptlrx.overrideAttrs (old: rec {
      version = "1.2.2";
      src = pkgs.fetchFromGitHub {
        owner = "raitonoberu";
        repo = "sptlrx";
        rev = "v${version}";
        hash = "sha256-b8ALhEjolH0RH+I9HVQeOagPBi2isLNUxqKdj5u2O9s=";
      };
      vendorHash = "sha256-pExSQcYjqliZZg/91t52yk6UJ4QCbpToMpONIFUNkwc=";
      doCheck = false;
    }))
  ]) ++ [ inputs.nixvim.packages."${pkgs.system}".default ];
}
