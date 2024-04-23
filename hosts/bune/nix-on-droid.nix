{ inputs, pkgs, hostname, username, config, ... }: {
  environment = {
    packages = with pkgs; [ vim ];
    etcBackupExtension = ".bak";
  };

  system.stateVersion = "24.05";

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  time.timeZone = "Asia/Tokyo";

  home-manager = {
    config = ./home-manager.nix;
    backupFileExtension = "hm-bak";
    useGlobalPkgs = true;
    extraSpecialArgs = { inherit inputs username; };
  };
}
