{ inputs, pkgs, hostname, username, config, ... }: {
  imports = [ ../nixos.nix ];

  enviroment.packages = with pkgs; [ vim ];

  enviroment.etcBackupExtension = ".bak";

  system.stateVersion = "24.05";

  nix.etraOptions = ''
    experimental-features = nix-command flakes
  '';

  time.timeZone = "Tokyo/Japan";

  inputs.home-manager = {
    config = ./${hostname}/home-manager.nix;
    backupFileExtensions = "hm-bak";
    useGlobakPkgs = true;
  };
}
