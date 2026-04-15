{ pkgs, ... }:
{

  imports = [
    ./programs
    ./themes
  ];

  home = {
    packages = with pkgs; [
      gh
      cava
      tdf
      mold-unwrapped
      jq
      gemini-cli
      codex
      uv
      nodejs
      fd
      unar
      evcxr
      cloudflared
      ffmpeg
      python3
      arrpc
    ];

    sessionVariables = {
      RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
    };
  };
}
