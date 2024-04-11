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
      modules = modules ++ [
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users."${username}" = import ./${hostname}/home-manager.nix;
            extraSpecialArgs = { inherit inputs username; };
          };
        }
      ];
    };

in {
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
    modules = [ ./vine/nixos.nix ];
  };
}
