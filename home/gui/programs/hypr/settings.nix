{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "hyprctl setcursor Bibata-Modern-Classic 24"
      "dunst"
      "swww-daemon & sleep 1 && wallpaper_random"
    ];
    exec = [ "pkill waybar & sleep 0.5 && waybar" ];
    source = [ "/home/kani/.config/hypr/colors" ];
    windowrule = [
      "noanim, class:^(flameshot)$"
      "fullscreenstate, class:(flameshot), title:(flameshot)"
      "float, class:^(flameshot)$"
      "move 0 0, class:^(flameshot)$"
      "pin, class:^(flameshot)$"
      "monitor 0, class:^(flameshot)$"
      "float, class:^(umegaemochi)$"
      "float, class:^(umegaemochi-control)$"
      "float, class:^(Waydroid)$"
    ];
    input = {
      follow_mouse = 1;
      sensitivity = 0.3;
      touchpad.natural_scroll = true;
    };
    general = {
      gaps_in = 5;
      gaps_out = 10;
      border_size = 2;
      "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
      "col.inactive_border" = "rgba(595959aa)";
    };
    decoration = {
      rounding = 5;
      blur.enabled = true;
      shadow = {
        enabled = true;
        range = 4;
        render_power = 3;
        color = "rgba(1a1a1aee)";
      };
    };
    animations = {
      bezier = "ease,0.4,0.02,0.21,1";
      animation = [
        "windows, 1, 3.5, ease, slide"
        "windowsOut, 1, 3.5, ease, slide"
        "border, 1, 6, default"
        "fade, 1, 3, ease"
        "workspaces, 1, 3.5, ease"
      ];
    };
    master = {
      new_status = "master";
    };
    gestures = {
      workspace_swipe = false;
    };
    misc = {
      focus_on_activate = true;
    };
    group = {
      "col.border_active" = "rgba(cc77ffee) rgba(8877ffee) 45deg";
      "col.border_inactive" = "rgba(595959aa)";
      groupbar.enabled = false;
    };
  };
}
