{
  inputs,
  pkgs,
  system,
  ...
}:
{

  imports = [ ./programs/minimal.nix ];

  home.packages =
    (with pkgs; [
      curl
      bat
      lazygit
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
    ++ [ inputs.nvf.packages."${system}".default ];
}
