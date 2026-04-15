inputs:
let
  mkNixosSystem =
    {
      system,
      modules,
      cudaSupport ? false,
    }:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; };
      pkgs = import inputs.nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          inherit cudaSupport;
        };
        overlays = [
          inputs.nur-yadokani.overlays.nur
        ];
      };
      inherit modules;
    };
  mkNixOnDroidSystem =
    {
      system,
      modules,
    }:
    inputs.nix-on-droid.lib.nixOnDroidConfiguration {
      extraSpecialArgs = { inherit inputs; };
      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;

        overlays = [
          inputs.nur-yadokani.overlays.nur
        ];
      };
      inherit modules;
    };
in
{
  nixosConfigurations = {
    amon = mkNixosSystem {
      system = "x86_64-linux";
      modules = [ ./amon/nixos.nix ];
      cudaSupport = true;
    };
    ipos = mkNixosSystem {
      system = "x86_64-linux";
      modules = [ ./ipos/nixos.nix ];
    };
    caim = mkNixosSystem {
      system = "x86_64-linux";
      modules = [ ./caim/nixos.nix ];
    };
  };
  nixOnDroidConfigurations = {
    bune = mkNixOnDroidSystem {
      system = "aarch64-linux";
      modules = [ ./bune/nix-on-droid.nix ];
    };
  };
}
