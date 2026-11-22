{ lib, pkgs, ... }:
let
  model = pkgs.fetchurl {
    url = "https://huggingface.co/sakasegawa/Haas-ja-v1.0-GGUF/resolve/6b965d5007ba780585de51549d57a8c1c0d67c7e/Haas-616M-ja-v1.0-Q8_0.gguf";
    hash = "sha256-zV9gsvHEEUBLg/ykpl484wom2elRtqNGUp5l8idYr+s=";
  };
in
{
  systemd.services.speech-cpp = {
    description = "speech.cpp Haas-ja transcription API";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${lib.getExe pkgs.speech-cpp} serve ${model} --host 127.0.0.1 --port 27831";
      DynamicUser = true;
      SupplementaryGroups = [ "render" ];
      Restart = "on-failure";
      RestartSec = 5;
    };
  };
}
