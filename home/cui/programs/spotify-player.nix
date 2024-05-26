{ pkgs, ... }: {
  programs.spotify-player = {
    enable = true;
    settings = {
      notify_timeout_in_secs = 10;
      device = {
        name = "nixos";
        device_type = "computer";
        audio_cache = false;
        normalization = true;
      };
    };
  };
}
