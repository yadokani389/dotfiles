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
    OpenSiv3D.url = "github:yadokani389/OpenSiv3D/no_sse";
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = inputs: {
    nixosConfigurations = (import ./hosts inputs).nixosSystems;
    nixOnDroidConfigurations = (import ./hosts inputs).nixOnDroidSystems;
  };
}
