{
  wayland.windowManager.hyprland.settings = {
    env = [
      "GTK_IM_MODULE, fcitx"
      "QT_IM_MODULE, fcitx"
      "XMODIFIERS, @im=fcitx"
    ];
    exec-once = [
      "hyprctl setcursor Bibata-Modern-Classic 24"
      "dunst"
      "swww init & sleep 0.5 && wallpaper_random"
    ];
    exec = [
      "pkill waybar & sleep 0.5 && waybar"
    ];
    source = [
      "/home/kani/.config/hypr/colors"
    ];
    monitor = [
      "HDMI-A-1,1920x1080@75,0x0,1"
      "DP-1,1920x1080@75,1920x0,1"
    ];
    windowrule = [
      "float,^(pavucontrol)$"
    ];
    windowrulev2 = [
      "opacity 0.8,class:^(kitty)$"
    ];
    input = {
      kb_layout = "jp";
      follow_mouse = 1;
      sensitivity = 0;
      touchpad = {
        natural_scroll = false;
      };
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
      blur = {
        enabled = true;
        size = 7;
        passes = 4;
        new_optimizations = true;
      };
      drop_shadow = true;
      shadow_range = 4;
      shadow_render_power = 3;
      "col.shadow" = "rgba(1a1a1aee)";
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
      new_is_master = true;
    };
    gestures = {
      workspace_swipe = false;
    };
  };
}
