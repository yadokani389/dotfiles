{ config, lib, pkgs, ... }:

let
    cava-internal = pkgs.writeShellScriptBin "cava-internal" ''
    cava -p ~/.config/cava/config1 | sed -u 's/;//g;s/0/▁/g;s/1/▂/g;s/2/▃/g;s/3/▄/g;s/4/▅/g;s/5/▆/g;s/6/▇/g;s/7/█/g;'
  '';
    rofiWindow = pkgs.writeShellScriptBin "rofiWindow" ''
#!/usr/bin/env bash
## Run
rofi \
    -show drun \
    -theme "$HOME/.config/rofi/theme.rasi"
  '';
  wallpaper_random = pkgs.writeShellScriptBin "wallpaper_random" ''
    if command -v swww >/dev/null 2>&1; then 
        swww img $(ls ~/wallpapers/* -d | shuf -n1) --transition-type simple
    fi
  '';
in
{
  home.packages = with pkgs; [
    cava-internal
    rofiWindow
    wallpaper_random
  ];
}
