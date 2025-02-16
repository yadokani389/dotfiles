inputs:
let
  mkHome =
    {
      system,
      hostname,
      username,
      modules,
    }:
    inputs.home-manager.lib.homeManagerConfiguration {
      extraSpecialArgs = {
        inherit
          inputs
          system
          hostname
          username
          ;
      };
      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [ (import ../pkgs/default.nix) ];
      };
      modules = [
        {
          imports = modules;
          home = {
            inherit username;
            homeDirectory = "/home/${username}";
            stateVersion = "24.05";
            sessionVariables.EDITOR = "nvim";
          };
        }
      ];
    };
in
{
  home-cli-minimal = mkHome {
    system = "x86_64-linux";
    hostname = "home-minimal";
    username = "kani";
    modules = [ ./cui/minimal.nix ];
  };
  home-cli-full = mkHome {
    system = "x86_64-linux";
    hostname = "home-full";
    username = "kani";
    modules = [
      ./cui/minimal.nix
      ./cui/home.nix
    ];
  };
  home-gui = mkHome {
    system = "x86_64-linux";
    hostname = "home-gui";
    username = "kani";
    modules = [
      ./cui/minimal.nix
      ./cui/home.nix
      ./gui/home.nix
    ];
  };
}
