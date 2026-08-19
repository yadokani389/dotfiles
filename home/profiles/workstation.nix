{ pkgs, ... }:
{
  # Keep shared workstation wiring in one profile so host definitions stay hardware-focused.
  imports = [
    ../shell
    ../terminal
    ../development
    ../development/nix-index.nix
    ../desktop
  ];

  home.packages = with pkgs; [
    cachix
    cava
    cloudflared
    evcxr
    ffmpeg
    fd
    gh
    ghostscript
    imagemagick
    jq
    mold-unwrapped
    nodejs
    python3
    rsrpc
    tdf
    unar
    uv
  ];
}
