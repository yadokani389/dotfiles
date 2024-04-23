{ inputs, pkgs, hostname, username, config, ... }: {
  imports = [ ../nixos.nix ];

  environment.packages = with pkgs; [ vim ];

  environment.etcBackupExtension = ".bak";

  system.stateVersion = "24.05";

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  time.timeZone = "Tokyo/Japan";

  home-manager = {
    config = ./home-manager.nix;
    backupFileExtension = "hm-bak";
    useGlobalPkgs = true;
    extraSpecialArgs = { inherit inputs username; };
  };
}
