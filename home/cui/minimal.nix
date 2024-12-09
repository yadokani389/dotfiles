{ inputs, pkgs, ... }: {

  imports = [ ./programs/minimal.nix ];

  home.packages = (with pkgs; [
    curl
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
    yazi
    hstr
  ]) ++ [ inputs.nixvim.packages."${pkgs.system}".default ];
}
