{
  wayland.windowManager.hyprland.settings = {
    "$mainMod" = "SUPER";
    bind = [
      "$mainMod, G, fullscreen"
      "$mainMod, RETURN, exec, kitty"
      "$mainMod, C, killactive"
      "$mainMod, V, togglefloating"
      "$mainMod, F, exec, fuzzel"
      "$mainMod, B, exec, pkill -SIGUSR1 waybar"

      ", Print, exec, grimblast --notify copy area"
      ''
        $mainMod, Print, exec, grimblast --notify copysave area "$HOME/Screenshots/$(date +%Y-%m-%dT%H:%M:%S).png"''
      ''
        $mainMod SHIFT, s, exec, grimblast --notify copysave area "$HOME/Screenshots/$(date +%Y-%m-%dT%H:%M:%S).png"''

      # Move focus with mainMod + arrow keys
      "$mainMod, left, movefocus, l"
      "$mainMod, right, movefocus, r"
      "$mainMod, up, movefocus, u"
      "$mainMod, down, movefocus, d"

      "$mainMod, H, movefocus, l"
      "$mainMod, L, movefocus, r"
      "$mainMod, K, movefocus, u"
      "$mainMod, J, movefocus, d"

      # Move window
      "$mainMod SHIFT, H, movewindow, l"
      "$mainMod SHIFT, L, movewindow, r"
      "$mainMod SHIFT, K, movewindow, u"
      "$mainMod SHIFT, J, movewindow, d"

      # Switch workspaces with mainMod + [0-9]
      "$mainMod, 1, workspace, 1"
      "$mainMod, 2, workspace, 2"
      "$mainMod, 3, workspace, 3"
      "$mainMod, 4, workspace, 4"
      "$mainMod, 5, workspace, 5"
      "$mainMod, 6, workspace, 6"
      "$mainMod, 7, workspace, 7"
      "$mainMod, 8, workspace, 8"
      "$mainMod, 9, workspace, 9"
      "$mainMod, 0, workspace, 10"

      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      "$mainMod SHIFT, 1, movetoworkspace, 1"
      "$mainMod SHIFT, 2, movetoworkspace, 2"
      "$mainMod SHIFT, 3, movetoworkspace, 3"
      "$mainMod SHIFT, 4, movetoworkspace, 4"
      "$mainMod SHIFT, 5, movetoworkspace, 5"
      "$mainMod SHIFT, 6, movetoworkspace, 6"
      "$mainMod SHIFT, 7, movetoworkspace, 7"
      "$mainMod SHIFT, 8, movetoworkspace, 8"
      "$mainMod SHIFT, 9, movetoworkspace, 9"
      "$mainMod SHIFT, 0, movetoworkspace, 10"

      # Scroll through existing workspaces with mainMod + scroll
      "$mainMod, mouse_down, workspace, e+1"
      "$mainMod, mouse_up, workspace, e-1"

      ",XF86AudioMicMute,exec,pamixer --default-source -t"
      ",XF86MonBrightnessDown,exec,light -U 20"
      ",XF86MonBrightnessUp,exec,light -A 20"
      ",XF86AudioMute,exec,pamixer -t"
      ",XF86AudioLowerVolume,exec,pamixer -d 5"
      ",XF86AudioRaiseVolume,exec,pamixer -i 5"
      ",XF86AudioPlay,exec,playerctl play-pause"
      ",XF86AudioPause,exec,playerctl play-pause"
      ",XF86MonBrightnessUp,exec,brightnessctl s +10%"
      ",XF86MonBrightnessDown,exec,brightnessctl s 10%-"

      "SUPER,Tab,cyclenext"
      "SUPER,Tab,bringactivetotop"
    ];
    bindm = [
      # Move/resize windows with mainMod + LMB/RMB and dragging
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
      "ALT, mouse:272, resizewindow"
    ];
  };
}
