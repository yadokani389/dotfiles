{ username, ... }:
{
  nix.settings = {
    substituters = [
      "https://cache.nixos.org?priority=10"
      "https://nix-community.cachix.org"
      "https://yadokani389.cachix.org"
      "https://oxalica.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "yadokani389.cachix.org-1:xHw9jijQFNDKlNprHbQpXX6cVOUO4m/n2lBfx6Bq4jg="
      "oxalica.cachix.org-1:h0iRBw6tQD8+51ZvnNEBPbwLR58UD7klauDBWzBdugQ="
    ];
  };
}
