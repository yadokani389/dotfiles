{ inputs, pkgs, ... }: {

  imports = [ ./programs/zsh.nix ];

  home.packages = (with pkgs; [
    curl
    nix-direnv
    bat
    lazydocker
    lazygit
    appimage-run
    unzip
    wget
    eza
    fzf
    zoxide
    ripgrep
    typst
    any-nix-shell
    cachix
    comma
    yazi
    hstr
  ]) ++ [ inputs.nixvim.packages."${pkgs.system}".default ];
}
