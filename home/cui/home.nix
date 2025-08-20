{ pkgs, lib, ... }:
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
      sptlrx
      cargo-compete
      pahcer
      evcxr
      mold
      sccache
      jq
      gemini-cli
      difit
      claude-code
      uv
      nodejs
    ];

    file.".cargo/config.toml".text = ''
      [build]
      rustc-wrapper = "${lib.getExe pkgs.sccache}"
    '';

    sessionVariables = {
      RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
    };
  };
}
