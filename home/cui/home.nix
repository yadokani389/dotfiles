{ pkgs, lib, ... }: {

  imports = [ ./programs ./themes ];

  home.packages = with pkgs; [
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
  ];

  home.file.".cargo/config.toml".text = ''
    [build]
    rustc-wrapper = "${lib.getExe pkgs.sccache}"
  '';
}
