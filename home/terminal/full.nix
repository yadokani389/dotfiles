{ pkgs, ... }:
{
  imports = [
    ./minimal.nix
    ../development/nix-index.nix
  ];

  home.packages = with pkgs; [
    cachix
    cloudflared
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
