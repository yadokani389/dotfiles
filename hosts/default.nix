inputs:
let
  mkNixosSystem =
    {
      system,
      modules,
    }:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; };
      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          (import ../pkgs/default.nix)
        ];
      };
      inherit modules;
    };
in
{
  amon = mkNixosSystem {
    system = "x86_64-linux";
    modules = [ ./amon/nixos.nix ];
  };
  ipos = mkNixosSystem {
    system = "x86_64-linux";
    modules = [ ./ipos/nixos.nix ];
  };
  vine = mkNixosSystem {
    system = "x86_64-linux";
    modules = [
      inputs.nixos-wsl.nixosModules.wsl
      ./vine/nixos.nix
    ];
  };
}
