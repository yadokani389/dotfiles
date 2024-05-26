{ pkgs, ... }: {
  programs.spotify-player = {
    enable = true;
    settings = {
      client_id = "6a80c12de72f45ccb5061863e906b583";
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
