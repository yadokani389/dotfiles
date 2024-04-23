{ inputs, pkgs, hostname, username, config, system, ... }: {
  environment = {
    packages = with pkgs; [ vim ];
    etcBackupExtension = ".bak";
  };

  system.stateVersion = "24.05";

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
