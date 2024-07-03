{ config, lib, pkgs, ... }:

let
  cava-internal = pkgs.writeShellScriptBin "cava-internal" ''
    cava -p ~/.config/cava/config1 | sed -u 's/;//g;s/0/▁/g;s/1/▂/g;s/2/▃/g;s/3/▄/g;s/4/▅/g;s/5/▆/g;s/6/▇/g;s/7/█/g;'
  '';
  wallpaper_random = pkgs.writeShellScriptBin "wallpaper_random" ''
    if command -v swww >/dev/null 2>&1; then 

      mapfile -t output < <(swww query | awk -F ":" '{print $1}')

      cached_image_paths=()

      for monitor in "''${output[@]}"; do
        cached_image_paths+=("$(cat "$HOME/.cache/swww/$monitor")")
      done

      mapfile -t all_image_paths < <(find ~/wallpapers/*)

      list=()
      for j in "''${!output[@]}"; do
        for i in "''${!all_image_paths[@]}"; do
          for cached in "''${cached_image_paths[@]}"; do
            if [[ "''${all_image_paths[i]}" = "''${cached}" ]]; then
              unset 'all_image_paths[i]'
            fi
          done
        done
        mapfile -t -O "''${j}" list < <(printf "%s\n" "''${all_image_paths[@]}" | shuf -n1)
        cached_image_paths+=("''${list[j]}")
      done
      type=("left" "right" "top" "bottom" "wipe" "wave" "grow" "center" "any" "outer")
      for i in "''${!output[@]}"; do
        swww img "''${list[$i]}" -t "$(printf "%s\n" "''${type[@]}" | shuf -n1)" -o "''${output[$i]}"
      done
    else
      echo "swww not found"
    fi
  '';
in { home.packages = with pkgs; [ cava-internal wallpaper_random ]; }
