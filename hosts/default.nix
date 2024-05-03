inputs:
let
  mkNixosSystem = { system, hostname, username, modules }:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs hostname username; };
      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      modules = modules
        ++ [{ nixpkgs.overlays = [ inputs.fenix.overlays.default ]; }] ++ [
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users."${username}" = import ./${hostname}/home-manager.nix;
              extraSpecialArgs = { inherit inputs system username; };
            };
          }
        ];
    };
  mkNixOnDroidSystem = { system, hostname, username, modules }:
    inputs.nix-on-droid.lib.nixOnDroidConfiguration {
      extraSpecialArgs = { inherit inputs system hostname username; };
      pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = [ inputs.nix-on-droid.overlays.default ];
      };
      inherit modules;
    };

in {
  nixosSystems = {
    amon = mkNixosSystem {
      system = "x86_64-linux";
      hostname = "amon";
      username = "kani";
      modules = [ ./amon/nixos.nix ];
    };
    ipos = mkNixosSystem {
      system = "x86_64-linux";
      hostname = "ipos";
      username = "kani";
      modules = [ ./ipos/nixos.nix ];
    };
    vine = mkNixosSystem {
      system = "x86_64-linux";
      hostname = "vine";
      username = "kani";
      modules = [ ./vine/nixos.nix inputs.nixos-wsl.nixosModules.wsl ];
    };
  };
  nixOnDroidSystems = {
    bune = mkNixOnDroidSystem {
      system = "aarch64-linux";
      hostname = "bune";
      username = "kani";
      modules = [ ./bune/nix-on-droid.nix ];
    };
  };
}
