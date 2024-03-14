{
  description = "My flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    nixvim.url = "github:yadokani389/nixvim-config";
  };

  outputs = { self, nixpkgs, home-manager, hyprland, nixvim, ... }:

    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        kani = lib.nixosSystem rec {
          inherit system;
          specialArgs = {
            inherit hyprland;
            inherit nixvim;
          };
          modules = [
            ./nixos/configuration.nix
            hyprland.nixosModules.default
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.kani = import ./home/home.nix;
                extraSpecialArgs = specialArgs;
              };
            }
          ];
        };
      };
    };
}
