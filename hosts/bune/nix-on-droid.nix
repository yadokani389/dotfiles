{ inputs, pkgs, username, system, ... }: {
  environment = {
    packages = with pkgs; [ vim git ];
    etcBackupExtension = ".bak";
  };

  system.stateVersion = "24.05";

  android-integration = {
    am.enable = true;
    termux-open.enable = true;
    termux-open-url.enable = true;
    termux-setup-storage.enable = true;
    xdg-open.enable = true;
  };

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  time.timeZone = "Asia/Tokyo";

  user.shell = "${pkgs.zsh}/bin/zsh";

  terminal.font = "${
      pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; }
    }/share/fonts/truetype/NerdFonts/JetBrainsMonoNerdFontMono-Regular.ttf";

  home-manager = {
    config = ./home-manager.nix;
    backupFileExtension = "hm-bak";
    useGlobalPkgs = true;
    extraSpecialArgs = { inherit inputs username system; };
  };
}
