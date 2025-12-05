{ pkgs, ... }:
{

  imports = [
    ./programs
    ./themes
  ];

  home = {
    packages = with pkgs; [
      git
      gh
      cava
      playerctl
      tdf
      cargo-compete
      pahcer
      evcxr
      mold
      jq
      gemini-cli
      codex
      uv
      nodejs
      fd
      unar
    ];

    sessionVariables = {
      RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
    };
  };
}
