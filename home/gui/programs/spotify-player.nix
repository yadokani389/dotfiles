{ pkgs, ... }: {
  programs.spotify-player = {
    enable = true;
    settings = {
      device = {
        name = "nixos";
        device_type = "computer";
        audio_cache = false;
        normalization = true;
      };
    };
  };
}
