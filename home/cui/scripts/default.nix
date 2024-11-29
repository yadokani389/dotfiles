{ pkgs, ... }:
let

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
  show-lyrics = pkgs.writeShellScriptBin "show-lyrics" ''
    #!/bin/bash

    # https://github.com/LanderMoerkerke/dotfiles/blob/976b9184d74592151baa702389fa01c2b885428c/.config/waybar/custom/spotify/show-lyrics.sh

    # Simple script that determines what my polybar music module prints
    # If spotify is playing it prints each lyric, if not then it prints
    # last sources title

    STATUS=$(playerctl -p spotify_player status)

    # Check if programs installed
    if ! command -v "playerctl" &>/dev/null && ! command -v "sptlrx" &>/dev/null; then
        echo "Proper programs not installed!"
        exit
    fi

    if [ "$STATUS" != "Playing" ]; then
        exit
    fi

    # Check if pipe is running
    if [ -z "$(ps aux | grep -v 'grep' | grep 'sptlrx pipe')" ]; then
        sptlrx pipe >>/tmp/lyrics &
    fi

    # Script's logic
    if [ "$STATUS" == "Playing" ]; then
        echo "$(tail -1 /tmp/lyrics)"
    fi
  '';
in {
  home.packages = [ wallpaper_random show-lyrics ];

  systemd.user.services.wallpaper-changer = {
    Unit.Description = "change wallpaper random";
    Service = {
      Type = "oneshot";
      ExecStart = "${wallpaper_random}/bin/wallpaper_random";
    };
  };

  systemd.user.timers.wallpaper-changer = {
    Unit = {
      Description = "change wallpaper random";
      Requires = [ "wallpaper-changer.service" ];
    };
    Timer = {
      Unit = "wallpaper-changer.service";
      OnBootSec = "10m";
      OnUnitActiveSec = "10m";
    };
    Install.WantedBy = [ "timers.target" ];
  };
}
