{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.services.speech-cpp;
  model = pkgs.fetchurl {
    url = "https://huggingface.co/sakasegawa/Haas-ja-v1.0-GGUF/resolve/6b965d5007ba780585de51549d57a8c1c0d67c7e/Haas-616M-ja-v1.0-Q8_0.gguf";
    hash = "sha256-zV9gsvHEEUBLg/ykpl484wom2elRtqNGUp5l8idYr+s=";
  };
in
{
  options.services.speech-cpp.keywordsFile = lib.mkOption {
    type = lib.types.path;
    default = "/etc/speech-cpp/keywords.txt";
    description = "Absolute path to the Haas-ja vocabulary file, read by the service at startup. The service user must be able to read it if present.";
  };

  config.systemd.services.speech-cpp = {
    description = "speech.cpp Haas-ja transcription API";
    wantedBy = [ "multi-user.target" ];
    script = ''
      keywords_file=${lib.escapeShellArg (toString cfg.keywordsFile)}
      args=()
      if [[ -s "$keywords_file" ]]; then
        args+=(--asr.keywords "$(<"$keywords_file")")
      fi
      exec ${lib.getExe pkgs.speech-cpp} serve ${model} --host 127.0.0.1 --port 27831 "''${args[@]}"
    '';
    serviceConfig = {
      DynamicUser = true;
      SupplementaryGroups = [ "render" ];
      Restart = "on-failure";
      RestartSec = 5;
    };
  };
}
