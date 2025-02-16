{ inputs, pkgs, ... }:
{

  imports = [ ./programs/minimal.nix ];

  home.packages =
    (with pkgs; [
      curl
      bat
      lazydocker
      lazygit
      appimage-run
      unzip
      wget
      eza
      zoxide
      ripgrep
      typst
      any-nix-shell
      cachix
      yazi
    ])
    ++ [ inputs.nixvim.packages."${pkgs.system}".default ];
}
