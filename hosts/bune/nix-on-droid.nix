{
  inputs,
  pkgs,
  ...
}:
{
  system.stateVersion = "24.05";

  android-integration = {
    am.enable = true;
    termux-open.enable = true;
    termux-setup-storage.enable = true;
    xdg-open.enable = true;
  };

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  time.timeZone = "Asia/Tokyo";

  user.shell = "${pkgs.zsh}/bin/zsh";

  terminal.font = "${pkgs.nerd-fonts.fira-code}/share/fonts/truetype/NerdFonts/FiraCode/FiraCodeNerdFontMono-Regular.ttf";

  home-manager = {
    config = ./home-manager.nix;
    backupFileExtension = "bak";
    useGlobalPkgs = true;
    extraSpecialArgs = { inherit inputs; };
  };
}
