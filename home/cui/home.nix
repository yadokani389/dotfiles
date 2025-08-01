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
      btop
      playerctl
      tdf
      sptlrx
      cargo-compete
      pahcer
      evcxr
      mold
      sccache
      jq
      difit
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
