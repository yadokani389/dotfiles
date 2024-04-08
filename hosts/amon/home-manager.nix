{ inputs, pkgs, username, ... }: {
  imports = [ ../../home/home.nix ];

  wayland.windowManager.hyprland.settings = {
    monitor = [ "HDMI-A-1,1920x1080@75,0x0,1" "DP-1,1920x1080@75,1920x0,1" ];
    input.kb_layout = "jp";
  };

  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "24.05";

    sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "firefox";
      TERMINAL = "kitty";
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      LIBVA_DRIVER_NAME = "nvidia"; # hardware acceleration
      __GL_VRR_ALLOWED = "1";
      WLR_NO_HARDWARE_CURSORS = "1";
      WLR_RENDERER_ALLOW_SOFTWARE = "1";
      CLUTTER_BACKEND = "wayland";
      WLR_RENDERER = "vulkan";

      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
    };
  };
}
