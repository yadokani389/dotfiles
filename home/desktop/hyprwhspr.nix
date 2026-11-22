{
  inputs,
  lib,
  pkgs,
  ...
}:
let
  hyprwhspr =
    (inputs.hyprwhspr.packages.${pkgs.stdenv.hostPlatform.system}.default.override {
      python313 = pkgs.python313 // {
        withPackages = select: pkgs.python313.withPackages (ps: select ps ++ [ ps.requests ]);
      };
    }).overrideAttrs
      (old: {
        postPatch = (old.postPatch or "") + ''
          substituteInPlace lib/src/installation.py \
            --replace-fail "return normalize_backend(backend) in ('cpu', 'pywhispercpp')" \
            "return normalize_backend(backend) in ('cpu', 'pywhispercpp', 'rest-api')"
        '';
      });
in
{
  home.packages = [
    hyprwhspr
    pkgs.speech-cpp
  ];

  xdg.configFile."hyprwhspr/config.json".text = builtins.toJSON {
    transcription_backend = "rest-api";
    rest_endpoint_url = "http://127.0.0.1:27831/v1/audio/transcriptions";
    rest_timeout = 90;
    language = "ja";
    external_bindings = true;
    recording_mode = "toggle";
  };

  systemd.user.services.hyprwhspr = {
    Unit = {
      Description = "hyprwhspr speech-to-text";
      After = [
        "graphical-session.target"
        "pipewire.service"
        "wireplumber.service"
      ];
      Wants = [
        "pipewire.service"
        "wireplumber.service"
      ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = lib.getExe hyprwhspr;
      Restart = "on-failure";
      RestartSec = 2;
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
}
